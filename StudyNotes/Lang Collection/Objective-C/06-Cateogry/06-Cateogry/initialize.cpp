//
//  initialize.cpp
//  06-Cateogry
//
//  Created by 朱双泉 on 2019/5/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#include <stdio.h>

void callInitialize(Class cls)
{
    ((void(*)(Class, SEL))objc_msgSend)(cls, SEL_initialize);
    asm("");
}

void _class_initialize(Class cls)
{
    assert(!cls->isMetaClass());
    
    Class supercls;
    bool reallyInitialize = NO;
    
    // Make sure super is done initializing BEFORE beginning to initialize cls.
    // See note about deadlock above.
    supercls = cls->superclass;
    if (supercls  &&  !supercls->isInitialized()) {
        _class_initialize(supercls);
    }
    
    // Try to atomically set CLS_INITIALIZING.
    {
        monitor_locker_t lock(classInitLock);
        if (!cls->isInitialized() && !cls->isInitializing()) {
            cls->setInitializing();
            reallyInitialize = YES;
        }
    }
    
    if (reallyInitialize) {
        // We successfully set the CLS_INITIALIZING bit. Initialize the class.
        
        // Record that we're initializing this class so we can message it.
        _setThisThreadIsInitializingClass(cls);
        
        if (MultithreadedForkChild) {
            // LOL JK we don't really call +initialize methods after fork().
            performForkChildInitialize(cls, supercls);
            return;
        }
        
        // Send the +initialize message.
        // Note that +initialize is sent to the superclass (again) if
        // this class doesn't implement +initialize. 2157218
        if (PrintInitializing) {
            _objc_inform("INITIALIZE: thread %p: calling +[%s initialize]",
                         pthread_self(), cls->nameForLogging());
        }
        
        // Exceptions: A +initialize call that throws an exception
        // is deemed to be a complete and successful +initialize.
        //
        // Only __OBJC2__ adds these handlers. !__OBJC2__ has a
        // bootstrapping problem of this versus CF's call to
        // objc_exception_set_functions().
#if __OBJC2__
        @try
#endif
        {
            callInitialize(cls);
            
            if (PrintInitializing) {
                _objc_inform("INITIALIZE: thread %p: finished +[%s initialize]",
                             pthread_self(), cls->nameForLogging());
            }
        }
#if __OBJC2__
        @catch (...) {
            if (PrintInitializing) {
                _objc_inform("INITIALIZE: thread %p: +[%s initialize] "
                             "threw an exception",
                             pthread_self(), cls->nameForLogging());
            }
            @throw;
        }
        @finally
#endif
        {
            // Done initializing.
            lockAndFinishInitializing(cls, supercls);
        }
        return;
    }
    
    else if (cls->isInitializing()) {
        // We couldn't set INITIALIZING because INITIALIZING was already set.
        // If this thread set it earlier, continue normally.
        // If some other thread set it, block until initialize is done.
        // It's ok if INITIALIZING changes to INITIALIZED while we're here,
        //   because we safely check for INITIALIZED inside the lock
        //   before blocking.
        if (_thisThreadIsInitializingClass(cls)) {
            return;
        } else if (!MultithreadedForkChild) {
            waitForInitializeToComplete(cls);
            return;
        } else {
            // We're on the child side of fork(), facing a class that
            // was initializing by some other thread when fork() was called.
            _setThisThreadIsInitializingClass(cls);
            performForkChildInitialize(cls, supercls);
        }
    }
    
    else if (cls->isInitialized()) {
        // Set CLS_INITIALIZING failed because someone else already
        //   initialized the class. Continue normally.
        // NOTE this check must come AFTER the ISINITIALIZING case.
        // Otherwise: Another thread is initializing this class. ISINITIALIZED
        //   is false. Skip this clause. Then the other thread finishes
        //   initialization and sets INITIALIZING=no and INITIALIZED=yes.
        //   Skip the ISINITIALIZING clause. Die horribly.
        return;
    }
    
    else {
        // We shouldn't be here.
        _objc_fatal("thread-safe class init in objc runtime is buggy!");
    }
}


IMP lookUpImpOrForward(Class cls, SEL sel, id inst,
                       bool initialize, bool cache, bool resolver)
{
    IMP imp = nil;
    bool triedResolver = NO;
    
    runtimeLock.assertUnlocked();
    
    // Optimistic cache lookup
    if (cache) {
        imp = cache_getImp(cls, sel);
        if (imp) return imp;
    }
    
    // runtimeLock is held during isRealized and isInitialized checking
    // to prevent races against concurrent realization.
    
    // runtimeLock is held during method search to make
    // method-lookup + cache-fill atomic with respect to method addition.
    // Otherwise, a category could be added but ignored indefinitely because
    // the cache was re-filled with the old value after the cache flush on
    // behalf of the category.
    
    runtimeLock.read();
    
    if (!cls->isRealized()) {
        // Drop the read-lock and acquire the write-lock.
        // realizeClass() checks isRealized() again to prevent
        // a race while the lock is down.
        runtimeLock.unlockRead();
        runtimeLock.write();
        
        realizeClass(cls);
        
        runtimeLock.unlockWrite();
        runtimeLock.read();
    }
    
    if (initialize  &&  !cls->isInitialized()) {
        runtimeLock.unlockRead();
        _class_initialize (_class_getNonMetaClass(cls, inst));
        runtimeLock.read();
        // If sel == initialize, _class_initialize will send +initialize and
        // then the messenger will send +initialize again after this
        // procedure finishes. Of course, if this is not being called
        // from the messenger then it won't happen. 2778172
    }
    
    
retry:
    runtimeLock.assertReading();
    
    // Try this class's cache.
    
    imp = cache_getImp(cls, sel);
    if (imp) goto done;
    
    // Try this class's method lists.
    {
        Method meth = getMethodNoSuper_nolock(cls, sel);
        if (meth) {
            log_and_fill_cache(cls, meth->imp, sel, inst, cls);
            imp = meth->imp;
            goto done;
        }
    }
    
    // Try superclass caches and method lists.
    {
        unsigned attempts = unreasonableClassCount();
        for (Class curClass = cls->superclass;
             curClass != nil;
             curClass = curClass->superclass)
        {
            // Halt if there is a cycle in the superclass chain.
            if (--attempts == 0) {
                _objc_fatal("Memory corruption in class list.");
            }
            
            // Superclass cache.
            imp = cache_getImp(curClass, sel);
            if (imp) {
                if (imp != (IMP)_objc_msgForward_impcache) {
                    // Found the method in a superclass. Cache it in this class.
                    log_and_fill_cache(cls, imp, sel, inst, curClass);
                    goto done;
                }
                else {
                    // Found a forward:: entry in a superclass.
                    // Stop searching, but don't cache yet; call method
                    // resolver for this class first.
                    break;
                }
            }
            
            // Superclass method list.
            Method meth = getMethodNoSuper_nolock(curClass, sel);
            if (meth) {
                log_and_fill_cache(cls, meth->imp, sel, inst, curClass);
                imp = meth->imp;
                goto done;
            }
        }
    }
    
    // No implementation found. Try method resolver once.
    
    if (resolver  &&  !triedResolver) {
        runtimeLock.unlockRead();
        _class_resolveMethod(cls, sel, inst);
        runtimeLock.read();
        // Don't cache the result; we don't hold the lock so it may have
        // changed already. Re-do the search from scratch instead.
        triedResolver = YES;
        goto retry;
    }
    
    // No implementation found, and method resolver didn't help.
    // Use forwarding.
    
    imp = (IMP)_objc_msgForward_impcache;
    cache_fill(cls, sel, imp, inst);
    
done:
    runtimeLock.unlockRead();
    
    return imp;
}


IMP lookUpImpOrNil(Class cls, SEL sel, id inst,
                   bool initialize, bool cache, bool resolver)
{
    IMP imp = lookUpImpOrForward(cls, sel, inst, initialize, cache, resolver);
    if (imp == _objc_msgForward_impcache) return nil;
    else return imp;
}

Method class_getInstanceMethod(Class cls, SEL sel)
{
    if (!cls  ||  !sel) return nil;
    
    // This deliberately avoids +initialize because it historically did so.
    
    // This implementation is a bit weird because it's the only place that
    // wants a Method instead of an IMP.
    
#warning fixme build and search caches
    
    // Search method lists, try method resolver, etc.
    lookUpImpOrNil(cls, sel, nil,
                   NO/*initialize*/, NO/*cache*/, YES/*resolver*/);
    
#warning fixme build and search caches
    
    return _class_getMethod(cls, sel);
}

Method class_getClassMethod(Class cls, SEL sel)
{
    if (!cls  ||  !sel) return nil;
    
    return class_getInstanceMethod(cls->getMeta(), sel);
}

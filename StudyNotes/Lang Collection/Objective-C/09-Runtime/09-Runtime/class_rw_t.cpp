//
//  class_rw_t.cpp
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#include <stdio.h>

static Class realizeClass(Class cls)
{
    runtimeLock.assertWriting();
    
    const class_ro_t *ro;
    class_rw_t *rw;
    Class supercls;
    Class metacls;
    bool isMeta;
    
    if (!cls) return nil;
    if (cls->isRealized()) return cls;
    assert(cls == remapClass(cls));
    
    // fixme verify class is not in an un-dlopened part of the shared cache?
    
    ro = (const class_ro_t *)cls->data();
    if (ro->flags & RO_FUTURE) {
        // This was a future class. rw data is already allocated.
        rw = cls->data();
        ro = cls->data()->ro;
        cls->changeInfo(RW_REALIZED|RW_REALIZING, RW_FUTURE);
    } else {
        // Normal class. Allocate writeable class data.
        rw = (class_rw_t *)calloc(sizeof(class_rw_t), 1);
        rw->ro = ro;
        rw->flags = RW_REALIZED|RW_REALIZING;
        cls->setData(rw);
    }
    
    isMeta = ro->flags & RO_META;
    
    rw->version = isMeta ? 7 : 0;  // old runtime went up to 6
    
    
    // Choose an index for this class.
    // Sets cls->instancesRequireRawIsa if indexes no more indexes are available
    cls->chooseClassArrayIndex();
    
    if (PrintConnecting) {
        _objc_inform("CLASS: realizing class '%s'%s %p %p #%u",
                     cls->nameForLogging(), isMeta ? " (meta)" : "",
                     (void*)cls, ro, cls->classArrayIndex());
    }
    
    // Realize superclass and metaclass, if they aren't already.
    // This needs to be done after RW_REALIZED is set above, for root classes.
    // This needs to be done after class index is chosen, for root metaclasses.
    supercls = realizeClass(remapClass(cls->superclass));
    metacls = realizeClass(remapClass(cls->ISA()));
    
#if SUPPORT_NONPOINTER_ISA
    // Disable non-pointer isa for some classes and/or platforms.
    // Set instancesRequireRawIsa.
    bool instancesRequireRawIsa = cls->instancesRequireRawIsa();
    bool rawIsaIsInherited = false;
    static bool hackedDispatch = false;
    
    if (DisableNonpointerIsa) {
        // Non-pointer isa disabled by environment or app SDK version
        instancesRequireRawIsa = true;
    }
    else if (!hackedDispatch  &&  !(ro->flags & RO_META)  &&
             0 == strcmp(ro->name, "OS_object"))
    {
        // hack for libdispatch et al - isa also acts as vtable pointer
        hackedDispatch = true;
        instancesRequireRawIsa = true;
    }
    else if (supercls  &&  supercls->superclass  &&
             supercls->instancesRequireRawIsa())
    {
        // This is also propagated by addSubclass()
        // but nonpointer isa setup needs it earlier.
        // Special case: instancesRequireRawIsa does not propagate
        // from root class to root metaclass
        instancesRequireRawIsa = true;
        rawIsaIsInherited = true;
    }
    
    if (instancesRequireRawIsa) {
        cls->setInstancesRequireRawIsa(rawIsaIsInherited);
    }
    // SUPPORT_NONPOINTER_ISA
#endif
    
    // Update superclass and metaclass in case of remapping
    cls->superclass = supercls;
    cls->initClassIsa(metacls);
    
    // Reconcile instance variable offsets / layout.
    // This may reallocate class_ro_t, updating our ro variable.
    if (supercls  &&  !isMeta) reconcileInstanceVariables(cls, supercls, ro);
    
    // Set fastInstanceSize if it wasn't set already.
    cls->setInstanceSize(ro->instanceSize);
    
    // Copy some flags from ro to rw
    if (ro->flags & RO_HAS_CXX_STRUCTORS) {
        cls->setHasCxxDtor();
        if (! (ro->flags & RO_HAS_CXX_DTOR_ONLY)) {
            cls->setHasCxxCtor();
        }
    }
    
    // Connect this class to its superclass's subclass lists
    if (supercls) {
        addSubclass(supercls, cls);
    } else {
        addRootClass(cls);
    }
    
    // Attach categories
    methodizeClass(cls);
    
    return cls;
}

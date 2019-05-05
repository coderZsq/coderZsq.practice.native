//
//  main.m
//  02-OC对象的分类
//
//  Created by 朱双泉 on 2019/5/5.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface SQPerson : NSObject
{
    int _age;
    int _height;
    int _no;
}
@end

@implementation SQPerson

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // instance对象, 实例对象
        NSObject *object1 = [[NSObject alloc] init];
        NSObject *object2 = [[NSObject alloc] init];
        
        // class对象, 类对象
        // class方法返回的一直是class对象, 类对象
        Class objectClass1 = [object1 class];
        Class objectClass2 = [object2 class];
        Class objectClass3 = object_getClass(object1);
        Class objectClass4 = object_getClass(object2);
        Class objectClass5 = [NSObject class];
        
        // meta-class对象, 元类对象
        // 将类对象当做参数传入, 获得元类对象
        Class objectMetaClass = object_getClass(objectClass5);
        
        NSLog(@"instance - %p, %p",
              object1,
              object2);
        
        NSLog(@"class - %p, %p, %p, %p, %p %d",
              objectClass1,
              objectClass2,
              objectClass3,
              objectClass4,
              objectClass5,
              class_isMetaClass(objectClass3));
        
        NSLog(@"objectMetaClass - %p %d", objectMetaClass, class_isMetaClass(objectMetaClass));
        
        // 1> 传入的可能是instance对象, class对象, meta-class对象
        // 2> 返回值
        // a) 如果是instance对象, 返回class对象
        // b) 如果是class对象, 返回meta-class对象
        // c) 如果是meta-class对象, 返回NSObject (基类) 的meta-class对象
        /*
        Class object_getClass(id obj)
        {
            if (obj) return obj->getIsa();
            else return Nil;
        }
        
        Class objc_getClass(const char *aClassName)
        {
            if (!aClassName) return Nil;
            
            // NO unconnected, YES class handler
            return look_up_class(aClassName, NO, YES);
        }
        
        Class
        look_up_class(const char *name,
                      bool includeUnconnected __attribute__((unused)),
                      bool includeClassHandler __attribute__((unused)))
        {
            if (!name) return nil;
            
            Class result;
            bool unrealized;
            {
                rwlock_reader_t lock(runtimeLock);
                result = getClass(name);
                unrealized = result  &&  !result->isRealized();
            }
            if (unrealized) {
                rwlock_writer_t lock(runtimeLock);
                realizeClass(result);
            }
            return result;
        }
        */
        
        // 1> 传入字符串类名
        // 2> 返回对应的类对象
        /*
        static Class getClass(const char *name)
        {
            runtimeLock.assertLocked();
            
            // Try name as-is
            Class result = getClass_impl(name);
            if (result) return result;
            
            // Try Swift-mangled equivalent of the given name.
            if (char *swName = copySwiftV1MangledName(name)) {
                result = getClass_impl(swName);
                free(swName);
                return result;
            }
            
            return nil;
        }
        
        static Class getClass_impl(const char *name)
        {
            runtimeLock.assertLocked();
            
            // allocated in _read_images
            assert(gdb_objc_realized_classes);
            
            // Try runtime-allocated table
            Class result = (Class)NXMapGet(gdb_objc_realized_classes, name);
            if (result) return result;
            
            // Try table from dyld shared cache
            return getPreoptimizedClass(name);
        }
        
        void *NXMapGet(NXMapTable *table, const void *key) {
            void    *value;
            return (_NXMapMember(table, key, &value) != NX_MAPNOTAKEY) ? value : NULL;
        }
         */
    }
    return 0;
}

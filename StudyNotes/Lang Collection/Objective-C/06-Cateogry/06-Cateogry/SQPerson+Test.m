//
//  SQPerson+Test.m
//  06-Cateogry
//
//  Created by 朱双泉 on 2019/5/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson+Test.h"

@implementation SQPerson (Test)

- (void)run {
    NSLog(@"%s", __func__);
}

- (void)test {
    NSLog(@"%s", __func__);
}

+ (void)test2 {
    NSLog(@"%s", __func__);
}

@end

// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc SQPerson+Test.m

//struct _category_t {
//    const char *name;
//    struct _class_t *cls;
//    const struct _method_list_t *instance_methods;
//    const struct _method_list_t *class_methods;
//    const struct _protocol_list_t *protocols;
//    const struct _prop_list_t *properties;
//};
//
//static struct _category_t _OBJC_$_CATEGORY_SQPerson_$_Test __attribute__ ((used, section ("__DATA,__objc_const"))) =
//{
//    "SQPerson",
//    0, // &OBJC_CLASS_$_SQPerson,
//    (const struct _method_list_t *)&_OBJC_$_CATEGORY_INSTANCE_METHODS_SQPerson_$_Test,
//    (const struct _method_list_t *)&_OBJC_$_CATEGORY_CLASS_METHODS_SQPerson_$_Test,
//    0,
//    0,
//};
//
//static struct /*_method_list_t*/ {
//    unsigned int entsize;  // sizeof(struct _objc_method)
//    unsigned int method_count;
//    struct _objc_method method_list[1];
//} _OBJC_$_CATEGORY_INSTANCE_METHODS_SQPerson_$_Test __attribute__ ((used, section ("__DATA,__objc_const"))) = {
//    sizeof(_objc_method),
//    1,
//    {{(struct objc_selector *)"test", "v16@0:8", (void *)_I_SQPerson_Test_test}}
//};
//
//static struct /*_method_list_t*/ {
//    unsigned int entsize;  // sizeof(struct _objc_method)
//    unsigned int method_count;
//    struct _objc_method method_list[1];
//} _OBJC_$_CATEGORY_CLASS_METHODS_SQPerson_$_Test __attribute__ ((used, section ("__DATA,__objc_const"))) = {
//    sizeof(_objc_method),
//    1,
//    {{(struct objc_selector *)"test2", "v16@0:8", (void *)_C_SQPerson_Test_test2}}
//};


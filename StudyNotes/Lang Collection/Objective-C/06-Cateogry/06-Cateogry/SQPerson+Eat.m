//
//  SQPerson+Eat.m
//  06-Cateogry
//
//  Created by 朱双泉 on 2019/5/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson+Eat.h"

@implementation SQPerson (Eat)

- (void)run {
    NSLog(@"%s", __func__);
}

- (void)eat {
    NSLog(@"%s", __func__);
}

- (void)eat1 {
    NSLog(@"%s", __func__);
}

+ (void)eat2 {
    NSLog(@"%s", __func__);
}

+ (void)eat3 {
    NSLog(@"%s", __func__);
}

@end

// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc SQPerson+Eat.m

//struct _category_t {
//    const char *name;
//    struct _class_t *cls;
//    const struct _method_list_t *instance_methods;
//    const struct _method_list_t *class_methods;
//    const struct _protocol_list_t *protocols;
//    const struct _prop_list_t *properties;
//};
//
//static struct _category_t _OBJC_$_CATEGORY_SQPerson_$_Eat __attribute__ ((used, section ("__DATA,__objc_const"))) =
//{
//    "SQPerson",
//    0, // &OBJC_CLASS_$_SQPerson,
//    (const struct _method_list_t *)&_OBJC_$_CATEGORY_INSTANCE_METHODS_SQPerson_$_Eat,
//    (const struct _method_list_t *)&_OBJC_$_CATEGORY_CLASS_METHODS_SQPerson_$_Eat,
//    (const struct _protocol_list_t *)&_OBJC_CATEGORY_PROTOCOLS_$_SQPerson_$_Eat,
//    (const struct _prop_list_t *)&_OBJC_$_PROP_LIST_SQPerson_$_Eat,
//};
//
//static struct /*_method_list_t*/ {
//    unsigned int entsize;  // sizeof(struct _objc_method)
//    unsigned int method_count;
//    struct _objc_method method_list[2];
//} _OBJC_$_CATEGORY_INSTANCE_METHODS_SQPerson_$_Eat __attribute__ ((used, section ("__DATA,__objc_const"))) = {
//    sizeof(_objc_method),
//    2,
//    {{(struct objc_selector *)"eat", "v16@0:8", (void *)_I_SQPerson_Eat_eat},
//        {(struct objc_selector *)"eat1", "v16@0:8", (void *)_I_SQPerson_Eat_eat1}}
//};
//
//static struct /*_method_list_t*/ {
//    unsigned int entsize;  // sizeof(struct _objc_method)
//    unsigned int method_count;
//    struct _objc_method method_list[2];
//} _OBJC_$_CATEGORY_CLASS_METHODS_SQPerson_$_Eat __attribute__ ((used, section ("__DATA,__objc_const"))) = {
//    sizeof(_objc_method),
//    2,
//    {{(struct objc_selector *)"eat2", "v16@0:8", (void *)_C_SQPerson_Eat_eat2},
//        {(struct objc_selector *)"eat3", "v16@0:8", (void *)_C_SQPerson_Eat_eat3}}
//};
//
//static struct /*_protocol_list_t*/ {
//    long protocol_count;  // Note, this is 32/64 bit
//    struct _protocol_t *super_protocols[2];
//} _OBJC_CATEGORY_PROTOCOLS_$_SQPerson_$_Eat __attribute__ ((used, section ("__DATA,__objc_const"))) = {
//    2,
//    &_OBJC_PROTOCOL_NSCopying,
//    &_OBJC_PROTOCOL_NSCoding
//};
//
//static struct /*_prop_list_t*/ {
//    unsigned int entsize;  // sizeof(struct _prop_t)
//    unsigned int count_of_properties;
//    struct _prop_t prop_list[2];
//} _OBJC_$_PROP_LIST_SQPerson_$_Eat __attribute__ ((used, section ("__DATA,__objc_const"))) = {
//    sizeof(_prop_t),
//    2,
//    {{"weight","Ti,N"},
//    {"height","Td,N"}}
//};


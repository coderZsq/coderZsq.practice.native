//
//  SQPerson+Test.m
//  07-关联对象
//
//  Created by 朱双泉 on 2019/5/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson+Test.h"
#import <objc/runtime.h>

//#define SQKey [NSString stringWithFormat:@"%p", self]

@implementation SQPerson (Test)

//typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy) {
//    OBJC_ASSOCIATION_ASSIGN = 0,           /**< Specifies a weak reference to the associated object. */
//    OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, /**< Specifies a strong reference to the associated object.
//                                            *   The association is not made atomically. */
//    OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   /**< Specifies that the associated object is copied.
//                                            *   The association is not made atomically. */
//    OBJC_ASSOCIATION_RETAIN = 01401,       /**< Specifies a strong reference to the associated object.
//                                            *   The association is made atomically. */
//    OBJC_ASSOCIATION_COPY = 01403          /**< Specifies that the associated object is copied.
//                                            *   The association is made atomically. */
//};

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    // 隐式参数
    // _cmd = @selector(name)
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWeight:(int)weight {
    objc_setAssociatedObject(self, @selector(weight), @(weight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int)weight {
    // _cmd = @selector(weight)
    return [objc_getAssociatedObject(self, _cmd) intValue];
}
/*
- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, @selector(name));
}

- (void)setWeight:(int)weight {
    objc_setAssociatedObject(self, @selector(weight), @(weight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int)weight {
    return [objc_getAssociatedObject(self, @selector(weight)) intValue];
}
*/
/*
#define SQNameKey @"name"

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, SQNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, SQNameKey);
}

#define SQWeightKey @"weight"

- (void)setWeight:(int)weight {
    objc_setAssociatedObject(self, SQWeightKey, @(weight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int)weight {
    return [objc_getAssociatedObject(self, SQWeightKey) intValue];
}
*/
/*
static const char SQNameKey;

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, &SQNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, &SQNameKey);
}

static const char SQWeightKey;

- (void)setWeight:(int)weight {
    objc_setAssociatedObject(self, &SQWeightKey, @(weight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int)weight {
    return [objc_getAssociatedObject(self, &SQWeightKey) intValue];
}
*/
/*
static const void *SQNameKey = &SQNameKey;

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, SQNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, SQNameKey);
}

static const void *SQWeightKey = &SQWeightKey;

- (void)setWeight:(int)weight {
    objc_setAssociatedObject(self, SQWeightKey, @(weight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int)weight {
    return [objc_getAssociatedObject(self, SQWeightKey) intValue];
}
*/
/*
NSMutableDictionary * weights_;
NSMutableDictionary * names_;

+ (void)load {
    weights_ = [NSMutableDictionary dictionary];
    names_ = [NSMutableDictionary dictionary];
}

- (void)setName:(NSString *)name {
//    NSString *key = [NSString stringWithFormat:@"%p", self];
    names_[SQKey] = name;
}

- (NSString *)name {
//    NSString *key = [NSString stringWithFormat:@"%p", self];
    return names_[SQKey];
}

- (void)setWeight:(int)weight {
//    NSString *key = [NSString stringWithFormat:@"%p", self];
    weights_[SQKey] = @(weight);
}

- (int)weight {
//    NSString *key = [NSString stringWithFormat:@"%p", self];
    return  [weights_[SQKey] intValue];
}
*/
/*
int weight_;

- (void)setWeight:(int)weight {
    weight_ = weight;
}

- (int)weight {
    return weight_;
}
*/
@end

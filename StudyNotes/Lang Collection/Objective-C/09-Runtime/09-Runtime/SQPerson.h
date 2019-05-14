//
//  SQPerson.h
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/9.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQPerson : NSObject

- (void)other;

- (void)run;

//{
//    int _age;
//}

@property (nonatomic, assign) int age;
@property (nonatomic, assign) double height;

//- (void)setAge:(int)age;
//
//- (int)age;

- (int)test2:(int)age;

- (void)test:(int)age;

+ (void)test;

- (void)test;

// "i 24 @ 0 : 8 i 16 f 20"
// id SEL int float == 24
- (int)test:(int)age height:(float)height;

//_key = @selector(personTest);
//_imp = personTest的地址
- (void)personTest;
- (void)personTest2;
- (void)personTest3;

//@property (assign, nonatomic, getter=isTall) BOOL tall;
//@property (assign, nonatomic, getter=isRich) BOOL rich;
//@property (assign, nonatomic, getter=isHandsome) BOOL handsome;

- (void)setTall:(BOOL)tall;
- (void)setRich:(BOOL)rich;
- (void)setHandsome:(BOOL)handsome;
- (void)setThin:(BOOL)thin;

- (BOOL)isTall;
- (BOOL)isRich;
- (BOOL)isHandsome;
- (BOOL)isThin;

@end

NS_ASSUME_NONNULL_END

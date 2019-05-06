//
//  SQPerson.h
//  05-KVC
//
//  Created by 朱双泉 on 2019/5/6.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQCat : NSObject

@property (assign, nonatomic) int weight;

@end

@interface SQPerson : NSObject {
    @public
//    int _age;
//    int _isAge;
//    int age;
//    int isAge;
}

//@property (assign, nonatomic) int age;

@property (strong, nonatomic) SQCat *cat;

@end

NS_ASSUME_NONNULL_END

//
//  SQStudent.h
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/10/14.
//

#import <Foundation/Foundation.h>
#import "SQCreditSubject.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SQStudentGender) {
    SQStudentGenderMale,
    SQStudentGenderFemale
};

typedef BOOL(^SatisfyActionBlock)(NSUInteger credit);

@interface SQStudent : NSObject

@property (nonatomic, strong) SQCreditSubject *creditSubject;

@property (nonatomic, assign) BOOL isSatisfyCredit;

+ (SQStudent *)create;
- (SQStudent *)name:(NSString *)name;
- (SQStudent *)gender:(SQStudentGender)gender;
- (SQStudent *)studentNumber:(NSUInteger)number;

//积分相关
- (SQStudent *)sendCredit:(NSUInteger(^)(NSUInteger credit))updateCreditBlock;
- (SQStudent *)filterIsASatisfyCredit:(SatisfyActionBlock)satisfyBlock;

@end

NS_ASSUME_NONNULL_END

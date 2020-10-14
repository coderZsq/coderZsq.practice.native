//
//  SQStudent.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/10/14.
//

#import "SQStudent.h"

@interface SQStudent ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) SQStudentGender gender;
@property (nonatomic, assign) NSUInteger number;
@property (nonatomic, assign) NSUInteger credit;
@property (nonatomic, strong) SatisfyActionBlock satisfyBlock;

@end

@implementation SQStudent

+ (SQStudent *)create {
    SQStudent *student = [[self alloc] init];
    return student;
}
- (SQStudent *)name:(NSString *)name {
    self.name = name;
    return self;
}
- (SQStudent *)gender:(SQStudentGender)gender {
    self.gender = gender;
    return self;
}
- (SQStudent *)studentNumber:(NSUInteger)number {
    self.number = number;
    return self;
}

- (SQStudent *)sendCredit:(NSUInteger (^)(NSUInteger credit))updateCreditBlock {
    if (updateCreditBlock) {
        self.credit = updateCreditBlock(self.credit);
        if (self.satisfyBlock) {
            self.isSatisfyCredit = self.satisfyBlock(self.credit);
            if (self.isSatisfyCredit) {
                NSLog(@"YES");
            } else {
                NSLog(@"NO");
            }
        }
    }
    return self;
}

- (SQStudent *)filterIsASatisfyCredit:(SatisfyActionBlock)satisfyBlock {
    if (satisfyBlock) {
        self.satisfyBlock = satisfyBlock;
        self.isSatisfyCredit = self.satisfyBlock(self.credit);
    }
    return self;
}

#pragma mark - Getter

- (SQCreditSubject *)creditSubject {
    if (!_creditSubject) {
        _creditSubject = [SQCreditSubject create];
    }
    return _creditSubject;
}


@end

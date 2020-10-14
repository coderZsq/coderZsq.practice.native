//
//  SQCreditSubject.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/10/14.
//

#import "SQCreditSubject.h"

@interface SQCreditSubject()

@property (nonatomic, assign) NSUInteger credit; // 积分
@property (nonatomic, strong) SubscribeNextActionBlock subscribeNextBlock; // 订阅信号事件
@property (nonatomic, strong) NSMutableArray *blockArray; // 订阅信号事件队列

@end

@implementation SQCreditSubject

// 创建信号
+ (SQCreditSubject *)create {
    SQCreditSubject *subject = [[self alloc] init];
    return subject;
}

// 发送信号
- (SQCreditSubject *)sendNext:(NSUInteger)credit {
    self.credit = credit;
    if (self.blockArray.count > 0) {
        for (SubscribeNextActionBlock block in self.blockArray) {
            block(self.credit);
        }
    }
    return self;
}

// 订阅信号
- (SQCreditSubject *)subscribeNext:(SubscribeNextActionBlock)block {
    if (block) {
        block(self.credit);
    }
    [self.blockArray addObject:block];
    return self;
}

#pragma mark - Getter
- (NSMutableArray *)blockArray {
    if (!_blockArray) {
        _blockArray = [NSMutableArray array];
    }
    return _blockArray;
}

@end

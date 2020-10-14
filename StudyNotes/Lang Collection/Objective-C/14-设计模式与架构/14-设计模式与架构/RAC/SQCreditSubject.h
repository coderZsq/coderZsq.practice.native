//
//  SQCreditSubject.h
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/10/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQCreditSubject : NSObject

typedef void(^SubscribeNextActionBlock)(NSUInteger credit);

+ (SQCreditSubject *)create;

// 发送信号
- (SQCreditSubject *)sendNext:(NSUInteger)credit;
// 接收信号
- (SQCreditSubject *)subscribeNext:(SubscribeNextActionBlock)block;

@end

NS_ASSUME_NONNULL_END

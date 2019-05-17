//
//  SQPermenantThread.h
//  10-RunLoop
//
//  Created by 朱双泉 on 2019/5/17.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SQPermenantThreadTask)(void);

@interface SQPermenantThread : NSObject

/**
 开启一个线程
 */
//- (void)run;

- (void)executeTask:(SQPermenantThreadTask)task;

- (void)executeTaskWithTarget:(id)target action:(SEL)action object:(id)object;

/**
 结束一个线程
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END

//
//  DDASLLogCapture.m
//  13-性能优化
//
//  Created by 朱双泉 on 2020/10/14.
//

#import "DDASLLogCapture.h"

@implementation DDASLLogCapture


+ (void)start {
    ...
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        [self captureAslLogs];
    });
}


+ (void)captureAslLogs {
    @autoreleasepool {
        ...
        notify_register_dispatch(kNotifyASLDBUpdate, &notifyToken, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^(int token) {
            @autoreleasepool {
                ...
                // 利用进程标识兼容在模拟器情况时其他进程日志无效通知
                [self configureAslQuery:query];

                // 迭代处理所有新日志
                aslmsg msg;
                aslresponse response = asl_search(NULL, query);

                while ((msg = asl_next(response))) {
                    // 记录日志
                    [self aslMessageReceived:msg];

                    lastSeenID = (unsigned long long)atoll(asl_get(msg, ASL_KEY_MSG_ID));
                }
                asl_release(response);
                asl_free(query);

                if (_cancel) {
                    notify_cancel(token);
                    return;
                }
            }
        });

@end

//
//  main.m
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/20.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SQPerson.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        SQPerson *p = [[SQPerson alloc] init];
        
        for (int i = 0; i < 10; i++) {
            dispatch_async(NULL, ^{
                // 加锁
                p.data = [NSMutableArray array];
                // 解锁
            });
        }
        
        NSMutableArray *array = p.data;
        // 加锁
        [array addObject:@"1"];
        [array addObject:@"2"];
        [array addObject:@"3"];
        // 解锁
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

//
//  FPS.m
//  13-性能优化
//
//  Created by 朱双泉 on 2020/10/14.
//

#import "FPS.h"
#import <UIKit/UIKit.h>

@interface FPS () {
    CFTimeInterval lastTimeStamp;
    CGFloat fps;
    CGFloat total;
}

@property (nonatomic, strong) CADisplayLink *dLink;

@end

@implementation FPS

+ (void)load {
    [[FPS new] start];
}

- (void)start {
    self.dLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fpsCount:)];
    [self.dLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

// 方法执行帧率和屏幕刷新率保持一致
- (void)fpsCount:(CADisplayLink *)displayLink {
    if (lastTimeStamp == 0) {
        lastTimeStamp = self.dLink.timestamp;
    } else {
        total++;
        // 开始渲染时间与上次渲染时间差值
        NSTimeInterval useTime = self.dLink.timestamp - lastTimeStamp;
        if (useTime < 1) return;
        lastTimeStamp = self.dLink.timestamp;
        // fps 计算
        fps = total / useTime;
        NSLog(@"FPS %f", fps);
        total = 0;
    }
}

@end

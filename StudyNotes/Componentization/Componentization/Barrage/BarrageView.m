//
//  BarrageView.m
//  Componentization
//
//  Created by 朱双泉 on 2019/1/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "BarrageView.h"

#define kClockSec 0.1
#define kTrajectoryCount 5

@interface BarrageView () {
    BOOL _isPause;
}

@property (nonatomic, weak) NSTimer * clock;
@property (nonatomic, strong) NSMutableArray * laneWaitTimes;
@property (nonatomic, strong) NSMutableArray * laneLeftTimes;
@property (nonatomic, strong) NSMutableArray * barrageViews;

@end

@implementation BarrageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)click:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:tap.view];
    for (UIView * barrageView in self.barrageViews) {
        CGRect frame = barrageView.layer.presentationLayer.frame;
        BOOL isContain = CGRectContainsPoint(frame, point);
        if (isContain) {
            if ([self.delegate respondsToSelector:@selector(barrageViewDidClick:at:)]) {
                [self.delegate barrageViewDidClick:barrageView at:point];
            }
            break;
        }
    }
}

- (void)pause {
    _isPause = YES;
    [[self.barrageViews valueForKeyPath:@"layer"] makeObjectsPerformSelector:@selector(pauseAnimate)];
    [self.clock invalidate];
    self.clock = nil;
}

- (void)resume {
    _isPause = NO;
    [[self.barrageViews valueForKeyPath:@"layer"] makeObjectsPerformSelector:@selector(resumeAnimate)];
    [self clock];
}

- (void)checkAndBiu {
    if (_isPause) {
        return;
    }
    for (int i = 0; i < kTrajectoryCount; i++) {
        double waitValue = [self.laneWaitTimes[i] doubleValue] - kClockSec;
        if (waitValue <= 0.0) {
            waitValue = 0.0;
        }
        self.laneWaitTimes[i] = @(waitValue);
        double leftValue = [self.laneLeftTimes[i] doubleValue] - kClockSec;
        if (leftValue <= 0.0) {
            leftValue = 0.0;
        }
        self.laneLeftTimes[i] = @(leftValue);
    }
    [self.models sortUsingComparator:^NSComparisonResult(id<BarrageProtocol>  _Nonnull obj1, id<BarrageProtocol>  _Nonnull obj2) {
        if (obj1.beginTime < obj1.beginTime) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    NSMutableArray * deleteModels = [NSMutableArray array];
    for (id<BarrageProtocol> model in self.models) {
        NSTimeInterval beginTime = model.beginTime;
        NSTimeInterval currentTime = self.delegate.currentTime;
        if (beginTime > currentTime) {
            break;
        }
        BOOL result = [self checkBoomWith:model];
        if (result) {
            [deleteModels addObject:model];
        }
    }
    [self.models removeObjectsInArray:deleteModels];
}

- (BOOL)checkBoomWith:(id <BarrageProtocol>)model {
    CGFloat barrageH = self.frame.size.height / kTrajectoryCount;
    for (int i = 0; i < kTrajectoryCount; i++) {
        NSTimeInterval waitTime = [self.laneWaitTimes[i] doubleValue];
        if (waitTime > 0.0) {
            continue;
        }
        UIView * barrageView = [self.delegate barrageViewWithModel:model];
        NSTimeInterval leftTime = [self.laneLeftTimes[i] doubleValue];
        double speed = (barrageView.frame.size.width + self.frame.size.width) / model.liveTime;
        double distance = leftTime * speed;
        if (distance > self.frame.size.width) {
            continue;
        }
        [self.barrageViews addObject:barrageView];
        self.laneWaitTimes[i] = @(barrageView.frame.size.width / speed);
        self.laneLeftTimes[i] = @(model.liveTime);
        CGRect frame = barrageView.frame;
        frame.origin = CGPointMake(self.frame.size.width, barrageH * i);
        barrageView.frame = frame;
        [self addSubview:barrageView];
        [UIView animateWithDuration:model.liveTime delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
            CGRect frame = barrageView.frame;
            frame.origin.x = - barrageView.frame.size.width;
            barrageView.frame = frame;
        } completion:^(BOOL finished) {
            [barrageView removeFromSuperview];
            [self.barrageViews removeObject:barrageView];
        }];
        return YES;
    }
    return NO;
}

- (void)dealloc {
    [self.clock invalidate];
    self.clock = nil;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self clock];
    self.layer.masksToBounds = YES;
}

- (NSMutableArray *)models {
    
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (NSTimer *)clock {
    
    if (!_clock) {
        NSTimer * clock = [NSTimer scheduledTimerWithTimeInterval:kClockSec target:self selector:@selector(checkAndBiu) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:clock forMode:NSRunLoopCommonModes];
        _clock = clock;
    }
    return _clock;
}

- (NSMutableArray *)laneWaitTimes {
    
    if (!_laneWaitTimes) {
        _laneWaitTimes = [NSMutableArray arrayWithCapacity:kTrajectoryCount];
        for (int i = 0; i < kTrajectoryCount; i++) {
            _laneWaitTimes[i] = @0.0;
        }
    }
    return _laneWaitTimes;
}

- (NSMutableArray *)laneLeftTimes {
    
    if (!_laneLeftTimes) {
        _laneLeftTimes = [NSMutableArray arrayWithCapacity:kTrajectoryCount];
        for (int i = 0; i < kTrajectoryCount; i++) {
            _laneLeftTimes[i] = @0.0;
        }
    }
    return _laneLeftTimes;
}

- (NSMutableArray *)barrageViews {
    
    if (!_barrageViews) {
        _barrageViews = [NSMutableArray array];
    }
    return _barrageViews;
}

@end


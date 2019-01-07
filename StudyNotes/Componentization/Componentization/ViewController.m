//
//  ViewController.m
//  Componentization
//
//  Created by 朱双泉 on 2018/12/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "BarrageView.h"
#import "BarrageModel.h"

@interface ViewController () <BarrageViewProtocol>

@property (nonatomic, weak) BarrageView * barrageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BarrageView * barrageView = [[BarrageView alloc]initWithFrame:CGRectMake(20, 100, 250, 200)];
    barrageView.backgroundColor = [UIColor orangeColor];
    barrageView.delegate = self;
    self.barrageView = barrageView;
    [self.view addSubview:barrageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BarrageModel * model1 = [[BarrageModel alloc]init];
    model1.beginTime = 3;
    model1.liveTime = 5;
    model1.content = @"1234567890";
    BarrageModel * model2 = [[BarrageModel alloc]init];
    model2.beginTime = 3.2;
    model2.liveTime = 8;
    model2.content = @"qwerty";
    [self.barrageView.models addObject:model1];
    [self.barrageView.models addObject:model2];
}

- (NSTimeInterval)currentTime {
    static double time = 0;
    time += 0.1;
    return time;
}

- (UIView *)barrageViewWithModel:(BarrageModel *)model {
    UILabel * label = [UILabel new];
    label.text = model.content;
    [label sizeToFit];
    return label;
}

- (void)barrageViewDidClick:(UIView *)barrageView at:(CGPoint)point {
    NSLog(@"%@, %@", barrageView, NSStringFromCGPoint(point));
}

@end

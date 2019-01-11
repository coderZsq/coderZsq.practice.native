//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/8.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"next"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"disposableWithBlock");
        }];
    }];
    
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"subscribeNext");
//    }];
//
//    [signal subscribeError:^(NSError * _Nullable error) {
//        NSLog(@"subscribeError");
//    }];
//
//    [signal subscribeCompleted:^{
//        NSLog(@"subscribeCompleted");
//    }];
//
    [signal subscribeNext:^(id  _Nullable x) {

    } error:^(NSError * _Nullable error) {

    } completed:^{

    }];
}


@end

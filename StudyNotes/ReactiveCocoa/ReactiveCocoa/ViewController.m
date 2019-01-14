//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/8.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
#import "RView.h"
#import "RFlagItem.h"

@interface ViewController () ///<RViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)RACMulticastConnection {
    @weakify(self)
    RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        NSLog(@"发送请求");
        [self loadData:^(id data) {
            [subscriber sendNext:data];
        }];
        return nil;
    }];
    RACMulticastConnection * connection = [signal publish];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        
    }];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        
    }];
    [connection connect];
}

- (void)loadData:(void(^)(id))success {
    
}

- (void)RACSequence {
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray * datas = [NSArray arrayWithContentsOfFile:filePath];
    //    datas = @[@1, @2, @3];
    //    NSMutableArray * arrM = [NSMutableArray array];
    //    [datas.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@", [NSThread currentThread]);
    //        NSLog(@"%@", x);
    //        RFlagItem * item = [RFlagItem itemWithDict:x];
    //        [arrM addObject:item];
    //    } completed:^{
    //        NSLog(@"%@", [NSThread currentThread]);
    //        NSLog(@"%@", arrM);
    //    }];
    NSArray * arr = [[datas.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [RFlagItem itemWithDict:value];
    }] array];
    NSLog(@"%@", arr);
    
    NSDictionary * dict = @{
                            @"name" : @"Castie!",
                            @"money" : @1234567890
                            };
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString * key, id value) = x;
        NSLog(@"%@, %@", key, value);
        NSLog(@"%@", x [0]);
    }];
    
    RACTuple * tuple = RACTuplePack(@1, @2, @3);
    NSLog(@"%@", tuple);
}

- (void)RACSubjectDelegate {
    RView * v = [RView new];
    v.backgroundColor = [UIColor redColor];
    v.frame = CGRectMake(50, 100, 100, 100);
    //    v.delegate = self;
    RACSubject * subject = [RACSubject subject];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    v.subject = subject;
    [self.view addSubview:v];
}

//- (void)viewWithTap:(RView *)view {
//    NSLog(@"%s", __func__);
//}

- (void)RACReplaySubject {
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject sendNext:@"123"];
    [replaySubject sendNext:@"321"];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)RACSubject {
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者%@",x);
    }];
    [subject sendNext:@1];
}

- (void)RACSignal {
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

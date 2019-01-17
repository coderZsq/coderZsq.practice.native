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
#import "RModel.h"
#import "RViewModel.h"
#import "RACReturnSignal.h"

@interface ViewController () ///<RViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) RViewModel * viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)timer {
    [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"执行了定时器");
    }];
    
    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"hello"];
        return nil;
    }] delay:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)filter {
    [[_textField2.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 6;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

// 把多个信号的值, 聚合为一个信号
- (void)reduce {
    //    [[RACSignal combineLatest:@[_textField.rac_textSignal, _textField2.rac_textSignal] reduce:^id (NSString * text, NSString * text2) {
    //        NSLog(@"%@, %@", text, text2);
    //        return @(text.length > 0 && text2.length > 0);
    //    }] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"聚合的结果: %@", x);
    //        self.loginButton.enabled = [x boolValue];
    //    }];
    
    RAC(_loginButton, enabled) = [RACSignal combineLatest:@[_textField.rac_textSignal, _textField2.rac_textSignal] reduce:^id (NSString * text, NSString * text2) {
        NSLog(@"%@, %@", text, text2);
        return @(text.length > 0 && text2.length > 0);
    }];
}

// 任何一个信号, 只要改变就能订阅
- (void)combineLatestWith {
    //    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
    //        if (x.length > 0) {
    //
    //        }
    //    }];
    //    [_textField2.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
    //        if (x.length > 0) {
    //
    //        }
    //    }];
    
    [[_textField.rac_textSignal combineLatestWith:_textField2.rac_textSignal] subscribeNext:^(RACTwoTuple<NSString *,id> * _Nullable x) {
        RACTupleUnpack(NSString * text, NSString * text2) = x;
        NSLog(@"%@, %@", text, text2);
        self.loginButton.enabled = text.length > 0 && text2.length;
    }];
}

// 压缩, 同时发送数据才能订阅
- (void)zipWith {
    RACSubject * signalA = [RACSubject subject];
    RACSubject * signalB = [RACSubject subject];
    [[signalA zipWith:signalB] subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString * a, NSString * b) = x;
        NSLog(@"%@, %@", a, b);
    }];
    [signalA sendNext:@"A"];
    [signalB sendNext:@"B"];
}

// 合并, 只要任何一个信号发送数据, 就能订阅
- (void)merge {
    RACSubject * signalA = [RACSubject subject];
    RACSubject * signalB = [RACSubject subject];
    [[signalA merge:signalB] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    [signalA sendNext:@"B"];
    [signalA sendNext:@"A"];
}

- (void)then {
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"执行信号A");
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }];
    /*
     RACSignal * signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
     NSLog(@"执行信号B");
     [subscriber sendNext:@2];
     return nil;
     }];
     //不要订阅多次
     [[signalA concat:signalB] subscribeNext:^(id  _Nullable x) {
     NSLog(@"%@", x);
     }];
     */
    
    [[signalA then:^RACSignal * _Nonnull{
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"执行信号B");
            [subscriber sendNext:@2];
            return nil;
        }];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    //    [[[self loadCategoryData] then:^RACSignal * _Nonnull{
    //        return [self loadDetailData];
    //    }] then:^RACSignal * _Nonnull{
    //        return [self loadDetailData];
    //    }];
    
    [[[self loadCategoryData] then:^RACSignal * _Nonnull{
        return [self loadDetailData];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (RACSignal *)loadCategoryData {
    RACSubject * signal = [RACReplaySubject subject];
    [self loadCategoryData:^(id data) {
        [signal sendNext:data];
        [signal sendCompleted];
    }];
    return signal;
}

- (RACSignal *)loadDetailData {
    RACSubject * signal = [RACReplaySubject subject];
    [self loadDetailData:^(id data) {
        [signal sendNext:data];
    }];
    return signal;
}

- (void)loadCategoryData:(void(^)(id data))success {
    success(@"CategoryData");
}

- (void)loadDetailData:(void(^)(id data))success {
    success(@"DetailData");
}

- (void)concat {
    RACSubject * signalA = [RACSubject subject];
    RACSubject * signalB = [RACReplaySubject subject];
    NSMutableArray * arrM = [NSMutableArray array];
    //    [signalA subscribeNext:^(id  _Nullable x) {
    //        [arrM addObject:x];
    //    }];
    //    [signalB subscribeNext:^(id  _Nullable x) {
    //        [arrM addObject:x];
    //    }];
    [[signalA concat:signalB] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
        [arrM addObject:x];
    }];
    [signalB sendNext:@"B"];
    [signalA sendNext:@"A"];
    [signalA sendCompleted];
    NSLog(@"%@", arrM);
}

- (void)signalOfSignals {
    RACSubject * signalOfSignals = [RACSubject subject];
    RACSubject * signal = [RACSubject subject];
    //    [signalOfSignals subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"信号中信号的值: %@", x);
    //        [x subscribeNext:^(id  _Nullable x) {
    //            NSLog(@"信号的值: %@", x);
    //        }];
    //    }];
    [[signalOfSignals flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [value map:^id _Nullable(id  _Nullable value) {
            return [NSString stringWithFormat:@"cas: %@", value];
        }];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    //    [signal subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@", x);
    //    }];
    [signalOfSignals sendNext:signal];
    [signal sendNext:@"1"];
}

- (void)flattenMap {
    [[_textField.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        NSString * result = [NSString stringWithFormat:@"cas: %@", value];
        return [RACReturnSignal return:result];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [[_textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        NSString * result = [NSString stringWithFormat:@"cas: %@", value];
        return result;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)bind {
    [[_textField.rac_textSignal bind:^RACSignalBindBlock _Nonnull{
        NSLog(@"bindBlock");
        return ^RACSignal *(id value, BOOL *stop){
            NSLog(@"信号Block: %@", value);
            NSString * result = [NSString stringWithFormat:@"%@%@", value, @"cas"];
            return [RACReturnSignal return:result];
        };
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"获取到处理完的数据: %@", x);
    }];
}

- (void)MVVM {
    @weakify(self);
    [[self.viewModel.loadDataCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSLog(@"%@", x);
        //[self.tableView reloadData];
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
    //[self.viewModel bindViewModel:self.tableView];
}

- (RViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [RViewModel new];
    }
    return _viewModel;
}

- (void)rac_liftSelector {
    RACSignal * hotSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"最热数据"];
        return nil;
    }];
    RACSignal * newSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"最新数据"];
        return nil;
    }];
    [self rac_liftSelector:@selector(updateUIWithHot:new:) withSignalsFromArray:@[hotSignal, newSignal]];
}

- (void)updateUIWithHot:(NSString *)hot new:(NSString *)new {
    NSLog(@"更新数据: %@, %@", hot, new);
}

- (void)Bind {
    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
        //        self.loginButton.titleLabel.text = x;
    }];
    RAC(_loginButton, titleLabel.text) = _textField.rac_textSignal;
}

- (void)Notification {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"Note" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"监听到通知: %@", x);
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Note" object:nil];
}

- (void)rac_signalForControlEvents {
    [[_loginButton rac_signalForControlEvents:(UIControlEventTouchDown)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)RACObserve {
    //    [self rac_valuesForKeyPath:nil observer:nil];
    //    [self rac_valuesAndChangesForKeyPath:nil options:nil observer:nil];
    
    //    [[self rac_valuesForKeyPath:@keypath(self, age) observer:self] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@", x);
    //    }];
    //    self removeObserver:<#(nonnull NSObject *)#> forKeyPath:<#(nonnull NSString *)#>
    
    [RACObserve(self, age) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.age++;
//}

- (void)rac_signalForSelector {
    //    ViewController * vc = [super allocWithZone:zone];
    [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"viewDidLoad");
        RView * v = [RView new];
        v.backgroundColor = [UIColor redColor];
        v.frame = CGRectMake(50, 100, 100, 100);
        [self.view addSubview:v];
        
        [[v rac_signalForSelector:@selector(touchesBegan:withEvent:)] subscribeNext:^(RACTuple * _Nullable x) {
            NSLog(@"点击View: %@", x);
        }];
    }];
    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"viewWillAppear");
    }];
}

- (void)RACCommandSence {
    //    _loginButton.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    //        NSLog(@"点击了按钮: %@", input);
    //        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    //            [subscriber sendNext:input];
    //            return nil;
    //        }];
    //    }];
    
    RACSubject * enableSignal = [RACSubject subject];
    _loginButton.rac_command = [[RACCommand alloc]initWithEnabled:enableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"点击了按钮: %@", input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:input];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    [[_loginButton.rac_command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        BOOL executing = [x boolValue];
        [enableSignal sendNext:@(!executing)];
    }];
    
    [_loginButton.rac_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)RACCommand {
    RACCommand * command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行Block, %@", input);
        //        return [RACSignal empty];
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"执行信号的Block");
            [subscriber sendNext:@"你好"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        BOOL isExcuting = [x boolValue];
        if (isExcuting) {
            NSLog(@"正在执行");
        } else {
            NSLog(@"执行完成");
        }
    }];
    //    [command.executionSignals subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@", x);
    //        [x subscribeNext:^(id  _Nullable x) {
    //            NSLog(@"%@", x);
    //        }];
    //    }];
    [command execute:@1];
    //    [[command execute:@1] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@", x);
    //    }];
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
    //        RModel * item = [RModel itemWithDict:x];
    //        [arrM addObject:item];
    //    } completed:^{
    //        NSLog(@"%@", [NSThread currentThread]);
    //        NSLog(@"%@", arrM);
    //    }];
    NSArray * arr = [[datas.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [RModel itemWithDict:value];
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

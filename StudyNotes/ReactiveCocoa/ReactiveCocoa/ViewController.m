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

@interface ViewController () ///<RViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) RViewModel * viewModel;
@end

@implementation ViewController

- (RViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [RViewModel new];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.viewModel.loadDataCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
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

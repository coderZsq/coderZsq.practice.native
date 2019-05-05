//
//  ViewController.m
//  04-KVO
//
//  Created by 朱双泉 on 2019/5/5.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "SQPerson.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (strong, nonatomic) SQPerson *person1;
@property (strong, nonatomic) SQPerson *person2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.person1 = [[SQPerson alloc] init];
    self.person1.age = 1;
//    self.person1.height = 11;

    self.person2 = [[SQPerson alloc] init];
    self.person2.age = 2;
//    self.person2.height = 22;
    
    NSLog(@"person1添加KVO监听之前 - %@ %@",
          object_getClass(self.person1),
          object_getClass(self.person2));
    NSLog(@"person1添加KVO监听之前 - %p %p",
          [self.person1 methodForSelector:@selector(setAge:)],
          [self.person2 methodForSelector:@selector(setAge:)]);
    /*
     (lldb) p (IMP)0x105f49bb0
     (IMP) $0 = 0x0000000105f49bb0 (04-KVO`-[SQPerson setAge:] at SQPerson.m:13)
     */
    
    //给person对象添加KVO监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:@"123"];
//    [self.person1 addObserver:self forKeyPath:@"height" options:options context:@"456"];
    
    NSLog(@"person1添加KVO监听之后 - %@ %@",
          object_getClass(self.person1),
          object_getClass(self.person2));
    NSLog(@"person1添加KVO监听之后 - %p %p",
          [self.person1 methodForSelector:@selector(setAge:)],
          [self.person2 methodForSelector:@selector(setAge:)]);
    /*
     (lldb) p (IMP)0x1062a53d2
     (IMP) $1 = 0x00000001062a53d2 (Foundation`_NSSetIntValueAndNotify)
     */
    
    NSLog(@"类对象 - %@ %@",
          object_getClass(self.person1), //self.person1.isa
          object_getClass(self.person2)); //self.person2.isa
    NSLog(@"元类对象 - %@ %@",
          object_getClass(object_getClass(self.person1)), //self.person1.isa.isa
          object_getClass(object_getClass(self.person2))); //self.person2.isa.isa
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.person1.age = 21;
//    self.person2.age = 22;
    
    /*
     (lldb) p self.person1->isa
     (Class) $1 = NSKVONotifying_SQPerson
     NSKVONotifying_SQPerson是使用 Runtime 动态创建的一个类 是SQPerson的子类
    */
    [self.person1 setAge:21];
    /*
     (lldb) p self.person2->isa
     (Class) $2 = SQPerson
     */
    [self.person2 setAge:22];
    
//    self.person1.height = 30;
//    self.person2.height = 30;
}

- (void)dealloc {
    [self.person1 removeObserver:self forKeyPath:@"age"];
//    [self.person1 removeObserver:self forKeyPath:@"height"];
}

// 当监听对象的属性值发生改变时, 就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到%@的%@属性值改变了 - %@ - %@", object, keyPath, change, context);
}

@end

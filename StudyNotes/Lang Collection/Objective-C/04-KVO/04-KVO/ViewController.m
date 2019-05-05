//
//  ViewController.m
//  04-KVO
//
//  Created by 朱双泉 on 2019/5/5.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "SQPerson.h"

@interface ViewController ()
@property (strong, nonatomic) SQPerson *person1;
@property (strong, nonatomic) SQPerson *person2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.person1 = [[SQPerson alloc] init];
    self.person1.age = 1;
    self.person1.height = 11;

    self.person2 = [[SQPerson alloc] init];
    self.person2.age = 2;
    self.person2.height = 22;
    
    //给person对象添加KVO监听
    NSKeyValueObservingOptions options =NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:@"123"];
    [self.person1 addObserver:self forKeyPath:@"height" options:options context:@"456"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.person1.age = 20;
//    self.person1.height = 30;
    
    self.person2.age = 20;
    self.person2.height = 30;
}

- (void)dealloc {
    [self.person1 removeObserver:self forKeyPath:@"age"];
    [self.person1 removeObserver:self forKeyPath:@"height"];
}

// 当监听对象的属性值发生改变时, 就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到%@的%@属性值改变了 - %@ - %@", object, keyPath, change, context);
}

@end

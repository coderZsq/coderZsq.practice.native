//
//  ViewController.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "SQPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)test {
    
}

/*
 1. print为什么能够调用成功?
 2. 为什么self.name变成了ViewController
 */

// 寄存器, 内存
void viewDidLoad(id self, SEL _cmd) {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    struct objc_super2 arg {
        self,
        [ViewController class]
    };
    objc_msgSendSuper2(arg, sel_register("viewDidLoad"));*/
    
    /*
     struct objc_super arg {
        self,
        [UIViewController class]
     },
     objc_msgSendSuper(arg, sel_register("viewDidLoad"));*/
    
//    NSString *test = @"Castie!";
//    NSObject *obj2 = [[NSObject alloc] init];
    
    id cls = [SQPerson class];
    void *obj = &cls;
    [(__bridge id)obj print];
//    obj->第一个成员->class
    
    /*
     (lldb) p/x obj
     (SQPerson *) $0 = 0x00007ffee9bf4838
     (lldb) x 0x00007ffee9bf4838
     0x7ffee9bf4838: e0 e7 00 06 01 00 00 00 f0 76 70 3d 9d 7f 00 00  .........vp=....
     0x7ffee9bf4848: 30 e8 00 06 01 00 00 00 87 16 f1 0a 01 00 00 00  0...............
     (lldb) x/4g 0x00007ffee9bf4838
     0x7ffee9bf4838: 0x000000010600e7e0 0x00007f9d3d7076f0
     0x7ffee9bf4848: 0x000000010600e830 0x000000010af11687
     (lldb) p (Class)0x000000010600e7e0
     (Class) $1 = SQPerson
     (lldb) po 0x00007f9d3d7076f0
     <ViewController: 0x7f9d3d7076f0>
     
     (lldb) p (Class)0x000000010600e830
     (Class) $3 = ViewController
     */
    
    SQPerson *person = [[SQPerson alloc] init];
    [person print];
//    person->isa->class
    
//    [self performSelector:@selector(test)];
//    [person performSelector:@selector(test)]
}

@end

//
//  SQBaseDemo.m
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQBaseDemo.h"

@interface SQBaseDemo ()
@property (assign, nonatomic) int ticketsCount;
@property (nonatomic, assign) int money;
@end

@implementation SQBaseDemo

- (void)moneyTest {
    self.money = 100;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __saveMoney];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __drawMoney];
        }
    });
}

- (void)__saveMoney {
    
    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 50;
    self.money = oldMoney;
    
    NSLog(@"存50, 还剩%d元 - %@", oldMoney, [NSThread currentThread]);
    
}

- (void)__drawMoney {
    
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20;
    self.money = oldMoney;
    
    NSLog(@"取20, 还剩%d元 - %@", oldMoney, [NSThread currentThread]);
    
}

- (void)__saleTicket {
    
    int oldTicketsCount = self.ticketsCount;
    sleep(.2);
    oldTicketsCount--;
    self.ticketsCount = oldTicketsCount;
    
    NSLog(@"还剩%d张票 - %@", oldTicketsCount, [NSThread currentThread]);
    
}

- (void)ticketTest {
    self.ticketsCount = 15;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
}

@end

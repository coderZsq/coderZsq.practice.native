//
//  main.m
//  24-从OC到Swift
//
//  Created by 朱双泉 on 2019/8/19.
//  Copyright © 2019 Castie!. All rights reserved.
//

#pragma mark - OC调用Swift

#include "_4_从OC到Swift-Swift.h"

int sum2(int a, int b) {
//    Car *c = [[Car alloc] initWithPrice:10.5 band:@"BMW"];
//    c.band = @"Bently";
//    c.price = 108.5;
//    [c run];
//    [c test];
//    [Car run];
    SQCar *c = [[SQCar alloc] initWithPrice:10.5 band:@"BMW"];
    c.name = @"Bently";
    c.price = 108.5;
    [c drive];
    [c exec:10 v2:20];
    [SQCar run];
    return a + b;
}

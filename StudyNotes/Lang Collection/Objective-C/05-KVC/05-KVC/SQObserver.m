//
//  SQObserver.m
//  05-KVC
//
//  Created by 朱双泉 on 2019/5/6.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQObserver.h"

@implementation SQObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%s - %@", __func__, change);
}

@end

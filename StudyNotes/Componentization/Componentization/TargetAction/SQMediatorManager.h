//
//  SQMediatorManager.h
//  Componentization
//
//  Created by 朱双泉 on 2018/12/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQMediatorManager : NSObject


// 本地组件调用入口
+ (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(id)params isRequiredReturnValue: (BOOL)isRequiredReturnValue;


@end

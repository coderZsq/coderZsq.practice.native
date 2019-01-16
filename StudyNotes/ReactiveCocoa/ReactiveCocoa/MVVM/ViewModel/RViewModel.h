//
//  RViewModel.h
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/16.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RViewModel : NSObject {
    RACCommand * _loadDataCommand;
}

@property (nonatomic, strong, readonly) RACCommand * loadDataCommand;

@end

NS_ASSUME_NONNULL_END

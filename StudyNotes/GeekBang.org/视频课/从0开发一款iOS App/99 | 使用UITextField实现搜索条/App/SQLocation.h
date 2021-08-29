//
//  SQLocation.h
//  App
//
//  Created by 朱双泉 on 2021/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// App中统一的位置信息管理
@interface SQLocation : NSObject

+ (SQLocation *)locationManager;

- (void)checkLocationAuthorization;

@end

NS_ASSUME_NONNULL_END

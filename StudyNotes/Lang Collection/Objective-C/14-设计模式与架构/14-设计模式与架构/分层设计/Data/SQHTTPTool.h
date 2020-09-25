//
//  SQHttpTool.h
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQHTTPTool : NSObject
+ (void)GET:(NSString *)URL params:(NSDictionary *)params success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END

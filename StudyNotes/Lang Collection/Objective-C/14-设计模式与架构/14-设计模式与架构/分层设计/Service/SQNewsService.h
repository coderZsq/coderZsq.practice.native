//
//  SQNewsService.h
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQNewsService : NSObject
+ (void)loadNews:(NSDictionary *)params success:(void (^)(NSArray *newsData))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END

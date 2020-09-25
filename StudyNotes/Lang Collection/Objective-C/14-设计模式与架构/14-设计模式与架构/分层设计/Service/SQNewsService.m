//
//  SQNewsService.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import "SQNewsService.h"
#import "SQHTTPTool.h"
#import "SQDBTool.h"

@implementation SQNewsService

+ (void)loadNews:(NSDictionary *)params success:(void (^)(NSArray *newsData))success failure:(void (^)(NSError *error))failure {
    // 先取出本地数据
//    [SQDBTool loadLocalData....];
    
    // 如果没有本地数据, 就加载网络数据
//    [SQHTTPTool GET:@"xxxx" params:nil success:^(id  _Nonnull result) {
//        success(array);
//    } failure:failure]
}

@end

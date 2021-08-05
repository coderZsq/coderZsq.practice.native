//
//  SQListLoader.m
//  App
//
//  Created by 朱双泉 on 2021/1/9.
//

#import "SQListLoader.h"
#import <AFNetworking.h>

@implementation SQListLoader

- (void)loadListData {
//    [[AFHTTPSessionManager manager] GET:@"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"");
//    }];
    
        NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
        NSURL *listURL = [NSURL URLWithString:urlString];
    
    //    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];
    
        NSURLSession *session = [NSURLSession sharedSession];
    
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSError *jsonError;
            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSLog(@"");
        }];
    
        [dataTask resume];
    
        NSLog(@"");
}

@end

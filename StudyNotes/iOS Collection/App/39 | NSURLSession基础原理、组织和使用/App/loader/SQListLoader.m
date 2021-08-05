//
//  SQListLoader.m
//  App
//
//  Created by 朱双泉 on 2021/1/9.
//

#import "SQListLoader.h"

@implementation SQListLoader

- (void)loadListData {
    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listURL = [NSURL URLWithString:urlString];
    
    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:listRequest];
    
    NSLog(@"");
}

@end

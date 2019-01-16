//
//  RViewModel.m
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/16.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "RViewModel.h"
#import "SQHttpManager.h"
#import "SQNetworkManager.h"
#import "RModel.h"
#import "MJExtension.h"

@implementation RViewModel

- (RACCommand *)loadDataCommand {
    
    if (!_loadDataCommand) {
        _loadDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSString * url = [SQNetworkManager urlWithHome];
                NSDictionary * param = [SQNetworkManager paramWithHome];
                [SQHttpManager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSDictionary * result = responseObject[@"result"];
                    NSDictionary * recommendsDict = result[@"recommends"];
                    NSArray * recommends;
                    recommends = [RModel mj_objectArrayWithKeyValuesArray:recommendsDict[@"courses"]];
                    [subscriber sendNext:recommends];
                    [subscriber sendCompleted];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _loadDataCommand;
}

@end

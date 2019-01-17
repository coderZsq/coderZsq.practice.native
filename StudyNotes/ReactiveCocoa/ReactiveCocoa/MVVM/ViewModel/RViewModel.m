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
#import "SQHomeRecommendCell.h"
#import "RCellViewModel.h"

@interface RViewModel () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray * recommandCellVMs;
@end

@implementation RViewModel

- (RACCommand *)loadDataCommand {
    
    if (!_loadDataCommand) {
        @weakify(self);
        _loadDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSString * url = [SQNetworkManager urlWithHome];
                NSDictionary * param = [SQNetworkManager paramWithHome];
                [SQHttpManager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    @strongify(self);
                    NSDictionary * result = responseObject[@"result"];
                    NSDictionary * recommendsDict = result[@"recommends"];
                    NSArray * recommends;
                    recommends = [RModel mj_objectArrayWithKeyValuesArray:recommendsDict[@"courses"]];
                    self.recommandCellVMs = [[recommends.rac_sequence map:^id _Nullable(id  _Nullable value) {
                        RCellViewModel * cellVM = [RCellViewModel new];
                        cellVM.item = value;
                        return cellVM;
                    }]array] ;
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

- (void)bindViewModel:(UIView *)bindView {
    UITableView * tableView = (UITableView *)bindView;
    [tableView registerNib:[UINib nibWithNibName:@"SQHomeRecommendCell" bundle:[NSBundle bundleForClass:[SQHomeRecommendCell class]]] forCellReuseIdentifier:@"RCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommandCellVMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQHomeRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RCell"];
    RCellViewModel * cellVM = self.recommandCellVMs[indexPath.row];
    [cellVM bindViewModel:cell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end

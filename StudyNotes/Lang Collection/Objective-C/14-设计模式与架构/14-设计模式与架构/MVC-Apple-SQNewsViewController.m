//
//  MVC-Apple-SQNewsViewController.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import "MVC-Apple-SQNewsViewController.h"
#import "SQNews.h"
#import "SQShop.h"

@interface MVC_Apple_SQNewsViewController ()
@property (strong, nonatomic) NSMutableArray *newsData;
@property (strong, nonatomic) NSMutableArray *shopData;
@end

@implementation MVC_Apple_SQNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadNewsData];
    [self loadShopData];
}

- (void)loadShopData {
    self.shopData = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        SQShop *shop = [[SQShop alloc] init];
        shop.name = [NSString stringWithFormat:@"商品-%d", i];
        shop.price = [NSString stringWithFormat:@"19.%d", i];
        [self.shopData addObject:shop];
    }
}

- (void)loadNewsData {
    self.newsData = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        SQNews *news = [[SQNews alloc] init];
        news.title = [NSString stringWithFormat:@"news-title-%d", i];
        news.content = [NSString stringWithFormat:@"news-content-%d", i];
        [self.newsData addObject:news];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shopData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    SQShop *shop = self.shopData[indexPath.row];
    cell.detailTextLabel.text = shop.price;
    cell.textLabel.text = shop.name;
    return cell;
}

@end

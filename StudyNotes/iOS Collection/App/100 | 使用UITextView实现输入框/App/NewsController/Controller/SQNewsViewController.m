//
//  SQNewsViewController.m
//  App
//
//  Created by 朱双泉 on 2021/1/8.
//

#import "SQNewsViewController.h"
#import "SQNormalTableViewCell.h"
#import "SQDeleteCellView.h"
#import "SQListLoader.h"
#import "SQListItem.h"
#import "SQMediator.h"
#import "SQSearchBar.h"
#import "SQScreen.h"
#import "SQCommentManager.h"

@interface SQNewsViewController () <UITableViewDataSource,UITableViewDelegate,SQNormalTableViewCellDelegate>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSArray *dataArray;
@property (nonatomic, strong, readwrite) SQListLoader *listLoader;
@end

@implementation SQNewsViewController

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.listLoader = [[SQListLoader alloc] init];
    __weak typeof(self) wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<SQListItem *> * _Nonnull dataArray) {
        __strong typeof(self) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.tabBarController.navigationItem setTitleView:({
//        SQSearchBar *searchBar = [[SQSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - UI(20), self.navigationController.navigationBar.bounds.size.height)];
//        searchBar;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - UI(20), self.navigationController.navigationBar.bounds.size.height)];
        button.backgroundColor = [UIColor lightGrayColor];
        [button addTarget:self action:@selector(_showCommentView) forControlEvents:UIControlEventTouchUpInside];
        button;
    })];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SQListItem *item = [self.dataArray objectAtIndex:indexPath.row];
//    __kindof UIViewController *detailController = [SQMediator detailViewControllerWithUrl:item.articleUrl];
//    detailController.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
//    [self.navigationController pushViewController:detailController animated:YES];
    
//    [SQMediator openUrl:@"detail://" params:@{@"url": item.articleUrl, @"controller": self.navigationController}];
    
    Class cls = [SQMediator classForProtol:@protocol(SQDetailViewControllerProtocol)];
    [self.navigationController pushViewController:[[cls alloc] detailViewControllerWithUrl:item.articleUrl] animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniqueKey];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SQNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[SQNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
    }
    
    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
//    SQDeleteCellView *deleteView = [[SQDeleteCellView alloc] initWithFrame:self.view.bounds];
//    
//    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
//    
//    __weak typeof(self) wself = self;
//    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
//        __strong typeof(self) strongSelf = wself;
//        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
}

#pragma mark -

- (void)_showCommentView {
    [[SQCommentManager sharedManager] showCommentView];
}

@end

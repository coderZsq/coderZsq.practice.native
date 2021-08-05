//
//  SQNewsViewController.m
//  App
//
//  Created by 朱双泉 on 2021/1/8.
//

#import "SQNewsViewController.h"
#import "SQNormalTableViewCell.h"
#import "SQDetailViewController.h"
#import "SQDeleteCellView.h"

@interface SQNewsViewController () <UITableViewDataSource,UITableViewDelegate,SQNormalTableViewCellDelegate>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;
@end

@implementation SQNewsViewController

#pragma mark - life cycle

- (instancetype)init {
	self = [super init];
	if (self) {
		_dataArray = @[].mutableCopy;
		for (int i = 0; i < 20; i++) {
			[_dataArray addObject:@(i)];
		}
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
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	SQDetailViewController *controller = [[SQDetailViewController alloc] init];
	controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
	[self.navigationController pushViewController:controller animated:YES];
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

	[cell layoutTableViewCell];

	return cell;
}

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
	SQDeleteCellView *deleteView = [[SQDeleteCellView alloc] initWithFrame:self.view.bounds];

	CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];

	__weak typeof(self) wself = self;
	[deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
	         __strong typeof(self) strongSelf = wself;
	         [strongSelf.dataArray removeLastObject];
	         [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
	 }];
}

@end

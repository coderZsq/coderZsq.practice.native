//
//  ViewController.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/10/14.
//

#import "SQRACViewController.h"
#import "SQStudent.h"

@interface SQRACViewController ()

@property (nonatomic, strong) SQStudent *student;
@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) UILabel *currentCreditLabel;
@property (nonatomic, strong) UILabel *isSatisfyLabel;

@end

@implementation SQRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    //present
    self.student = [[[[[SQStudent create]
                       name:@"coderZsq"]
                      gender:SQStudentGenderMale]
                     studentNumber:345]
                    filterIsASatisfyCredit:^BOOL(NSUInteger credit){
                        if (credit >= 70) {
                            self.isSatisfyLabel.text = @"合格";
                            self.isSatisfyLabel.textColor = [UIColor redColor];
                            return YES;
                        } else {
                            self.isSatisfyLabel.text = @"不合格";
                            return NO;
                        }
                        
                    }];
    
    [self.testButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.student.creditSubject subscribeNext:^(NSUInteger credit) {
        NSLog(@"第一个订阅的credit处理积分%lu",credit);
        self.currentCreditLabel.text = [NSString stringWithFormat:@"%lu",credit];
        if (credit < 30) {
            self.currentCreditLabel.textColor = [UIColor lightGrayColor];
        } else if(credit < 70) {
            self.currentCreditLabel.textColor = [UIColor purpleColor];
        } else {
            self.currentCreditLabel.textColor = [UIColor redColor];
        }
    }];
    
    [self.student.creditSubject subscribeNext:^(NSUInteger credit) {
        NSLog(@"第二个订阅的credit处理积分%lu",credit);
        if (!(credit > 0)) {
            self.currentCreditLabel.text = @"0";
            self.isSatisfyLabel.text = @"未设置";
        }
    }];
}

- (void)buttonClick {
    [self.student sendCredit:^NSUInteger(NSUInteger credit) {
        credit += 5;
        NSLog(@"current credit %lu",credit);
        [self.student.creditSubject sendNext:credit];
        return credit;
    }];
}

- (void)setupUI {
    [self.view addSubview:self.currentCreditLabel];
    CGFloat currentCreditLabelW = 100;
    CGFloat currentCreditLabelH = 44;
    CGFloat currentCreditLabelX = (self.view.bounds.size.width - currentCreditLabelW) * 0.5 + 50;
    CGFloat currentCreditLabelY = (self.view.bounds.size.height - currentCreditLabelH) * 0.5 - 40;
    self.currentCreditLabel.frame = CGRectMake(currentCreditLabelX, currentCreditLabelY, currentCreditLabelW, currentCreditLabelH);
    
    [self.view addSubview:self.isSatisfyLabel];
    CGFloat isSatisfyLabelW = 100;
    CGFloat isSatisfyLabelH = 44;
    CGFloat isSatisfyLabelX = (self.view.bounds.size.width - isSatisfyLabelW) * 0.5 - 50;
    CGFloat isSatisfyLabelY = (self.view.bounds.size.height - isSatisfyLabelH) * 0.5 - 40;
    self.isSatisfyLabel.frame = CGRectMake(isSatisfyLabelX, isSatisfyLabelY, isSatisfyLabelW, isSatisfyLabelH);
}

#pragma mark - Getter
- (UILabel *)currentCreditLabel {
    if (!_currentCreditLabel) {
        _currentCreditLabel = [[UILabel alloc] init];
        _currentCreditLabel.textColor = [UIColor lightGrayColor];
    }
    return _currentCreditLabel;
}
- (UILabel *)isSatisfyLabel {
    if (!_isSatisfyLabel) {
        _isSatisfyLabel = [[UILabel alloc] init];
        _isSatisfyLabel.textAlignment = NSTextAlignmentRight;
        _isSatisfyLabel.textColor = [UIColor lightGrayColor];
        
    }
    return _isSatisfyLabel;
}
- (UIButton *)testButton {
    if (!_testButton) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testButton setTitle:@"增加5个积分" forState:UIControlStateNormal];
        [_testButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.view addSubview:_testButton];
        CGFloat testButtonW = 200;
        CGFloat testButtonH = 44;
        CGFloat testButtonX = (self.view.bounds.size.width - testButtonW) * 0.5;
        CGFloat testButtonY = (self.view.bounds.size.height - testButtonH) * 0.5;
        _testButton.frame = CGRectMake(testButtonX, testButtonY, testButtonW, testButtonH);
    }
    return _testButton;
}

@end

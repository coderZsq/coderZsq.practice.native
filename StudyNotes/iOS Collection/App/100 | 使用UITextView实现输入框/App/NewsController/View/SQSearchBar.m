//
//  SQSearchBar.m
//  App
//
//  Created by 朱双泉 on 2021/1/22.
//

#import "SQSearchBar.h"
#import "SQScreen.h"

@interface SQSearchBar () <UITextFieldDelegate>

@property (nonatomic, strong, readwrite) UITextField *textField;

@end

@implementation SQSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(UI(10), UI(5), frame.size.width - UI(10) * 2, frame.size.height - UI(5) * 2)];
            _textField.backgroundColor = [UIColor whiteColor];
            _textField.delegate = self;
            _textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
            _textField.leftViewMode = UITextFieldViewModeUnlessEditing;
            _textField.clearButtonMode = UITextFieldViewModeAlways;
            _textField.placeholder = @"今日热点推荐";
            _textField;
        })];
    }
    return self;
}

#pragma mark -

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 字数判断
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return YES;
}

@end

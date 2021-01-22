//
//  SQCommentManager.m
//  App
//
//  Created by 朱双泉 on 2021/1/22.
//

#import "SQCommentManager.h"
#import <UIKit/UIKit.h>
#import "SQScreen.h"

@interface SQCommentManager () <UITextViewDelegate>

@property (nonatomic, strong, readwrite) UIView *backgroundView;
@property (nonatomic, strong, readwrite) UITextView *textView;

@end

@implementation SQCommentManager

+ (SQCommentManager *)sharedManager {
    static SQCommentManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SQCommentManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapBackground)]];
        
        [_backgroundView addSubview:({
            _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, _backgroundView.bounds.size.height, SCREEN_WIDTH, UI(100))];
            _textView.backgroundColor = [UIColor whiteColor];
            _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _textView.layer.borderWidth = 5.f;
            _textView.delegate = self;
            _textView;
        })];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_doTextViewAnimationNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -

- (void)showCommentView {
    UIWindow * window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    } else {
//        window = [UIApplication sharedApplication].keyWindow;
    }
    [window addSubview:_backgroundView];
    [_textView becomeFirstResponder];
}

#pragma mark -

- (void)_tapBackground {
    [_textView resignFirstResponder];
    [_backgroundView removeFromSuperview];
}

- (void)_doTextViewAnimationNotification:(NSNotification *)noti {
    CGFloat duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (keyboardFrame.origin.y >= SCREEN_HEIGHT) {
        // 收起
        [UIView animateWithDuration:duration animations:^{
            self.textView.frame = CGRectMake(0, self.backgroundView.bounds.size.height, SCREEN_WIDTH, UI(100));
        }];
    } else {
        self.textView.frame = CGRectMake(0, self.backgroundView.bounds.size.height, SCREEN_WIDTH, UI(100));
        [UIView animateWithDuration:duration animations:^{
            self.textView.frame = CGRectMake(0, self.backgroundView.bounds.size.height - keyboardFrame.size.height - UI(100), SCREEN_WIDTH, UI(100));
        }];
    }
}

#pragma mark -

// delegate

@end

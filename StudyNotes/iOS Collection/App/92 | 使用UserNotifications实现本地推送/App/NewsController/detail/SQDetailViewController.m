//
//  SQDetailViewController.m
//  App
//
//  Created by 朱双泉 on 2021/1/9.
//

#import "SQDetailViewController.h"
#import <WebKit/WebKit.h>
#import "SQScreen.h"
#import "SQMediator.h"

@interface SQDetailViewController ()<WKNavigationDelegate>
@property (nonatomic, strong, readwrite) WKWebView *webView;
@property (nonatomic, strong, readwrite) UIProgressView *progressView;
@property (nonatomic, copy, readwrite) NSString *articleUrl;
@end

@implementation SQDetailViewController

+ (void)load {
//    [SQMediator registerScheme:@"detail://" processBlock:^(NSDictionary * _Nonnull params) {
//        NSString *url = (NSString *)[params objectForKey:@"url"];
//        UINavigationController *navigationController = (UINavigationController *)[params objectForKey:@"controller"];
//        SQDetailViewController *controller = [[SQDetailViewController alloc] initWithUrlString:url];
////        detailController.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
//        [navigationController pushViewController:controller animated:YES];
//    }];
    
    [SQMediator registerProtol:@protocol(SQDetailViewControllerProtocol) class:[self class]];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        self.articleUrl = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.frame.size.width, self.view.frame.size.height - STATUSBARHEIGHT - 44)];
        self.webView.navigationDelegate = self;
        self.webView;
    })];
    
    [self.view addSubview:({
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 44, self.view.frame.size.width, 20)];
        self.progressView;
    })];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleUrl]]];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    self.progressView.progress = self.webView.estimatedProgress;
    NSLog(@"");
}

#pragma mark -

- (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl{
    return [[[self class] alloc] initWithUrlString:detailUrl];
}

@end

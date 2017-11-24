//
//  BaseWebVC.m
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseWebVC.h"



@interface BaseWebVC ()<WKUIDelegate, WKNavigationDelegate>


// @xaoxuu: progress
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end


@implementation BaseWebVC

+ (instancetype)webVCWithURLString:(NSString *)url{
    return [[self alloc] initWithURLString:url];
}

- (instancetype)initWithURLString:(NSString *)url{
    if (self = [super init]) {
        _urlStr = url;
    }
    return self;
}

+ (instancetype)webVCWithTitle:(NSString *)title URLString:(NSString *)url{
    return [[self alloc] initWithTitle:title URLString:url];
}

- (instancetype)initWithTitle:(NSString *)title URLString:(NSString *)url{
    if (self = [self initWithURLString:url]) {
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _base_setupWebView];
    [self reloadWebView];
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithSystem:UIBarButtonSystemItemRefresh action:^(id  _Nonnull sender) {
        [weakSelf reloadWebView];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)reloadWebView{
    [self loadWithURLString];
    if ([self respondsToSelector:@selector(didLoadWebView)]) {
        [self didLoadWebView];
    }
}


- (void)loadWithURLString{
    if ([self respondsToSelector:@selector(URLStringForWebView)]) {
        self.urlStr = [self URLStringForWebView];
    }
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.progressView.alpha = 1;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.progressView.alpha = 0;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.progressView removeFromSuperview];
}

- (void)_base_setupWebView{
    [self webView];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    if ([self respondsToSelector:@selector(initWebView:)]) {
        [self initWebView:self.webView];
    }
    
    self.indicator = [UIActivityIndicatorView defaultIndicatorWithLoading];
    [self.indicator addToView:self.view withLoading:YES];
    
}

- (WKWebView *)webView{
    if (!_webView) {
        //初始化一个WKWebViewConfiguration对象
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        //初始化偏好设置属性：preferences
        config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        config.preferences.minimumFontSize = 14;
        //是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        [self.view addSubview:_webView];
        
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 2)];
        _progressView.tintColor = [UIColor whiteColor];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.bottom = self.navigationController.navigationBar.height;
        [self.navigationController.navigationBar addSubview:_progressView];
    }
    return _progressView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if (object == self.webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if (self.webView.estimatedProgress > 0.2) {
                self.indicator.alpha = 1.4 - 2*self.webView.estimatedProgress;
            }
            if (self.webView.estimatedProgress >= 1.0f) {
                [self.indicator stopAnimating];
                [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
                
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    } else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.navigationItem.title = self.webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    @try {
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
        [self.webView removeObserver:self forKeyPath:@"title"];
    }
    @catch (NSException *exception) {
    }
}



@end

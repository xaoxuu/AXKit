//
//  BaseWebVC.h
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@class BaseWebVC;
@protocol BaseWebVC <NSObject>
@optional


/**
 初始化webview

 @param webView webview
 */
- (void)initWebView:(WKWebView *)webView;

- (NSString *)URLStringForWebView;

/**
 webview加载完毕
 */
- (void)didLoadWebView;




@end


@interface BaseWebVC : BaseViewController <BaseWebVC>


// @xaoxuu: url string
@property (copy, nonatomic) NSString *urlStr;


+ (instancetype)webVCWithURLString:(NSString *)url;

+ (instancetype)webVCWithTitle:(NSString *)title URLString:(NSString *)url;

- (void)reloadWebView;

@end

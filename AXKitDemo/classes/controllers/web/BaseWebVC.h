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
@protocol BaseWebVCDelegate <NSObject>
@optional

- (void)setupFrame;

- (void)setupWebView:(WKWebView *)webView;


- (void)didLoadWebView;




@end


@interface BaseWebVC : BaseViewController <BaseWebVCDelegate>



// @xaoxuu: url string
@property (copy, nonatomic) NSString *urlStr;

+ (instancetype)webVCWithURLString:(NSString *)url;

+ (instancetype)webVCWithTitle:(NSString *)title URLString:(NSString *)url;

- (void)reloadWebView;

@end

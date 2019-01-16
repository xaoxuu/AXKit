//
//  DocVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 30/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "DocVC.h"
#import "FullWideButton.h"
#import "AXStatusKit.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DocVC ()

@end

@implementation DocVC

- (void)viewDidLoad {
    self.urlStr = @"https://xaoxuu.com/docs/axkit/#/zh-cn/";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *header = [[UIView alloc] initWithHeight:20];
    header.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
    
}

- (CGRect)initContentFrame:(CGRect)frame{
    frame.origin.y = kStatusBarHeight;
    frame.size.height = kScreenH - kTabBarHeight;
    return frame;
}

- (void)didLoadWebView{
    UIView *bg = [[UIView alloc] initWithHeight:1];
    [self.view insertSubview:bg atIndex:0];
    self.webView.top = kStatusBarHeight;
    self.webView.height = self.view.height - kStatusBarHeight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


@end

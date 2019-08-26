//
//  HomeVC.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "HomeVC.h"
#import "FullWideButton.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeVC ()





@end

@implementation HomeVC

- (void)viewDidLoad {
    self.urlStr = @"https://xaoxuu.com/docs/axkit/#/zh-cn/";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
//    [self.view ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
//        [AXStatusBar showStatusBarMessage:NSStringFromCGPoint([sender locationInView:sender.view]) textColor:[UIColor darkTextColor] backgroundColor:axThemeManager.color.theme duration:2];
//    }];
//    [self.view ax_addPanGesture:nil handler:^(UIPanGestureRecognizer * _Nonnull sender) {
//        [AXStatusBar showStatusBarMessage:NSStringFromCGPoint([sender locationInView:sender.view]) textColor:[UIColor darkTextColor] backgroundColor:axThemeManager.color.theme duration:2];
//    }];

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

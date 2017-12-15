//
//  BlogVC.m
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BlogVC.h"
#import "StatusKit.h"

@interface BlogVC ()

@end

@implementation BlogVC

- (void)viewDidLoad {
    self.urlStr = @"https://blog.xaoxuu.com";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *bar = [[UIView alloc] initWithFrame:[AXStatusBar getCustomStatusBar].bounds];
    bar.backgroundColor = [UIColor ax_blue];
    [self.view insertSubview:bar aboveSubview:self.webView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 0;
    [AXStatusBar getCustomStatusBar].backgroundColor = [UIColor ax_blue];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.alpha = 0;
    [AXStatusBar getCustomStatusBar].backgroundColor = [UIColor ax_blue];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
    [AXStatusBar getCustomStatusBar].backgroundColor = [UIColor clearColor];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
    [AXStatusBar getCustomStatusBar].backgroundColor = [UIColor clearColor];
}

- (CGRect)initContentFrame:(CGRect)frame{
    return kScreenBounds;
}

@end

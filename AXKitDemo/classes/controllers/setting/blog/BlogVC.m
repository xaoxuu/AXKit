//
//  BlogVC.m
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BlogVC.h"

static UIView *statusBar;
static UIView *customView;

@interface BlogVC ()

@end

@implementation BlogVC

- (void)viewDidLoad {
    self.urlStr = services.app.model.blogURL;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    statusBar = [UIApplication ax_getSystemStatusBar];
    if (!customView) {
        customView = UIViewWithHeight(kStatusBarHeight);
    }
    customView.backgroundColor = [UIColor ax_blue];
    [statusBar insertSubview:customView atIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 0;
    [statusBar insertSubview:customView atIndex:0];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.alpha = 0;
    [statusBar insertSubview:customView atIndex:0];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
    [customView removeFromSuperview];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
    [customView removeFromSuperview];
}

- (CGRect)initContentFrame:(CGRect)frame{
    return CGRectFromScreen();
}

@end

//
//  BlogVC.m
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BlogVC.h"


@interface BlogVC ()

@end

@implementation BlogVC

- (void)viewDidLoad {
    self.urlStr = services.app.model.blogURL;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 0;
    [UIApplication ax_getCustomStatusBar].backgroundColor = [UIColor ax_blue];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.alpha = 0;
    [UIApplication ax_getCustomStatusBar].backgroundColor = [UIColor ax_blue];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
    [UIApplication ax_getCustomStatusBar].backgroundColor = [UIColor clearColor];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
    [UIApplication ax_getCustomStatusBar].backgroundColor = [UIColor clearColor];
}

- (CGRect)initContentFrame:(CGRect)frame{
    return CGRectFromScreen();
}

@end

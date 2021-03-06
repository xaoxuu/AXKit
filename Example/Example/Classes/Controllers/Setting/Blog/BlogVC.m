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
    
    if (!self.urlStr.length) {
        self.urlStr = @"https://xaoxuu.com";
    } else {
        self.urlStr = [NSString stringWithFormat:@"https://%@", self.urlStr];
    }
    
    if ([self.title isEqualToString:@"文档"]) {
        self.urlStr = @"https://xaoxuu.com/docs/axkit/#/zh-cn/";
    } else if ([self.title isEqualToString:@"更新日志"]) {
        self.urlStr = @"https://xaoxuu.com/docs/axkit/#/zh-cn/appendix/changelog";
    }
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
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.alpha = 0;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
    
}

- (CGRect)initContentFrame:(CGRect)frame{
    return kScreenBounds;
}

@end

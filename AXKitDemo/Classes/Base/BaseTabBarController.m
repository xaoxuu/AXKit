//
//  BaseTabBarController.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBar.layer ax_shadow:LayerShadowUpLight];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tabBar ax_hideSeparator];
//    [services.app applyTheme];
}

- (NSString *)configurationFilePath{
    NSString *path;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path = [[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@"json"];
    }
    return path;
}

- (NSString *)classNameForBaseNavigationController{
    return @"BaseNavController";
}


@end

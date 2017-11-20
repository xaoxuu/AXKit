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
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:ThemeKitNotificationColorChanged object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tabBar ax_hideSeparator];

    
    [self updateTheme];
   
    
}

- (void)updateTheme{
    self.tabBar.translucent = NO;
    if (axThemeManager.color.theme.isLightColor) {
        self.tabBar.tintColor = axThemeManager.color.theme.darkRatio(0.3);
    } else {
        self.tabBar.tintColor = axThemeManager.color.theme;
    }
}

- (NSString *)configurationFilePath{
    return [service.cache cacheForClassWithName:NSStringFromClass(self.class)];
}

- (NSString *)classNameForBaseNavigationController{
    return @"BaseNavController";
}


@end

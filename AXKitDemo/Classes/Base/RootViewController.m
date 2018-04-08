//
//  RootViewController.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "RootViewController.h"
#import "AXStatusBar.h"
#import "AXDrawerKit.h"
#import "SettingVC.h"
#import "AboutVC.h"
#import "DebugVC.h"
#import "BaseNavController.h"

@interface RootViewController ()


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = axThemeManager.color.theme;
    DebugVC *debugVC = [[DebugVC alloc] init];
    SettingVC *settingVC = [[SettingVC alloc] init];
    AboutVC *aboutVC = [[AboutVC alloc] init];
    BaseNavController *mainVC = [[BaseNavController alloc] initWithRootViewController:debugVC];
    [mainVC.view.layer ax_shadow:LayerShadowCenterHeavy];
    mainVC.view.layer.shadowRadius = 6.0f;
    mainVC.view.layer.shadowOffset = CGSizeMake(0, 0);
    mainVC.view.layer.shadowOpacity = 0.6f;
    
    [self at_setupMainVC:mainVC drawerVC:aboutVC enable:YES];
    
    [self.view addSubview:debugVC.view];
    
//    self.mainTabBarVC = [[BaseTabBarController alloc] init];
//    [self.mainTabBarVC.view.layer ax_shadow:LayerShadowCenterNormal];
//    [self addChildViewController:self.mainTabBarVC];
//    [self.view addSubview:self.mainTabBarVC.view];
//    [services.app applyTheme];
    
    
    // 彩蛋
    if (CGConstGetScreenSizeEnum() == kCGScreenSizeEnum_5_8) {
        
        UIView *bar = [AXStatusBar getSystemStatusBar];
        UILabel *lb = [[UILabel alloc] initWithFrame:bar.bounds];
        lb.height = 24;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"^_^";
        [bar addSubview:lb];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end

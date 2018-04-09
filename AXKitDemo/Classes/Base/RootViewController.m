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

@property (strong, nonatomic) BaseNavController *mainVC;

@property (strong, nonatomic) AboutVC *aboutVC;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = axThemeManager.color.theme;
    DebugVC *debugVC = [[DebugVC alloc] init];
    self.aboutVC = [[AboutVC alloc] init];
    self.mainVC = [[BaseNavController alloc] initWithRootViewController:debugVC];
    [self.mainVC.view.layer ax_shadow:LayerShadowCenterHeavy];
    self.mainVC.view.layer.shadowRadius = 6.0f;
    self.mainVC.view.layer.shadowOffset = CGSizeMake(0, 0);
    self.mainVC.view.layer.shadowOpacity = 0.6f;
    
    [self at_setupMainVC:self.mainVC drawerVC:self.aboutVC enable:YES];
    self.mainVC.view.transform = CGAffineTransformMakeTranslation(kScreenW, 0);
    self.aboutVC.view.transform = CGAffineTransformMakeTranslation(-60, 0);
    [self.view addSubview:debugVC.view];
    
//    self.mainTabBarVC = [[BaseTabBarController alloc] init];
//    [self.mainTabBarVC.view.layer ax_shadow:LayerShadowCenterNormal];
//    [self addChildViewController:self.mainTabBarVC];
//    [self.view addSubview:self.mainTabBarVC.view];
//    [services.app applyTheme];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:ThemeKitNotificationColorChanged object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:ThemeKitNotificationFontChanged object:nil];
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut animations:^{
        self.mainVC.view.transform = CGAffineTransformIdentity;
        self.aboutVC.view.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
    
}

- (void)updateTheme{
    self.view.backgroundColor = axThemeManager.color.theme;
}


@end

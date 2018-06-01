//
//  BaseNavController.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.navigationBar ax_hideSeparator];
    [self.navigationBar.layer ax_shadow:LayerShadowDownNormal];
    
    [self updateTheme];
    
    if (@available(iOS 11.0, *)) {
        // on newer versions
        self.navigationBar.prefersLargeTitles = YES;
    } else {
        // Fallback on earlier versions
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:ThemeKitNotificationColorChanged object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:ThemeKitNotificationFontChanged object:nil];
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


- (void)updateTheme{
    [axThemeManager updateThemeForNavigationBar:self.navigationBar];
    
    UIViewController.rootViewController.view.backgroundColor = axThemeManager.color.theme;
}



@end

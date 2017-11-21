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
        self.navigationBar.prefersLargeTitles = NO;
    } else {
        // Fallback on earlier versions
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:ThemeKitNotificationColorChanged object:nil];
    
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


- (void)updateTheme{
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = axThemeManager.color.theme;
    if (axThemeManager.color.theme.isLightColor) {
        self.navigationBar.tintColor = axThemeManager.color.theme.darkRatio(0.7);
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:axThemeManager.color.theme.darkRatio(0.7)}];
        
    } else {
        self.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
    }
}



@end

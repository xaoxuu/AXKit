//
//  ThemeStoreVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeStoreVC.h"
#import "ThemeCollectionView.h"

@interface ThemeStoreVC ()

@end

@implementation ThemeStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"在线主题";
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithTitle:@"管理" action:^(UIBarButtonItem * _Nonnull sender) {
        [weakSelf.navigationController ax_pushViewControllerNamed:@"ThemeManageVC"];
    }];
    self.view.backgroundColor = axThemeManager.color.background;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

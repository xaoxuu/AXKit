//
//  ThemeManageVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeManageVC.h"
#import "CachedThemeCollectionView.h"
#import <SDImageCache.h>

@interface ThemeManageVC ()
@property (weak, nonatomic) IBOutlet CachedThemeCollectionView *collectionView;

@end

@implementation ThemeManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"主题管理";
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithImageName:@"icon_trash" action:^(UIBarButtonItem * _Nonnull sender) {
        [axThemeManager deleteAllThemes];
        [weakSelf.collectionView reloadDataSourceAndUpdateUI];
    }];
    self.view.backgroundColor = axThemeManager.color.background;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

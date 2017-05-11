//
//  RemoveCacheVC.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "RemoveCacheVC.h"
#import "CacheTableView.h"
#import "ThemeBgButton.h"

@interface RemoveCacheVC ()

// @xaoxuu: cache table view
@property (strong, nonatomic) CacheTableView *cacheTable;

@property (weak, nonatomic) IBOutlet ThemeBgButton *btn_remove;

@end

@implementation RemoveCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView{
    self.cacheTable = [[CacheTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-kTopBarHeight-kTabBarHeight)];
    [self.view addSubview:self.cacheTable];
}


- (void)setupButtons{
    self.btn_remove.layer.ax_shadow(AXShadowUpLight);
    [self.btn_remove ax_addTouchUpInsideHandler:^(__kindof UIButton * _Nonnull sender) {
        [services.cache removeSettingCacheCompletion:^{
            [sender setEnabled:NO];
        }];
    }];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.view addSubview:self.btn_remove];
}

@end

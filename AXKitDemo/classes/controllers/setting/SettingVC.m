//
//  SettingVC.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "SettingVC.h"
#import "SettingTableView.h"

@interface SettingVC ()


@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initContentView:(UIView *)view style:(void (^)(ContentViewStyle))style{
    style(ContentViewStyleNoTopAndBottomBar);
}


- (BaseTableView *)installTableView{
    return [[SettingTableView alloc] initWithFrame:self.view.bounds];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadTableView];
}

- (void)installRightRefreshBarButton:(UIBarButtonItem *)sender{
    [self.tableView reloadDataSourceAndTableView];
}



@end

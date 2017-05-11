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

// @xaoxuu: table
@property (strong, nonatomic) SettingTableView *table;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = CGRectMake(0, 0, kScreenW, kScreenH-kTopBarHeight-kTabBarHeight);
    [self setupTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTable{
    self.table = [[SettingTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.table];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.table reloadData];
}

@end

//
//  HelpVC.m
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "HelpVC.h"
#import "HelpTableView.h"

@interface HelpVC ()

// @xaoxuu: help
//@property (strong, nonatomic) HelpTableView *tableView;

@end

@implementation HelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BaseTableView *)setupTableView{
    self.tableView = [[HelpTableView alloc] initWithFrame:self.view.bounds];
    return self.tableView;
}

- (void)setupRightRefreshBarButton:(UIBarButtonItem *)sender{
    [self.tableView reloadDataSourceAndRefreshTableView];
}




- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tableView searchBarEndEditing];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.tableView searchBarEndEditing];
}

@end

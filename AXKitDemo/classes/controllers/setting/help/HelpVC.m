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



- (UITableView<BaseTableView> *)installTableView{
    self.tableView = [[HelpTableView alloc] initWithFrame:self.view.bounds];
    return self.tableView;
}

- (void)installRightRefreshBarButton:(UIBarButtonItem *)sender{
    [self.tableView reloadDataSourceAndTableView];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [(HelpTableView *)self.tableView searchBarEndEditing];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [(HelpTableView *)self.tableView searchBarEndEditing];
}

@end

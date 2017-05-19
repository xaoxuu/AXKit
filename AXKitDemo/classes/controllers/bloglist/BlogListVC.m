//
//  BlogListVC.m
//  AXKit
//
//  Created by xaoxuu on 19/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BlogListVC.h"
#import "BlogListTableView.h"
@interface BlogListVC ()

@end

@implementation BlogListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BaseTableView *)setupTableView{
    return [[BlogListTableView alloc] initWithFrame:self.view.bounds];
}

@end

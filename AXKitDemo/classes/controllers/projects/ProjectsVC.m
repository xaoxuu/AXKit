//
//  ProjectsVC.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ProjectsVC.h"
#import "ProjectsTableView.h"

@interface ProjectsVC ()

// @xaoxuu: table view
@property (strong, nonatomic) ProjectsTableView *projectTable;

@end

@implementation ProjectsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupTableView{
    self.projectTable = [[ProjectsTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.projectTable];
}



@end

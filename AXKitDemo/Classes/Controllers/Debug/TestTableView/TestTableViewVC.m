//
//  TestTableViewVC.m
//  AXKit
//
//  Created by xaoxuu on 13/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "TestTableViewVC.h"
#import "TestTV.h"

@interface TestTableViewVC ()

@end

@implementation TestTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView<BaseTableView> *)installTableView{
    return [[TestTV alloc] initWithFrame:self.view.bounds];
}

@end

//
//  ReleaseLogVC.m
//  AXKit
//
//  Created by xaoxuu on 29/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ReleaseLogVC.h"
#import "ReleaseLogTV.h"

@interface ReleaseLogVC ()

@end

@implementation ReleaseLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableView<BaseTableView> *)installTableView{
    return [[ReleaseLogTV alloc] initWithFrame:self.view.bounds];
}

@end

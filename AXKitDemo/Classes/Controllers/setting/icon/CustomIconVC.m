//
//  CustomIconVC.m
//  AXKit
//
//  Created by xaoxuu on 19/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CustomIconVC.h"
#import "CustomIconTableView.h"

@interface CustomIconVC ()

@end

@implementation CustomIconVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView<BaseTableView> *)installTableView{
    return [[CustomIconTableView alloc] initWithFrame:self.view.bounds];
}

@end

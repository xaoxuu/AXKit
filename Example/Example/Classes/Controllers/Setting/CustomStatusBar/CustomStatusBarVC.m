//
//  CustomStatusBarVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CustomStatusBarVC.h"
#import "CustomStatusBarTV.h"

@interface CustomStatusBarVC ()

@end

@implementation CustomStatusBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"自定义状态栏", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AXTableViewType *)installTableView{
    return [[CustomStatusBarTV alloc] initWithFrame:self.view.bounds];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 1;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.alpha = 1;
}

@end

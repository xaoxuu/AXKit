//
//  OpenSettingVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 30/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "OpenSettingVC.h"
#import "OpenSettingTV.h"

@interface OpenSettingVC ()

@end

@implementation OpenSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AXTableViewType *)installTableView{
    CGRect frame = self.view.bounds;
    return [[OpenSettingTV alloc] initWithFrame:frame];
}


@end

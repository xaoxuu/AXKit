//
//  HomeVC.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "HomeVC.h"
#import "TestVC1.h"
@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = CGRectMake(0, 0, kScreenW, kScreenH-kTopBarHeight-kTabBarHeight);
    
    [self.view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        [subview ax_fillWithRandomColor];

    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn1:(UIButton *)sender {
    [NSBlockOperation ax_delay:0 cooldown:3 token:self performInMainQueue:^{
        [sender ax_fillWithRandomColor];
    }];
}

- (IBAction)btn2:(UIButton *)sender {
    [NSBlockOperation ax_delay:2 cooldown:5 token:self performInMainQueue:^{
        [sender ax_fillWithRandomColor];
    }];
}
// @xaoxuu: 两者的token相同则共享冷却时间。


@end

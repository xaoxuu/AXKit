//
//  RootViewController.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "RootViewController.h"
#import "BaseTabBarController.h"

@interface RootViewController ()

// @xaoxuu: tabbar controller
@property (strong, nonatomic) BaseTabBarController *mainTabBarVC;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainTabBarVC = [[BaseTabBarController alloc] init];
    [self addChildViewController:self.mainTabBarVC];
    [self.view addSubview:self.mainTabBarVC.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
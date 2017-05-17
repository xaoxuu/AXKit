//
//  DebugVC.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DebugVC.h"

@interface DebugVC ()

@end

@implementation DebugVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = CGRectMake(0, 0, kScreenW, kScreenH-kTopBarHeight-kTabBarHeight);
    
    UIViewController *vc = self.rootVC;
    
    UIViewController *vc2 = AXRootViewController();
    AXLogOBJ(vc);
    AXLogOBJ(vc2);
    
    [NSUserDefaults ax_readStringForKey:@"adf" completion:^(NSString * _Nonnull string) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutSubviews];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)hitTest:(UIButton *)sender {
    [self.navigationController ax_pushViewControllerNamed:@"HitTestVC"];
}



@end

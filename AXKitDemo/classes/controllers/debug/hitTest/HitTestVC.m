//
//  HitTestVC.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "HitTestVC.h"

@interface HitTestVC ()

@end

@implementation HitTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.frame = CGRectMake(0, 0, kScreenW, kScreenH-kTopBarHeight-kTabBarHeight);
    
    [self.view ax_eachSubview:nil action:^(__kindof UIView * _Nonnull subview) {
        [subview ax_fillWithRandomColor];
        [subview ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
            CGPoint loc = [sender locationInView:self.view];
            [AXProgressHUD ax_target:self.rootVC.view point:loc showInfo:sender.view.description duration:0.5];
        }];
    }];
    
    [self.view ax_eachButtonInvokeAction:^(__kindof UIButton * _Nonnull button) {
        [button ax_addTouchUpInsideHandler:^(__kindof UIButton * _Nonnull sender) {
            [self.navigationController ax_pushViewControllerNamed:@"TestVC12"];
        }];
    }];
    [self.view ax_eachImageViewInvokeAction:^(__kindof UIImageView * _Nonnull imageView) {
        [imageView ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
            [self.navigationController ax_pushViewControllerNamed:@"TestVC13"];
        }];
    }];
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

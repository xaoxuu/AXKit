//
//  HitTestVC.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "HitTestVC.h"

@interface HitTestVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgv;

@end

@implementation HitTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __weak typeof(self) weakSelf = self;
    [self.view ax_allSubviews:nil action:^(__kindof UIView * _Nonnull subview) {
        [subview ax_fillWithRandomColor];
        [subview ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
            CGPoint loc = [sender locationInView:weakSelf.view];
            [AXProgressHUD ax_target:UIViewController.rootViewController.view point:loc showInfo:sender.view.description duration:0.5];
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

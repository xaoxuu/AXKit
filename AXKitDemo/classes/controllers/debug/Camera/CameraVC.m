//
//  CameraVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 11/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CameraVC.h"
#import "FullWideButton.h"
#import "UIViewController+CameraExtension.h"

@interface CameraVC ()

// @xaoxuu: camera


@end

@implementation CameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FullWideButton *btn = [FullWideButton buttonWithTitle:@"样式1" action:^(__kindof BaseButton *sender) {
        [self showImagePicker];
    }];
    [btn addToView:self.view withBottom:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

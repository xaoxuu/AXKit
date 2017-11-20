//
//  HomeVC.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "HomeVC.h"
#import "FullWideButton.h"

@interface HomeVC ()





@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    FullWideButton * btn1 = [FullWideButton buttonWithTitle:@"wifi" action:^(__kindof BaseButton *sender) {
        [UIApplication ax_openWIFISetting];
    }];
    [btn1 addToView:self.view withTop:8];
    
    FullWideButton * btn2 = [FullWideButton buttonWithTitle:@"bluetooth" action:^(__kindof BaseButton *sender) {
        [UIApplication ax_openBluetoothSetting];
    }];
    [btn2 addToView:self.view withTop:58];
    
    FullWideButton * btn3 = [FullWideButton buttonWithTitle:@"通知" action:^(__kindof BaseButton *sender) {
        [UIApplication ax_openNotificationSetting];
    }];
    [btn3 addToView:self.view withTop:108];
    
    FullWideButton * btn4 = [FullWideButton buttonWithTitle:@"photos" action:^(__kindof BaseButton *sender) {
        [UIApplication ax_openPhotosSetting];
    }];
    [btn4 addToView:self.view withTop:158];
    
    FullWideButton * btn5 = [FullWideButton buttonWithTitle:@"safari" action:^(__kindof BaseButton *sender) {
        [UIApplication ax_openSafariSetting];
    }];
    [btn5 addToView:self.view withTop:208];
    
    FullWideButton * btn6 = [FullWideButton buttonWithTitle:@"app" action:^(__kindof BaseButton *sender) {
        [UIApplication ax_openAppSetting];
    }];
    [btn6 addToView:self.view withTop:208];
    
    
    NSDate *date = [NSDate date];
    
    int x = 1;
    [NSDate dateWithDateInteger:x];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:ThemeKitNotificationThemeColorChanged object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        UIView *view = AXRootViewController().view;
//        [view removeFromSuperview];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}




@end

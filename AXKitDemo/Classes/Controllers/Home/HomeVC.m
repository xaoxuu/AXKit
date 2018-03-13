//
//  HomeVC.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "HomeVC.h"
#import "FullWideButton.h"
#import "StatusKit.h"
#import <UIImageView+WebCache.h>

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
    
//    int x = 1;
//    [NSDate ax_dateWithIntegerValue:x];
//    __weak typeof(self) weakSelf = self;
//    [[NSNotificationCenter defaultCenter] addObserverForName:ThemeKitNotificationColorChanged object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        [weakSelf.view layoutSubviews];
//    }];
//    
//    [[NSNotificationCenter defaultCenter] addObserverForName:ThemeKitNotificationFontChanged object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        [weakSelf.view layoutSubviews];
//    }];
    
    // 彩蛋
    if (CGConstGetScreenSizeEnum() == kCGScreenSizeEnum_5_8) {
        
        UIView *bar = [AXStatusBar getSystemStatusBar];
        UILabel *lb = [[UILabel alloc] initWithFrame:bar.bounds];
        lb.height = 24;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"^_^";
        [bar addSubview:lb];
    }
//    AXLogCGFloat(kScreenWidth);
//    AXLogCGFloat(kScreenHeight);
    
    
//    AXLogOBJ(AXMakeNumberInRange(@100, @0, @111));
//    AXLogOBJ(AXMakeNumberInRange(@100, @0, @90));
    
    
    [AXRuntimeHelper exchangeInstanceMethodImplementations:self.class selector1:@selector(test1) selector2:@selector(test2)];

    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self test2];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self test1];
//    for (int i = -3; i < 3; i++) {
//        AXLogOBJ(AXMakeNumberInRange(@(i), @(-1), @1));
//    }
//    NSMutableArray<NSNumber *> *tmp = [NSMutableArray arrayWithCapacity:100];
//    for (int i = 0; i < 100; i++) {
//        [tmp addObject:@(AXRandomFloatInRange(0, 1))];
//    }
//    AXLogOBJ(tmp);
//    AXLogCGRect([UIScreen mainScreen].bounds);
    
    
}

- (void)test1{
    
}


- (void)test2{
    
}

@end

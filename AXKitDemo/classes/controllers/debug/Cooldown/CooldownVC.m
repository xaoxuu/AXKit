//
//  CooldownVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 21/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CooldownVC.h"
#import "FullWideButton.h"

static ax_dispatch_operation_t token = nil;
static int i;
static NSTimeInterval timeout = 2;


@interface CooldownVC ()

@property (strong, nonatomic) FullWideButton *delayButton;

@property (strong, nonatomic) UILabel *label;


@end

@implementation CooldownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = axColor.groupTableViewBackground;
    self.label = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.label.text = @"0";
    self.label.height -= kTabBarHeight;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont boldSystemFontOfSize:180];
    [self.label adjustsFontSizeToFitWidth];
    self.label.textColor = axColor.theme.adaptive;
    [self.view addSubview:self.label];
    
    [self reset];
    
    
    NSString *title = [NSString stringWithFormat:@"将事件向后拖延%.0f秒", timeout];
    __weak typeof(self) weakSelf = self;
    weakSelf.delayButton = [FullWideButton buttonWithTitle:title action:^(__kindof BaseButton *sender) {
        weakSelf.label.text = NSStringFromInt(++i);
        ax_dispatch_cancel_operation(token);
        token = ax_dispatch_cancellable(timeout, dispatch_get_main_queue(), ^{
            NSString *msg = [NSString stringWithFormat:@"最近%.0f秒内没有点击事件", timeout];
            [UIAlertController ax_showAlertWithTitle:@"超时测试" message:msg actions:^(UIAlertController * _Nonnull alert) {
                [alert ax_addCancelActionWithTitle:nil handler:^(UIAlertAction * _Nonnull sender) {
                    [weakSelf reset];
                }];
            }];
        });
    }];
    [self.delayButton.layer ax_shadow:LayerShadowUpLight];
    [self.delayButton addToView:self.view withBottom:0];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    ax_dispatch_cancel_operation(token);
}

- (void)dealloc{
    [self reset];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reset{
    i = 0;
    self.label.text = NSStringFromInt(i);
}

@end

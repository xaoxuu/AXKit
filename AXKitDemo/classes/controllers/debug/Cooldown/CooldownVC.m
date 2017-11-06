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
static UIView *customView;

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
    
    
    NSString *title = [NSString stringWithFormat:@"%.0f秒后，数字归零", timeout];
    __weak typeof(self) weakSelf = self;
    weakSelf.delayButton = [FullWideButton buttonWithTitle:title action:^(__kindof BaseButton *sender) {
        weakSelf.label.text = NSStringFromInt(++i);
        ax_dispatch_cancel_operation(token);
        token = ax_dispatch_cancellable(timeout, dispatch_get_main_queue(), ^{
            NSString *msg = [NSString stringWithFormat:@"最近%.0f秒内没有点击事件", timeout];
            [weakSelf reset];
            
            UIView *statusBar = [UIApplication ax_getSystemStatusBar];
            if (!customView) {
                customView = UIViewWithHeight(kStatusBarHeight);
            }
            // @xaoxuu: 状态栏通知
            CGRect frame = customView.bounds;
            frame.origin.x = 8;
            frame.size.width = kScreenW - 2*8;
            UILabel *label = [[UILabel alloc] initWithFrame:frame];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:12];
            [customView removeAllSubviews];
            [customView addSubview:label];
            customView.alpha = 0;
            
            [statusBar addSubview:customView];
            customView.backgroundColor = [UIColor md_yellow];
            label.text = msg;
            [UIView animateWithDuration:0.38f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                customView.alpha = 1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.38f delay:2 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                    customView.alpha = 0;
                } completion:^(BOOL finished) {
                    customView.alpha = 0;
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

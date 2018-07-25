//
//  CooldownVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 21/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CooldownVC.h"
#import "FullWideButton.h"
#import "AXStatusKit.h"


static dispatch_block_t token = nil;
static int i;
static NSTimeInterval timeout = 2;
static UIView *customView;

@interface CooldownVC ()

//@property (strong, nonatomic) FullWideButton *delayButton;

@property (strong, nonatomic) UILabel *label;



@end

@implementation CooldownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"延迟函数";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = axThemeManager.color.groupTableViewBackground;
    CGRect frame = self.view.bounds;
//    frame.origin.y += kTopBarHeight();
    frame.size.height += kTopBarHeight;
    self.label = [[UILabel alloc] initWithFrame:frame];
    self.label.text = @"0";
    self.label.height -= kTabBarHeight;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont boldSystemFontOfSize:180];
    [self.label adjustsFontSizeToFitWidth];
    self.label.textColor = axThemeManager.color.theme.adaptive;
    [self.view addSubview:self.label];
    
    [self reset];
    
    CGFloat width = self.view.frame.size.width - 32;
    UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(16, 80, width, 100)];
    [self.view addSubview:tips];
    tips.numberOfLines = 0;
    tips.font = [UIFont systemFontOfSize:14];
    tips.text = @"点击屏幕任意地方，计数会增加。某次点击结束后2秒内没有再次收到点击事件，就触发了事件A。（也就是说，每次点击都会延迟事件A的执行）\n\n事件A：计数器归0，弹出消息。";
    CGFloat height = [tips.text boundingHeightWithFont:tips.font maxWidth:width];
    tips.frame = CGRectMake(16, 16, width, height);
    [tips sizeToFit];
    tips.textColor = [UIColor darkGrayColor];
    
    typeof(self) weak = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithImageName:@"icon_help" action:^(UIBarButtonItem * _Nonnull sender) {
        [weak presentSafariViewControllerWithURL:[NSURL URLWithString:@"https://blog.xaoxuu.com/ios/2017-11-09-gcd-delay"] completion:nil];
    }];
    
}



- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    ax_dispatch_cancel(token);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.label.text = @(++i).stringValue;
    
    token = ax_dispatch_postpone(token, timeout, dispatch_get_main_queue(), ^{
        NSString *msg = [NSString stringWithFormat:@"最近%.0f秒内没有点击事件", timeout];
        AXLogOBJ(msg);
        [self reset];
        [AXProgressHUD ax_target:self.view showInfo:msg duration:1];
    });
    
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
    self.label.text = @(i).stringValue;
}



@end

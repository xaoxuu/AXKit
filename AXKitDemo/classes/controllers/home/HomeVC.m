//
//  HomeVC.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "HomeVC.h"

static ax_dispatch_operation_t token = nil;
@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setStatusBarBackgroundColor:[UIColor md_red]];
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        [self setStatusBarBackgroundColor:[UIColor md_green]];
    } completion:nil];
}
- (void)setStatusBarBackgroundColor:(UIColor *)color
{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    [statusBar ax_layer:^(CALayer * _Nonnull layer) {
        [layer ax_shadow:LayerShadowDownNormal];
    }];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = color;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    
    ax_dispatch_cancel_operation(token);
    token = ax_dispatch_cancellable(1, dispatch_get_main_queue(), ^{
        AXLogSuccess();
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    AXLogOBJ(@(CGSizeMake(120, 120)));
//    
//    AXLogOBJ(@(CGRectMake(123, 123, 234, 234)));
    
    /*
    // @xaoxuu: 一行代码的消息弹窗
    [UIAlertController ax_showAlertWithTitle:@"Hello Alert" message:@"这是用一行代码弹出来的只有一个按钮的窗口" action:nil];
    
    // @xaoxuu: 最常用的【取消】+【确定】弹窗
    [UIAlertController ax_showAlertWithTitle:@"Hello Alert" message:@"这是用一个方法弹出来的有两个按钮的窗口" ok:^(UIAlertAction * _Nonnull sender) {
        AXLogFormat(@"点击了OK按钮");
    }];

    
    
    
    // @xaoxuu: 自定义按钮的系统弹窗
    [UIAlertController ax_showAlertWithTitle:@"Hello Alert" message:@"这是用一个方法弹出来的完全自定义的系统弹窗" action:^(UIAlertController * _Nonnull alert) {
        // @xaoxuu: 添加取消按钮
        [alert ax_addCancelAction];
        
        // @xaoxuu: 破坏性按钮（标题为【Confirm】）
        [alert ax_addDestructiveActionWithTitle:nil handler:^(UIAlertAction * _Nonnull sender) {
            
        }];
        // @xaoxuu: 自定义标题的破坏性按钮
        [alert ax_addDestructiveActionWithTitle:@"删除2" handler:^(UIAlertAction * _Nonnull sender) {
            
        }];
        // @xaoxuu: 普通按钮（默认标题为【OK】）
        [alert ax_addDefaultActionWithTitle:nil handler:^(UIAlertAction * _Nonnull sender) {
            
        }];
        // @xaoxuu: 自定义标题的普通按钮
        [alert ax_addDefaultActionWithTitle:@"确定2" handler:^(UIAlertAction * _Nonnull sender) {
            
        }];
        
        
    }];
     */
    
    
//    // @xaoxuu: 自定义视图的系统弹窗
//    [UIAlertController ax_showAlertWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n\n\n" action:^(UIAlertController * _Nonnull alert) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8, 8, 270-16, 222.3-16)];
//        view.backgroundColor = [UIColor md_yellow];
//        view.layer.masksToBounds = YES;
//        view.layer.cornerRadius = 8;
//        
//        [UIActivityIndicatorView defaultIndicator].show(view);
//        
//        [alert.view addSubview:view];
//        
//    }];
    
//    NSString *content = [NSString ax_stringWithRandomCapitalizeStringWithLength:AXUIntegerRangeMake(3, 5)].appendReturn();
//    NSString *path = @"com.xaoxuu/1234".tmpPath.extension(@".txt");
//    path.saveStringByAppendingToEndOfFile(content);
    
    
    
}



- (CGRect)initContentFrame:(CGRect)frame{
    frame.origin.y = kTopBarHeight;
    frame.size.height = kScreenH - kTopBarHeight - kTabBarHeight;
    return frame;
}



@end

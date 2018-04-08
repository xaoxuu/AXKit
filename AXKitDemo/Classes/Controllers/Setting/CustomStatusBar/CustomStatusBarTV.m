//
//  CustomStatusBarTV.m
//  AXKitDemo
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CustomStatusBarTV.h"
#import "MJExtension.h"
#import "StatusKit.h"


static NSTimer *timer;

@implementation CustomStatusBarTV

- (void)dealloc{
    [timer ax_pause];
    timer = nil;
}


- (void)ax_tableView:(AXTableViewType *)tableView didSetModelForCell:(AXTableViewCellType *)cell atIndexPath:(NSIndexPath *)indexPath{
    if ([cell.model.target containsString:@"#"]) {
        UIColor *color = [UIColor colorWithHexString:cell.model.target];
        CGSize size = CGSizeMake(8, cell.size.height - 2);
        cell.imageView.image = [UIImage imageWithColor:color size:size];
    }
}


- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModelType *)model{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    static UIView *customStatusBar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        customStatusBar = [AXStatusBar getCustomStatusBar];
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        // @xaoxuu: in main queue
        
        if (section == 0) {
            if (row == 0) {
                [customStatusBar removeAllSubviews];
                customStatusBar.hidden = YES;
                customStatusBar.backgroundColor = [UIColor clearColor];
                [customStatusBar ax_layer:^(CALayer * _Nonnull layer) {
                    layer.shadowOpacity = 0;
                    layer.shadowRadius = 0;
                    layer.shadowOffset = CGSizeZero;
                    [layer removeAllAnimations];
                }];
            }
        } else if (section == 1) {
            customStatusBar.hidden = NO;
            customStatusBar.alpha = 1;
            customStatusBar.backgroundColor = axThemeManager.color.theme;
            if (row == 0) {
                [customStatusBar.layer ax_removeColorAnimation];
            } else if (row == 1) {
                [customStatusBar.layer ax_animatedColor:axThemeManager.color.theme.dark duration:1 repeatCount:HUGE_VALF];
            } else if (row == 2) {
                [customStatusBar.layer ax_animatedColor:UIColor.md_red duration:1 repeatCount:HUGE_VALF];
            } else if (row == 3) {
                [customStatusBar.layer ax_animatedColor:UIColor.md_yellow duration:1.5 repeatCount:HUGE_VALF];
            } else if (row == 4) {
                [customStatusBar.layer ax_animatedColor:UIColor.md_blue duration:2 repeatCount:HUGE_VALF];
                
            }
            
        } else if (section == 2) {
            customStatusBar.hidden = NO;
            customStatusBar.alpha = 1;
            if (row == 0) {
                [customStatusBar ax_layer:^(CALayer * _Nonnull layer) {
                    layer.shadowOpacity = 0;
                    layer.shadowRadius = 0;
                    layer.shadowOffset = CGSizeZero;
                }];
            } else if (row == 1) {
                [customStatusBar ax_layer:^(CALayer * _Nonnull layer) {
                    [layer ax_shadow:LayerShadowDownLight];
                }];
            } else if (row == 2) {
                [customStatusBar ax_layer:^(CALayer * _Nonnull layer) {
                    [layer ax_shadow:LayerShadowDownNormal];
                }];
            } else if (row == 3) {
                [customStatusBar ax_layer:^(CALayer * _Nonnull layer) {
                    [layer ax_shadow:LayerShadowDownFloat];
                }];
            }
        } else if (section == 3) {
            customStatusBar.hidden = NO;
            customStatusBar.alpha = 1;
            if (row == 0) {
                customStatusBar.backgroundColor = UIColor.clearColor;
            } else {
                customStatusBar.backgroundColor = [UIColor colorWithHexString:model.target];
            }
        } else if (section == 4) {
            // @xaoxuu: 状态栏消息
            if (row == 0) {
                [AXStatusBar hideStatusBarMessage];
            } else if (row == 1) {
                [AXStatusBar showStatusBarMessage:@"警告：这是一条警告消息" textColor:nil backgroundColor:[UIColor md_yellow] duration:3];
            } else if (row == 2) {
                [AXStatusBar showStatusBarMessage:@"错误：这是一条错误提示" textColor:[UIColor whiteColor] backgroundColor:[UIColor md_red] duration:5];
            } else if (row == 3) {
                [AXStatusBar showStatusBarMessage:@"错误：这是一条错误提示，错误原因：klajqkewnflkwefnflkwsdfefnek。" textColor:[UIColor whiteColor] backgroundColor:[UIColor md_red] duration:8];
            } else if (row == 4) {
                [AXStatusBar showStatusBarMessage:@"错误：这是一条错误提示，错误原因：klajqkewnflkwefneklnfkewlnqkwefefnekkewfkeewfkewf。" textColor:[UIColor whiteColor] backgroundColor:[UIColor md_red] duration:15];
            }
            
        } else if (section == 5) {
            // @xaoxuu: 状态栏进度
            if ([model.title isEqualToString:@"隐藏消息"]) {
                [timer ax_pause];
                [AXStatusBar hideStatusBarProgressMessage];
            } else if ([model.title isEqualToString:@"自动"]) {
                __block CGFloat x = 0;
                [timer ax_pause];
                timer = nil;
                timer = [NSTimer ax_scheduledTimerWithTimeInterval:0.01 repeats:YES usingBlock:^(NSTimer * _Nonnull timer) {
                    [AXStatusBar showStatusBarProgress:x textColor:[UIColor blackColor] backgroundColor:axThemeManager.color.theme.light duration:2];
                    x += 0.002;
                    if (x >= 1) {
                        [timer ax_pause];
                    }
                }];
                [timer ax_restart];
            } else {
                NSString *tmp = [model.title substringToIndex:model.title.length-1];
                CGFloat value = tmp.doubleValue / 100;
                [AXStatusBar showStatusBarProgress:value textColor:[UIColor blackColor] backgroundColor:axThemeManager.color.theme.light duration:3];
            }
            
        }
        
    });
    
}



@end

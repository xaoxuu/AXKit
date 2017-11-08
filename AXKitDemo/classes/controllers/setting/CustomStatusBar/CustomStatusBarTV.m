//
//  CustomStatusBarTV.m
//  AXKitDemo
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CustomStatusBarTV.h"
#import "MJExtension.h"



@implementation CustomStatusBarTV



- (void)initTableView:(BaseTableView *)tableView{
    tableView.estimatedSectionFooterHeight = 0;
    tableView.sectionFooterHeight = 0;
    
}

- (void)setupTableViewDataSource:(void (^)(NSMutableArray<BaseTableModelSection *> *))completion{
    if (completion) {
        NSDictionary *jsonFile = @"CustomStatusBarTV.json".mainBundlePath.readJson();
        NSArray *sections = jsonFile[@"sections"];
        NSMutableArray<BaseTableModelSection *> *customStatusBarList = [ThemeColorModelSection mj_objectArrayWithKeyValuesArray:sections];
        
        completion(customStatusBarList);
    }
}

- (void)indexPath:(NSIndexPath *)indexPath didSelected:(__kindof BaseTableModelRow *)model{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    static UIView *customStatusBar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        customStatusBar = [UIApplication ax_getCustomStatusBar];
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
            customStatusBar.backgroundColor = axColor.theme;
//            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//            animation.duration = 1;
//            animation.autoreverses = YES;
//            animation.removedOnCompletion = YES;
//            animation.repeatCount = HUGE_VALF;
            if (row == 0) {
//                [customStatusBar ax_layer:^(CALayer * _Nonnull layer) {
//                    [layer removeAllAnimations];
//                }];
                [customStatusBar.layer ax_hideColorAnimation];
            } else if (row == 1) {
                [customStatusBar.layer ax_showAnimatedColor:axColor.theme.dark duration:1 repeatCount:HUGE_VALF];
            } else if (row == 2) {
                [customStatusBar.layer ax_showAnimatedColor:UIColor.md_red duration:1 repeatCount:HUGE_VALF];
            } else if (row == 3) {
                [customStatusBar.layer ax_showAnimatedColor:UIColor.md_yellow duration:1.5 repeatCount:HUGE_VALF];
            } else if (row == 4) {
                [customStatusBar.layer ax_showAnimatedColor:UIColor.md_blue duration:2 repeatCount:HUGE_VALF];
                
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
                customStatusBar.backgroundColor = axColor.clear;
            } else {
                ThemeColorModelRow *tmp = (ThemeColorModelRow *)model;
                customStatusBar.backgroundColor = [UIColor colorWithHexString:tmp.hex];
            }
        } else if (section == 4) {
            // @xaoxuu: 状态栏通知
            if (row == 0) {
                [UIApplication ax_hideStatusBarMessage];
            } else if (row == 1) {
                [UIApplication ax_showStatusBarMessage:@"警告：这是一条警告消息" textColor:nil backgroundColor:[UIColor md_yellow] duration:3];
            } else if (row == 2) {
                [UIApplication ax_showStatusBarMessage:@"错误：这是一条错误提示" textColor:[UIColor whiteColor] backgroundColor:[UIColor md_red] duration:5];
            } else if (row == 3) {
                [UIApplication ax_showStatusBarMessage:@"错误：这是一条错误提示，错误原因：klajqkewnflkwefnflkwsdfefnek。" textColor:[UIColor whiteColor] backgroundColor:[UIColor md_red] duration:8];
            } else if (row == 4) {
                [UIApplication ax_showStatusBarMessage:@"错误：这是一条错误提示，错误原因：klajqkewnflkwefneklnfkewlnqkwefefnekkewfkeewfkewf。" textColor:[UIColor whiteColor] backgroundColor:[UIColor md_red] duration:15];
            }
            
        }
        
    });
    
    
    
}



- (void)indexPath:(NSIndexPath *)indexPath icon:(void (^)(UIImage *))icon{
    if (indexPath.section == 3 && indexPath.row != 0) {
        ThemeColorModelRow *color = (ThemeColorModelRow *)[self rowModel:indexPath];
        icon([UIImage imageWithColor:[UIColor colorWithHexString:color.hex]]);
    }
    
}

@end

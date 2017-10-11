//
//  CustomStatusBarTV.m
//  AXKitDemo
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CustomStatusBarTV.h"
#import "MJExtension.h"

static UIView *customView;

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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // @xaoxuu: in main queue
        UIView *statusBar = [UIApplication ax_getStatusBar];
        if (!customView) {
            customView = UIViewWithHeight(kStatusBarHeight);
        }
//        if (section != 2) {
//            [statusBar insertSubview:customView atIndex:0];
//            [customView removeFromSuperview];
//            customView = nil;
//        }
        
        if (section == 0) {
            if (row == 0) {
                
                [statusBar ax_layer:^(CALayer * _Nonnull layer) {
                    layer.shadowOpacity = 0;
                    layer.shadowRadius = 0;
                    layer.shadowOffset = CGSizeZero;
                }];
            }
        } else if (section == 1) {
            if (row == 0) {
                statusBar.alpha = 1;
                [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
                    statusBar.alpha = 0;
                } completion:^(BOOL finished) {
                    statusBar.alpha = 1;
                }];
            } else if (row == 1) {
                [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
                    statusBar.backgroundColor = [UIColor md_red];
                } completion:^(BOOL finished) {
                    statusBar.backgroundColor = axColor.theme;
                }];
            } else if (row == 2) {
                [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
                    statusBar.backgroundColor = [UIColor md_yellow];
                } completion:^(BOOL finished) {
                    statusBar.backgroundColor = axColor.theme;
                }];
            } else if (row == 3) {
                [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
                    statusBar.backgroundColor = [UIColor md_blue];
                } completion:^(BOOL finished) {
                    statusBar.backgroundColor = axColor.theme;
                }];
            }
        } else if (section == 2) {
            if (row == 0) {
                [statusBar ax_layer:^(CALayer * _Nonnull layer) {
                    layer.shadowOpacity = 0;
                    layer.shadowRadius = 0;
                    layer.shadowOffset = CGSizeZero;
                }];
            } else if (row == 1) {
                [statusBar ax_layer:^(CALayer * _Nonnull layer) {
                    [layer ax_shadow:LayerShadowDownLight];
                }];
            } else if (row == 2) {
                [statusBar ax_layer:^(CALayer * _Nonnull layer) {
                    [layer ax_shadow:LayerShadowDownNormal];
                }];
            } else if (row == 3) {
                [statusBar ax_layer:^(CALayer * _Nonnull layer) {
                    [layer ax_shadow:LayerShadowDownFloat];
                }];
            }
        } else if (section == 3) {
            if (row == 0) {
                statusBar.backgroundColor = axColor.theme;
            } else {
                ThemeColorModelRow *tmp = (ThemeColorModelRow *)model;
                statusBar.backgroundColor = [UIColor colorWithHexString:tmp.hex];
            }
        }
    });
    
    
    
}


@end

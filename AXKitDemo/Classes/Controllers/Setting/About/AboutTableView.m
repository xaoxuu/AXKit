//
//  AboutTableView.m
//  AXKit
//
//  Created by xaoxuu on 20/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AboutTableView.h"
#import "NormalLabel.h"
#import "BaseWebVC.h"
#import "BlogVC.h"
#import <SDWebImage/UIImage+GIF.h>
#import "AXFeedbackKit.h"

static UIImage *cachedImage;

#define CACHE_VERSION @"CACHE_VERSION"


static CGFloat const iconSize = 60;
static id<NSObject> observer;
@interface AboutTableView ()



@end

@implementation AboutTableView



- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width * 3 / 4)];
    
    // @xaoxuu: icon
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconSize, iconSize)];
    icon.image = UIImage.named(NSBundle.appIconName);
    icon.contentMode = UIViewContentModeScaleAspectFit;
    if (@available(iOS 10.3, *)) {
        if ([[UIApplication sharedApplication] supportsAlternateIcons]) {
            NSString *iconName = [[UIApplication sharedApplication] alternateIconName];
            if (iconName.length) {
                icon.image = UIImage.named(iconName);
            }
            [icon ax_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
                [UIAlertController ax_showAlertWithTitle:@"更改AppIcon" message:@"只支持iOS10.3及其以后的版本。" actions:^(UIAlertController * _Nonnull alert) {
                    [alert ax_addDefaultActionWithTitle:@"Icon-60" handler:^(UIAlertAction * _Nonnull sender) {
                        icon.image = UIImage.named(sender.title);
                        [[UIApplication sharedApplication] setAlternateIconName:sender.title completionHandler:^(NSError * _Nullable error) {
                            AXCachedLogError(error);
                        }];
                    }];
                    [alert ax_addDefaultActionWithTitle:@"Icon-61" handler:^(UIAlertAction * _Nonnull sender) {
                        icon.image = UIImage.named(sender.title);
                        [[UIApplication sharedApplication] setAlternateIconName:sender.title completionHandler:^(NSError * _Nullable error) {
                            AXCachedLogError(error);
                        }];
                    }];
                    [alert ax_addDefaultActionWithTitle:@"Icon-62" handler:^(UIAlertAction * _Nonnull sender) {
                        icon.image = UIImage.named(sender.title);
                        [[UIApplication sharedApplication] setAlternateIconName:sender.title completionHandler:^(NSError * _Nullable error) {
                            AXCachedLogError(error);
                        }];
                    }];
                    [alert ax_addDefaultActionWithTitle:@"Icon-63" handler:^(UIAlertAction * _Nonnull sender) {
                        icon.image = UIImage.named(sender.title);
                        [[UIApplication sharedApplication] setAlternateIconName:sender.title completionHandler:^(NSError * _Nullable error) {
                            AXCachedLogError(error);
                        }];
                    }];
                    [alert ax_addCancelAction];
                }];
            }];
        } else {
            AXLogOBJ(@"buzhichi");
        }
    }
    
    
    // @xaoxuu: layer
    icon.backgroundColor = [UIColor whiteColor];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = icon.width/4.2;
    // @xaoxuu: point
    icon.center = view.boundsCenter;
    [view addSubview:icon];
    // @xaoxuu: bg
    UIImageView *bg = [[UIImageView alloc] initWithFrame:view.bounds];
    bg.height -= 8;
    bg.top += 8;
    if (@available(iOS 11.0, *)) {
        // on newer versions
        
    } else {
        // Fallback on earlier versions
        bg.height -= 20;
        bg.top += 20;
    }
    bg.contentMode = UIViewContentModeScaleAspectFill;
    bg.clipsToBounds = YES;
    [view insertSubview:bg atIndex:0];
    if (cachedImage) {
        bg.image = cachedImage;
    } else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"header" ofType:@"gif"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            cachedImage = [UIImage sd_animatedGIFWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                bg.image = cachedImage;
            });
        });
    }
    
    // @xaoxuu: app name
    NormalLabel *appName = [NormalLabel labelWithTitle:NSBundle.appDisplayName fontSize:17];
    appName.width = view.width;
    appName.centerX = 0.5 * view.width;
    appName.top = icon.bottom + 8;
    appName.textColor = [UIColor whiteColor];
    [view addSubview:appName];
    
    tableView.tableHeaderView = view;
    tableView.estimatedSectionHeaderHeight = 20;
    tableView.estimatedSectionFooterHeight = 0;
//    tableView.tableFooterView = services.app.copyrightTableFooter;
    
    
    NormalLabel *copyright = [NormalLabel labelWithTitle:@"Copyright © 2013-2017 Titan Studio" fontSize:11];
    copyright.height = 50;
    copyright.textAlignment = NSTextAlignmentCenter;
    copyright.textColor = [UIColor colorWithWhite:0 alpha:0.5];
//    if (axThemeManager.color.theme.isLightColor) {
//        copyright.textColor = [UIColor darkTextColor];
//    } else {
//        copyright.textColor = [UIColor lightTextColor];
//    }
    tableView.tableFooterView = copyright;
    
    __weak typeof(self) weakSelf = self;
    observer = [[NSNotificationCenter defaultCenter] addObserverForName:ThemeKitNotificationFontChanged object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf reloadData];
        appName.font = [UIFont fontWithName:axThemeManager.font.name size:17];
        copyright.font = [UIFont fontWithName:axThemeManager.font.name size:11];
    }];
    
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}

- (void)ax_tableView:(AXTableViewType *)tableView willSetModel:(AXTableRowModelType *)model forRowAtIndexPath:(NSIndexPath *)indexPath{
    AXTableRowModel *tmp = (AXTableRowModel *)model;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            tmp.detail = NSBundle.appVersion;
        } else if (indexPath.row == 1) {
            NSString *buildTime = @"2018".append(NSBundle.appBuildVersion);
            NSDate *date = [NSDate dateWithString:buildTime format:@"yyyyMdd1"];
            tmp.detail = [date stringWithFormat:@"yyyy-MM-dd"];
        }
    }
}

- (void)ax_tableView:(AXTableViewType *)tableView didSetModelForCell:(AXTableViewCellType *)cell atIndexPath:(NSIndexPath *)indexPath{
    [super ax_tableView:tableView didSetModelForCell:cell atIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.85];
}

- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModelType *)model{
    if (model.target.length) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_DRAWER_CLOSE object:nil];
    }
    if (model.target.isURLString) {
        [UIApplication ax_presentSafariViewControllerWithURL:[NSURL URLWithString:model.target] fromViewController:self.controller];
    } else if ([model.target containsString:@"mailto:"]) {
        [[EmailManager sharedInstance] sendEmail:^(MFMailComposeViewController * _Nonnull mailCompose) {
            [mailCompose setToRecipients:@[model.detail]];
        } completion:^(MFMailComposeResult result) {
            
        } fail:^(NSError * _Nonnull error) {
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

@end

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


#define CACHE_VERSION @"CACHE_VERSION"


static CGFloat const iconSize = 64;
@interface AboutTableView () <AppServicesDelegate>



@end

@implementation AboutTableView

- (void)dealloc{
    [services.app unRegisterDelegate:self];
}

- (void)initTableView:(BaseTableView *)tableView{
    [services.app registerDelegate:self];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.3*kScreenH)];
    
    // @xaoxuu: bg
//    NSData *bgImgData = [NSData dataWithContentsOfFile:@"header.gif".mainBundlePath];
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:view.bounds];
//    webView.scalesPageToFit = YES;
//    [webView loadData:bgImgData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    webView.backgroundColor = [UIColor clearColor];
//    webView.opaque = NO;
//    webView.scrollView.scrollEnabled = NO;
//    [view addSubview:webView];
    
    // @xaoxuu: icon
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconSize, iconSize)];
    icon.image = [NSBundle ax_appIcon];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    // @xaoxuu: layer
    icon.backgroundColor = [UIColor whiteColor];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = icon.width/4.2;
    // @xaoxuu: point
    icon.center = view.boundsCenter;
    [view addSubview:icon];
    
    // @xaoxuu: app name
    NormalLabel *appName = [NormalLabel labelWithTitle:[NSBundle ax_appName] fontSize:12];
    appName.centerX = 0.5 * view.width;
    appName.top = icon.bottom + 8;
    [view addSubview:appName];
    
    // @xaoxuu: app version
//    NormalLabel *appVersion = [NormalLabel labelWithTitle:[NSBundle ax_appVersion] fontSize:12];
//    appVersion.centerX = 0.5 * view.width;
//    appVersion.top = appName.bottom + 4;
//    [view addSubview:appVersion];
    
    
    // @xaoxuu: header
    tableView.tableHeaderView = view;
    tableView.tableFooterView = services.app.copyrightTableFooter;
}


- (void)indexPath:(NSIndexPath *)indexPath willSetModel:(BaseTableModelRow *)model{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            model.desc = [NSUserDefaults ax_readStringForKey:CACHE_VERSION];
            VersionLaterThanVersion([NSBundle ax_appVersion], services.app.remoteVersion.name, ^(BOOL later) {
                if (later) {
                    model.desc = [NSString stringWithFormat:@"%@ beta (%@)", [NSBundle ax_appVersion], [NSBundle ax_appBuild]];
                } else {
                    model.desc = [NSString stringWithFormat:@"%@ (%@)", [NSBundle ax_appVersion], [NSBundle ax_appBuild]];
                }
                [NSUserDefaults ax_setString:model.desc forKey:CACHE_VERSION];
            }, nil);
            AXLogOBJ(model.desc);
        } else if (indexPath.row == 1) {
            NSString *buildTime = @"20".append([NSBundle ax_appBuild]);
            NSDate *date = [NSDate dateWithString:buildTime format:@"yyyyMMddHHmm"];
            model.desc = [date stringWithFormat:@"yyyy-MM-dd HH:mm EEEE"];
        }
    }
}



- (BOOL)indexPath:(NSIndexPath *)indexPath shouldPush:(__kindof BaseViewController *)targetVC{
    BaseTableModelRow *model = [self rowModel:indexPath];
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        if ([targetVC isKindOfClass:[BaseWebVC class]]) {
            BaseWebVC *vc = targetVC;
            vc.urlStr = model.cmd;
        }
        
    }
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self sectionModel:section].footer_height.floatValue;
}



- (void)didDiscoverRemoteVersion:(AppVersionInfoModel *)version{
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

@end

//
//  AboutTableView.m
//  AXKit
//
//  Created by xaoxuu on 20/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AboutTableView.h"
#import "NormalLabel.h"

static CGFloat const iconSize = 64;


@implementation AboutTableView


- (void)setupTableView:(BaseTableView *)tableView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.3*kScreenH)];
    // @xaoxuu: icon
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconSize, iconSize)];
    icon.image = [UIImage imageNamed:[NSBundle ax_appIcon]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    // @xaoxuu: layer
    icon.backgroundColor = [UIColor whiteColor];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = icon.width/5.8;
    // @xaoxuu: point
    icon.centerX = 0.5 * view.width;
    icon.centerY = 0.4 * view.height;
    [view addSubview:icon];
    
    // @xaoxuu: app name
    NormalLabel *appName = [NormalLabel labelWithTitle:[NSBundle ax_appName] fontSize:12];
    appName.centerX = 0.5 * view.width;
    appName.top = icon.bottom + 8;
    [view addSubview:appName];
    
    // @xaoxuu: app version
    NormalLabel *appVersion = [NormalLabel labelWithTitle:@"v ".append([NSBundle ax_appVersion]) fontSize:12];
    appVersion.centerX = 0.5 * view.width;
    appVersion.top = appName.bottom + 4;
    [view addSubview:appVersion];
    
    // @xaoxuu: header
    tableView.tableHeaderView = view;
    tableView.tableFooterView = nil;
}

- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row{
    if (section == 0 && row == 0) {
        return [NSBundle ax_appBuild];
    }
    return nil;
}


- (BOOL)tableViewCellShouldPushToViewController:(__kindof BaseViewController *)targetVC withModel:(__kindof BaseTableModelRow *)model section:(NSUInteger)section row:(NSUInteger)row{
    NSString *urlStr = model.cmd;
    if (urlStr.length) {
        [[UIApplication sharedApplication] openURL:urlStr.absoluteURL options:@{} completionHandler:^(BOOL success) {
            
        }];
    }
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.dataList[section].footer_height.floatValue;
}

@end

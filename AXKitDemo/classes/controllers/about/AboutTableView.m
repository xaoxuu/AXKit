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


- (void)initTableView:(BaseTableView *)tableView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.3*kScreenH)];
    // @xaoxuu: icon
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconSize, iconSize)];
    icon.image = [UIImage imageNamed:[NSBundle ax_appIcon]];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    // @xaoxuu: layer
    icon.backgroundColor = [UIColor whiteColor];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = icon.width/4.2;
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
- (void)indexPath:(NSIndexPath *)indexPath willSetModel:(BaseTableModelRow *)model{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            model.desc = [NSBundle ax_appBuild];
        } else if (indexPath.row == 1) {
            NSString *buildTime = @"20".append([NSBundle ax_appBuild]);
            NSDate *date = [NSDate dateWithString:buildTime format:@"yyyyMMddHHmm"];
            model.desc = [date stringWithFormat:@"yyyy-MM-dd HH:mm EEEE"];
        }
    }
}


- (void)indexPath:(NSIndexPath *)indexPath didSelected:(__kindof BaseTableModelRow *)model{
    NSString *urlStr = model.cmd;
    if (urlStr.length) {
        [[UIApplication sharedApplication] openURL:urlStr.absoluteURL options:@{} completionHandler:^(BOOL success) {
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self sectionModel:section].footer_height.floatValue;
}

@end

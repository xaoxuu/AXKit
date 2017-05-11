//
//  SettingTableView.m
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "SettingTableView.h"
#import "CustomTableVC.h"
#import "FeedbackVC.h"
@implementation SettingTableView


- (BOOL)tableViewCellShouldPushToViewController:(__kindof UIViewController *)targetVC withModel:(__kindof BaseTableModelRow *)model{
    
    if ([targetVC isKindOfClass:[FeedbackVC class]]) {
        FeedbackVC *vc = targetVC;
        vc.urlStr = model.cmd;
    }
    
    if ([targetVC isKindOfClass:[CustomTableVC class]]) {
        CustomTableVC *vc = targetVC;
        vc.cmd = model.cmd;
    }
    return YES;
}


- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row{
    if (section == 3) {
        if (row == 0) {
            return services.cache.cacheBytes.append(@"bytes");
        }
    }
    return nil;
}

@end

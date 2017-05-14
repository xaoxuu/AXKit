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




- (void)setupTableView:(BaseTableView *)tableView{
    tableView.estimatedSectionFooterHeight = 0;
    tableView.sectionFooterHeight = 0;
    
    
    
}

- (void)setupTableViewDataSource:(void (^)(BaseTableModelListType))completion{
    if (completion) {
        completion(services.cache.settingList);
    }
}


- (BOOL)tableViewCellShouldPushToViewController:(__kindof UIViewController *)targetVC withModel:(__kindof BaseTableModelRow *)model section:(NSUInteger)section row:(NSUInteger)row{
    
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
            return services.cache.cachedFileSize;
        }
    }
    return nil;
}





@end

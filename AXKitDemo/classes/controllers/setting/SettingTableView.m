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




- (void)initTableView:(BaseTableView *)tableView{
    tableView.estimatedSectionFooterHeight = 0;
    tableView.sectionFooterHeight = 0;
    
}

- (void)setupTableViewDataSource:(void (^)(BaseTableModelListType))completion{
    if (completion) {
        completion(services.cache.settingList);
    }
}

- (void)indexPath:(NSIndexPath *)indexPath willPush:(__kindof BaseViewController *)targetVC {
    BaseTableModelRow *model = [self rowModel:indexPath];
    if ([targetVC isKindOfClass:[FeedbackVC class]]) {
        FeedbackVC *vc = targetVC;
        vc.urlStr = model.cmd;
    }
    
    if ([targetVC isKindOfClass:[CustomTableVC class]]) {
        CustomTableVC *vc = targetVC;
        vc.cmd = model.cmd;
    }
    
}


- (void)indexPath:(NSIndexPath *)indexPath willSetModel:(BaseTableModelRow *)model{
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            model.desc = services.cache.cachedFileSize;
        }
    }
}



@end

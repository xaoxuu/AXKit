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


- (AXTableModelType *)ax_tableViewPreloadDataSource{
    AXTableModelType *model = [self loadDataSourceFromPath:[service.cache cacheForClassWithName:NSStringFromClass(self.class)]];
    if (!model) {
        model = [self loadDataSourceFromBundle];
    }
    return model;
}


- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:ThemeKitNotificationFontChanged object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf reloadData];
    }];
    tableView.tableFooterView = UIViewWithHeight(44);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


//- (void)initTableView:(BaseTableView *)tableView{
//    tableView.estimatedSectionFooterHeight = 0;
//    tableView.sectionFooterHeight = 0;
//
//}

//- (void)setupTableViewDataSource:(void (^)(NSMutableArray<BaseTableModelSection *> *))completion{
//    if (completion) {
//        completion(services.cache.settingList);
//    }
//}
//
//- (void)indexPath:(NSIndexPath *)indexPath willPush:(__kindof BaseViewController *)targetVC {
//    BaseTableModelRow *model = [self rowModel:indexPath];
//    if ([targetVC isKindOfClass:[FeedbackVC class]]) {
//        FeedbackVC *vc = targetVC;
//        vc.urlStr = model.cmd;
//    }
//    
//    if ([targetVC isKindOfClass:[CustomTableVC class]]) {
//        CustomTableVC *vc = targetVC;
//        vc.cmd = model.cmd;
//    }
//    
//}


//- (void)indexPath:(NSIndexPath *)indexPath cell:(UITableViewCell<BaseTableViewCell> *)cell willSetModel:(BaseTableModelRow *)model{
//    if (indexPath.section == 3) {
//        if (indexPath.row == 0) {
//            model.desc = services.cache.cachedFileSize;
//        }
//    }
//}



@end

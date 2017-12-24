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
#import "BlogVC.h"

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

- (void)ax_tableViewWillPushToViewController:(UIViewController *)viewController fromRowAtIndexPath:(NSIndexPath *)indexPath{
    AXTableRowModelType *model = [self tableViewRowModelForIndexPath:indexPath];
    if ([viewController isKindOfClass:[BlogVC class]]) {
        BlogVC *vc = (BlogVC *)viewController;
        vc.urlStr = model.detail;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}



@end

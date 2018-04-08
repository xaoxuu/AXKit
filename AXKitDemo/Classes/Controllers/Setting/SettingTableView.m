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
#import <UIImageView+WebCache.h>
@interface SettingTableView () <AXTableViewCellDelegate>


@end

@implementation SettingTableView


- (AXTableModelType *)ax_tableViewPreloadDataSource{
    AXTableModelType *model = [self loadDataSourceFromPath:[service.cache cacheForClassWithName:NSStringFromClass(self.class)]];
    if (!model) {
        model = [self loadDataSourceFromBundle];
    }
    return model;
}


- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:ThemeKitNotificationFontChanged object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf reloadData];
    }];
    tableView.tableFooterView = UIViewWithHeight(44);
}

- (void)ax_tableView:(AXTableViewType *)tableView willPushViewController:(UIViewController *)viewController fromRowAtIndexPath:(NSIndexPath *)indexPath{
    AXTableRowModelType *model = [self modelForRowAtIndexPath:indexPath];
    if ([viewController isKindOfClass:[BlogVC class]]) {
        BlogVC *vc = (BlogVC *)viewController;
        vc.urlStr = model.cmd;
    }
}


- (void)ax_tableViewCell:(AXTableViewCell *)cell needsLoadWebImageFromPath:(NSString *)path forImageView:(UIImageView *)imageView{
    imageView.imageURL = [NSURL URLWithString:path];
}

- (void)ax_tableView:(AXTableViewType *)tableView didSetModelForCell:(AXTableViewCellType *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.delegate = self;
}


@end

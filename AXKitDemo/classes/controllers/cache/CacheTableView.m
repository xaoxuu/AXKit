//
//  CacheTableView.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CacheTableView.h"

@implementation CacheTableView


- (BaseTableModelListType)dataListForTableView:(UITableView *)tableView{
    return services.cache.cacheList;
}

- (BOOL)tableViewCellShouldPushToViewController:(__kindof BaseViewController *)targetVC withModel:(__kindof BaseTableModelRow *)model section:(NSUInteger)section row:(NSUInteger)row{
    [services.alert alertForConfirmWithMessage:^NSString *{
        return [NSString stringWithFormat:@"删除缓存文件\"%@\"",model.title];
    } completion:^{
        [services.cache removeObjWithKey:model.title completion:^{
            [self reloadDataSourceAndRefreshTableView];
        }];
    }];
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView reloadData];
    }
}

@end

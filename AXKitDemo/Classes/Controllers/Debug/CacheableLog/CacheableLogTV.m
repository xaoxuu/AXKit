//
//  CacheableLogTV.m
//  AXKitDemo
//
//  Created by xaoxuu on 2018/4/20.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "CacheableLogTV.h"
#import "ContentViewerVC.h"

@implementation CacheableLogTV

- (void)ax_tableViewDidLoadFinished:(AXTableViewType *)tableView{
    
}

- (void)ax_tableView:(AXTableViewType *)tableView dataSource:(void (^)(AXTableModelType * _Nonnull))dataSource{
    NSArray<NSString *> *allPaths = [AXCachedLog getAllCachedLogPath];
    AXTableModel *model = [[AXTableModel alloc] init];
    [model addSection:^(AXTableSectionModel *section) {
        [allPaths enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [section addRow:^(AXTableRowModel *row) {
                row.title = obj.lastPathComponent;
                row.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                row.cmd = obj;
            }];
        }];
    }];
    dataSource(model);
}


- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModelType *)model{
    ContentViewerVC *vc = [[ContentViewerVC alloc] init];
    vc.content = model.cmd.readString();
    vc.title = model.title.stringByDeletingPathExtension;
    [vc requestUpdate:^NSString *{
        return model.cmd.readString();
    }];
    [self.controller.navigationController pushViewController:vc animated:YES];
}


@end

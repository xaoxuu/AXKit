//
//  FontTableView.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FontTableView.h"
#import "FontTableViewCell.h"

@implementation FontTableView

- (AXTableModelType *)ax_tableViewPreloadDataSource{
    AXTableModel *model = [[AXTableModel alloc] init];
    [model addSection:^(AXTableSectionModel *section) {
        section.headerTitle = @"字号";
        section.rowHeight = 200;
        [section addRow:^(AXTableRowModel *row) {
            
        }];
    }];
    return model;
}


//- (UITableViewCell<BaseTableViewCell> *)setupCustomTableViewCell{
//    return [FontTableViewCell new];
//}
//
//- (void)indexPath:(NSIndexPath *)indexPath cell:(UITableViewCell<BaseTableViewCell> *)cell willSetModel:(BaseTableModelRow *)model{
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FontTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FontTableViewCell" forIndexPath:indexPath];
    
    return cell;
}


@end

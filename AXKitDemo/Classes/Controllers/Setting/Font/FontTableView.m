//
//  FontTableView.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FontTableView.h"
#import "FontSizeTableViewCell.h"
#import "FontTableViewCell.h"
static NSString *fontCell = @"FontTableViewCell";
static NSString *fontSizeCell = @"FontSizeTableViewCell";

@implementation FontTableView

- (AXTableModelType *)ax_tableViewPreloadDataSource{
    AXTableModel *model = [[AXTableModel alloc] init];
    [model addSection:^(AXTableSectionModel *section) {
        section.headerTitle = @"字体";
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"默认";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Arial";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Avenir";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Chalkboard SE";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Chalkduster";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Cochin";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Copperplate";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Gill Sans";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Helvetica";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Menlo";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"PingFang SC";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Trebuchet MS";
        }];
        [section addRow:^(AXTableRowModel *row) {
            row.title = @"Zapfino";
        }];
    }];
    [model addSection:^(AXTableSectionModel *section) {
        section.headerTitle = @"字号";
        [section addRow:^(AXTableRowModel *row) {
            row.rowHeight = 400;
        }];
    }];
    
    return model;
}

- (AXTableViewCellType *)ax_tableViewRegisterReuseableCell{
    return [[FontTableViewCell alloc] init];
}

- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
    [tableView registerNib:[UINib nibWithNibName:fontSizeCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:fontSizeCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        FontSizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fontSizeCell forIndexPath:indexPath];
        [cell updateUI];
        return cell;
    } else {
        AXTableViewCellType *cell = (AXTableViewCellType *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
        if ([cell.model.title isEqualToString:axThemeManager.font.name]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        return cell;
    }
    
}

- (void)ax_tableViewDidSelectedRowAtIndexPath:(NSIndexPath *)indexPath{
    AXTableRowModelType *model = [self tableViewRowModelForIndexPath:indexPath];
    if (model.title.length) {
        [axThemeManager updateCurrentFontTheme:^(UIThemeFontModel *font) {
            font.name = model.title;
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self reloadData];
        });
    }
}

@end

//
//  ThemeColorTableView.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeColorTableView.h"
#import "SCLAlertView+AXWrapper.h"

@implementation ThemeColorTableView

- (void)ax_tableViewDidLoadFinished:(AXTableViewType *)tableView{
    tableView.tableFooterView = UIViewWithHeight(32);
}

- (void)ax_tableView:(AXTableViewType *)tableView didSetModelForCell:(AXTableViewCellType *)cell atIndexPath:(NSIndexPath *)indexPath{
    [super ax_tableView:tableView didSetModelForCell:cell atIndexPath:indexPath];
    if ([cell.model.target containsString:@"#"]) {
        UIColor *color = [UIColor colorWithHexString:cell.model.target];
        CGSize size = CGSizeMake(8, cell.size.height - 2);
        cell.imageView.image = [UIImage imageWithColor:color size:size];
    }
}


- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModelType *)model{
    [axThemeManager updateCurrentColorTheme:^(UIThemeColorModel *color) {
        color.theme = [UIColor colorWithHexString:model.target];
    }];
}




@end

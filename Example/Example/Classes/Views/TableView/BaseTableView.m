//
//  BaseTableView.m
//  AXKitDemo
//
//  Created by xaoxuu on 2018/6/6.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (void)ax_tableView:(AXTableViewType *)tableView didSetModelForCell:(AXTableViewCellType *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.font = axThemeManager.font.customNormal;
    cell.detailTextLabel.font = axThemeManager.font.customSmall;
}

@end

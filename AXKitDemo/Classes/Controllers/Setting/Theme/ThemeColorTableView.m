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

- (void)ax_tableView:(AXTableViewType *)tableView didSetModelForCell:(AXTableViewCellType *)cell atIndexPath:(NSIndexPath *)indexPath{
    if ([cell.model.target containsString:@"#"]) {
        UIColor *color = [UIColor colorWithHexString:cell.model.target];
        CGSize size = CGSizeMake(16, cell.size.height);
        cell.imageView.image = [UIImage imageWithColor:color size:size];
        [cell.imageView.layer ax_borderWidth:1 color:[UIColor whiteColor]];
    }
}


- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModelType *)model{
    [axThemeManager updateCurrentColorTheme:^(UIThemeColorModel *color) {
        color.theme = [UIColor colorWithHexString:model.target];
    }];
}

//- (void)setupTableViewDataSource:(void (^)(NSMutableArray<BaseTableModelSection *> *))completion{
//    if (completion) {
//        completion(services.json.colors);
//    }
//}
//
//
//- (void)indexPath:(NSIndexPath *)indexPath icon:(void (^)(UIImage *))icon{
//    BaseTableModelRow *model = [self rowModel:indexPath];
//    if ([model isKindOfClass:[ThemeColorModelRow class]]) {
//        ThemeColorModelRow *color = (ThemeColorModelRow *)model;
//        icon([UIImage imageWithColor:[UIColor colorWithHexString:color.hex]]);
//    }
//}
//
//- (void)indexPath:(NSIndexPath *)indexPath didSelected:(__kindof BaseTableModelRow *)model{
//    [services.app applyThemeWithColor:model completion:^{
//        [self.controller.navigationController popViewControllerAnimated:YES];
//    }];
//}
//
//
//- (void)indexPath:(NSIndexPath *)indexPath cell:(UITableViewCell<BaseTableViewCell> *)cell willSetModel:(BaseTableModelRow *)model{
//    ThemeColorModelRow *colorStr = services.json.colors[indexPath.section].rows[indexPath.row];
//    model.desc = [NSString stringWithFormat:@"%@",colorStr.hex];
//}




@end

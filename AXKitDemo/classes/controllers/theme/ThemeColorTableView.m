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


//- (BaseTableModelListType)dataListForTableView:(UITableView *)tableView{
//    return services.json.colors;
//}
- (void)setupTableViewDataSource:(void (^)(BaseTableModelListType))completion{
    if (completion) {
        completion(services.json.colors);
    }
}

- (UIImage *)tableViewCellIconForSection:(NSUInteger)section row:(NSUInteger)row{
    ThemeColorModelRow *model = services.json.colors[section].rows[row];
    return [UIImage imageWithColor:[UIColor colorWithHexString:model.hex]];
}

- (void)tableViewCellDidSelected:(__kindof BaseTableModelRow *)model{
    [services.app applyThemeWithColor:model completion:^{
        [self.controller.navigationController popViewControllerAnimated:YES];
    }];
}


- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row{
    ThemeColorModelRow *colorStr = services.json.colors[section].rows[row];
    return [NSString stringWithFormat:@"%@",colorStr.hex];
}


- (BOOL)tableViewCellShouldPushToViewController:(__kindof BaseViewController *)targetVC withModel:(__kindof BaseTableModelRow *)model section:(NSUInteger)section row:(NSUInteger)row{
    return NO;
}

@end

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
    AXTableModelType *model = [self loadDataSourceFromPath:[service.cache cacheForClassWithName:NSStringFromClass(self.class)]];
    if (!model) {
        model = [self loadDataSourceFromBundle];
    }
    return model;
}

- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
    [tableView registerNib:[UINib nibWithNibName:fontSizeCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:fontSizeCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        FontSizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fontSizeCell];
        if (!cell) {
            cell = [[FontSizeTableViewCell alloc] init];
        }
        [cell updateUI];
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
}

- (void)ax_tableView:(AXTableViewType *)tableView willSetModel:(AXTableRowModelType *)model forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([model.title isEqualToString:axThemeManager.font.name]) {
            model.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            model.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModelType *)model{
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

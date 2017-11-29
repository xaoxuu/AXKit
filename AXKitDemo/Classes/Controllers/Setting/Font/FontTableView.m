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

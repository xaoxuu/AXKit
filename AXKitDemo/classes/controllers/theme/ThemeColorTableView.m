//
//  ThemeColorTableView.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeColorTableView.h"

@implementation ThemeColorTableView


- (NSArray<BaseTableModelList *> *)dataListForTableView:(UITableView *)tableView{
    return services.json.colors;
}

- (UIImage *)tableViewCellIconForSection:(NSUInteger)section row:(NSUInteger)row{
    ThemeColorModel *model = services.json.colors[section].rows[row];
    return [UIImage imageWithColor:[UIColor colorWithHexString:model.hex]];
}

- (void)tableViewCellDidSelected:(__kindof BaseTableModel *)model{
    ThemeColorModel *color = model;
    axColor.theme = [UIColor colorWithHexString:color.hex];
}


- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row{
    ThemeColorModel *colorStr = services.json.colors[section].rows[row];
    UIColor *color = [UIColor colorWithHexString:colorStr.hex];
    CGFloat r = color.redValue;
    CGFloat g = color.greenValue;
    CGFloat b = color.blueValue;
    CGFloat x = r*g*b;
    CGFloat y = r+g+b;
    return [NSString stringWithFormat:@"x%.2f,y%.2f,%.2f,%.2f",x,y,x*y,x+y];
    
}

@end

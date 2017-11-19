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

- (void)setupTableViewDataSource:(void (^)(NSMutableArray<BaseTableModelSection *> *))dataSource{
    BaseTableModelSection *sec = [BaseTableModelSection new];
    sec.header_title = @"字号";
    sec.rowHeight = @"200";
    BaseTableModelRow *row = [BaseTableModelRow new];
    [sec.rows addObject:row];
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:sec];
    if (dataSource) {
        dataSource(arr);
    }
    
}

- (UITableViewCell<BaseTableViewCell> *)setupCustomTableViewCell{
    return [FontTableViewCell new];
}

- (void)indexPath:(NSIndexPath *)indexPath cell:(UITableViewCell<BaseTableViewCell> *)cell willSetModel:(BaseTableModelRow *)model{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FontTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FontTableViewCell" forIndexPath:indexPath];
    
    return cell;
}


@end

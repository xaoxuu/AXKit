//
//  BaseTableView.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseTableView.h"
#import "UITableView+Creator.h"
#import "MJExtension.h"
#import "BaseTableViewCell.h"

@interface BaseTableView () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

// @xaoxuu: table view
@property (strong, nonatomic) UITableView *tableView;

// @xaoxuu: list
@property (strong, nonatomic) NSArray<BaseTableModelList *> *dataList;

// @xaoxuu: table view cell name
@property (copy, nonatomic) NSString *cellNibName;
// @xaoxuu: row height
@property (assign, nonatomic) CGFloat rowHeight;


@end

@implementation BaseTableView


- (instancetype)initWithFrame:(CGRect)frame sourcePlistName:(NSString *)name{
    if (self = [self initWithFrame:frame]) {
        
        
        
    }
    return self;
}

- (NSString *)tableViewJsonDataSourceName{
    return @"setting";
}



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _cellNibName = @"BaseTableViewCell";
        [self setupTableView];
        self.rowHeight = 44;
    }
    return self;
}

- (void)setupTableView{
    self.tableView = [UITableView ax_tableViewWithView:self frame:self.bounds style:UITableViewStyleGrouped registerNibForCellReuseIdentifier:self.cellNibName];
    
    
    self.tableView.sectionHeaderHeight = kMarginNormal;
    self.tableView.sectionFooterHeight = kMarginNormal;
    
    
    [self setupTableViewHeader:viewWithHeight(kMargin16)];
    [self setupTableViewFooter:viewWithHeight(kMargin16)];
    
}

- (void)setRowHeight:(CGFloat)rowHeight{
    _rowHeight = rowHeight;
    self.tableView.rowHeight = rowHeight;
}

- (void)setupTableViewHeader:(UIView *)header{
    self.tableView.tableHeaderView = header;
}

- (void)setupTableViewFooter:(UIView *)footer{
    self.tableView.tableFooterView = footer;
}


- (NSArray<BaseTableModelList *> *)dataList{
    if (!_dataList) {
        _dataList = services.cache.settingList;
    }
    return _dataList;
}


- (void)reloadData{
    [self.tableView reloadData];
}

//- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row{
//    return nil;
//}

- (BOOL)tableViewCellSwitchOnForSection:(NSUInteger)section row:(NSUInteger)row{
    return NO;
}

- (void)tableViewCellSwitchStatusChanged:(BOOL)on forSection:(NSUInteger)section row:(NSUInteger)row{
    
}


#pragma mark - data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList[section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellNibName];
    BaseTableModel *model = self.dataList[indexPath.section].rows[indexPath.row];
//    model.desc = [self tableViewCellDetailForSection:indexPath.section row:indexPath.row];
    cell.model = model;
    
    [cell switchStatusChanged:^(BOOL on) {
        [self tableViewCellSwitchStatusChanged:on forSection:indexPath.section row:indexPath.row];
        
    }];
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.dataList[section].header_title;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return self.dataList[section].footer_title;
}

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataList[indexPath.section].rowHeight.floatValue;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.dataList[section].header_height.floatValue;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.dataList[section].footer_height.floatValue;
}


@end

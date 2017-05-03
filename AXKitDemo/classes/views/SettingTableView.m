//
//  SettingTableView.m
//  AXKit
//
//  Created by xaoxuu on 17/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "SettingTableView.h"
#import "SettingListModel.h"
#import "UITableView+Creator.h"
#import "SettingTableViewCell.h"
#import <MJExtension.h>



@interface SettingTableView () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>


// @xaoxuu: table view
@property (strong, nonatomic) UITableView *tableView;

// @xaoxuu: list
@property (strong, nonatomic) NSArray<NSArray<SettingListModel *> *> *list;



@property (copy, nonatomic) void (^switchStatusChanged)(NSIndexPath *indexPath, BOOL on);

@end

@implementation SettingTableView

- (instancetype)initWithFrame:(CGRect)frame sourcePlistName:(NSString *)name{
    if (self = [self initWithFrame:frame]) {
        _sourcePlistName = name;
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _cellNibName = @"SettingTableViewCell";
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


- (NSArray<NSArray<SettingListModel *> *> *)list{
    if (!_list.count) {
        _list = [SettingListModel mj_objectArrayWithKeyValuesArray:self.sourcePlistName.plist.mainBundlePath.readArray];
        if (!_list) {
            _list = [NSArray array];
        }
    }
    return _list;
}

- (void)switchStatusChanged:(void (^)(NSIndexPath *indexPath, BOOL on))changed{
    self.switchStatusChanged = changed;
}


- (void)reloadData{
    [self.tableView reloadData];
}

- (NSString *)ax_tableViewCellDetailForIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (BOOL)ax_tableViewCellSwitchOnForIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void)ax_tableViewCellSwitchStatusChanged:(BOOL)on forIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellNibName];
    SettingListModel *model = self.list[indexPath.section][indexPath.row];
    model.detail = [self ax_tableViewCellDetailForIndexPath:indexPath];
    cell.model = model;
    cell.sw.on = [self ax_tableViewCellSwitchOnForIndexPath:indexPath];
    [cell switchStatusChanged:^(BOOL on) {
        [self ax_tableViewCellSwitchStatusChanged:on forIndexPath:indexPath];
        if (self.switchStatusChanged) {
            self.switchStatusChanged(indexPath, on);
        }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

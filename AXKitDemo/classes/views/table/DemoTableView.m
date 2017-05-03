//
//  DemoTableView.m
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DemoTableView.h"
#import "UITableView+Creator.h"
#import "MJExtension.h"
#import "DemoTableModel.h"
#import "DemoTableViewCell.h"

@interface DemoTableView () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>



// @xaoxuu: table view
@property (strong, nonatomic) UITableView *tableView;

// @xaoxuu: list
@property (strong, nonatomic) NSArray<NSArray<DemoTableModel *> *> *list;



@property (copy, nonatomic) void (^switchStatusChanged)(NSIndexPath *indexPath, BOOL on);


@end

@implementation DemoTableView

- (instancetype)initWithFrame:(CGRect)frame sourcePlistName:(NSString *)name{
    if (self = [self initWithFrame:frame]) {
        _sourcePlistName = name;
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _cellNibName = @"DemoTableViewCell";
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


- (NSArray<NSArray<DemoTableModel *> *> *)list{
    if (!_list.count) {
        _list = [DemoTableModel mj_objectArrayWithKeyValuesArray:self.sourcePlistName.plist.mainBundlePath.readArray];
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


- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row{
    return nil;
}

- (BOOL)tableViewCellSwitchOnForSection:(NSUInteger)section row:(NSUInteger)row{
    return NO;
}

- (void)tableViewCellSwitchStatusChanged:(BOOL)on forSection:(NSUInteger)section row:(NSUInteger)row{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellNibName];
    DemoTableModel *model = self.list[indexPath.section][indexPath.row];
    model.detail = [self tableViewCellDetailForSection:indexPath.section row:indexPath.row];
    cell.model = model;
    cell.sw.on = [self tableViewCellSwitchOnForSection:indexPath.section row:indexPath.row];
    [cell switchStatusChanged:^(BOOL on) {
        [self tableViewCellSwitchStatusChanged:on forSection:indexPath.section row:indexPath.row];
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

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


- (NSString *)sourceJsonFileNameForTableView:(BaseTableView *)tableView{
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
    _dataList = [self dataListForTableView:self.tableView];
    return _dataList;
}


- (void)reloadData{
    [self.tableView reloadData];
}


#pragma mark - base table view delegate
- (NSArray<BaseTableModelList *> *)dataListForTableView:(UITableView *)tableView{
    return services.cache.settingList;
}

#pragma mark - data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList[section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellNibName];
    BaseTableModel *model = self.dataList[section].rows[row];
    cell.model = model;
    
    // @xaoxuu: 自定义icon
    if ([self respondsToSelector:@selector(tableViewCellIconForSection:row:)]) {
        UIImage *img = [self tableViewCellIconForSection:section row:row];
        cell.icon = img;
    }
    
    // @xaoxuu: 是否显示">"
    BOOL showAccessory = YES;
    if ([self respondsToSelector:@selector(tableViewCellShowAccessoryDisclosureIndicatorForSection:row:)]) {
        showAccessory = [self tableViewCellShowAccessoryDisclosureIndicatorForSection:section row:row];
    }
    cell.accessoryType = showAccessory ? UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    
    // @xaoxuu: 是否显示开关
    BOOL showSwitch = NO;
    if ([self respondsToSelector:@selector(tableViewCellShowSwitch:forSection:row:)]) {
        showSwitch = [self tableViewCellShowSwitch:cell.sw forSection:section row:row];
        [cell.sw ax_addValueChangedHandler:^(__kindof UISwitch * _Nonnull sender) {
            if ([self respondsToSelector:@selector(tableViewCellDidSwitchStatusChanged:forSection:row:)]) {
                [self tableViewCellDidSwitchStatusChanged:cell.sw forSection:section row:row];
            }
        }];
    }
    cell.accessoryView = showSwitch ? cell.sw : nil;
    
    
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
    BaseTableModel *model = self.dataList[indexPath.section].rows[indexPath.row];
    if (!model) {
        return;
    }
    UIViewController *vc = UIViewControllerFromString(model.target);
    if (vc) {
        vc.title = NSLocalizedString(model.title, nil);
        [self.controller.navigationController pushViewController:vc animated:YES];
    } else if (model.target.length) {
        UIViewController *vc = [DefaultViewController defaultVCWithTitle:NSLocalizedString(model.title, nil) detail:NSLocalizedString(model.desc, nil)];
        [self.controller.navigationController pushViewController:vc animated:YES];
    }
    if ([self respondsToSelector:@selector(tableViewCellDidSelected:)]) {
        [self tableViewCellDidSelected:model];
    }
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

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
#import "DefaultIndicatorView.h"



@interface BaseTableView () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>



// @xaoxuu: list
@property (strong, nonatomic) BaseTableModelListType dataList;

// @xaoxuu: table view cell name
@property (copy, nonatomic) NSString *cellNibName;
// @xaoxuu: row height
@property (assign, nonatomic) CGFloat rowHeight;

// @xaoxuu: indicator
@property (strong, nonatomic) DefaultIndicatorView *indicator;

@end

@implementation BaseTableView


- (instancetype)initWithFrame:(CGRect)frame sourcePlistName:(NSString *)name{
    if (self = [self initWithFrame:frame]) {
        
        
        
    }
    return self;
}




- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _cellNibName = @"BaseTableViewCell";
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.indicator = [DefaultIndicatorView defaultIndicatorAddToView:self];
        [self setupTableView];
        self.rowHeight = 44;
    }
    return self;
}

- (void)setupTableView{
    self.tableView = [UITableView ax_tableViewWithView:self frame:self.bounds style:UITableViewStyleGrouped registerNibForCellReuseIdentifier:self.cellNibName];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.sectionHeaderHeight = kMarginNormal;
    self.tableView.sectionFooterHeight = kMarginNormal;
    
    if ([self respondsToSelector:@selector(setupTableViewHeader:)]) {
        UIView *view = UIViewWithHeight(kMargin16);
        self.tableView.tableHeaderView = view;
        [self setupTableViewHeader:view];
    }
    if ([self respondsToSelector:@selector(setupTableViewFooter:)]) {
        UIView *view = UIViewWithHeight(kMargin16);
        self.tableView.tableFooterView = view;
        [self setupTableViewFooter:view];
    }
    
    if ([self respondsToSelector:@selector(setupEditEnable)]) {
        self.tableView.editing = [self setupEditEnable];
    } else {
        self.tableView.editing = NO;
    }
    
}

- (void)setRowHeight:(CGFloat)rowHeight{
    _rowHeight = rowHeight;
//    [super setRowHeight:rowHeight];
    self.tableView.rowHeight = rowHeight;
}

- (void)setupTableViewHeader:(UIView *)header{
    
}

- (void)setupTableViewFooter:(UIView *)footer{
    
}



- (BaseTableModelListType)dataList{
    if (!_dataList.count) {
        // @xaoxuu: 先用上次的缓存填充界面
        if (!_dataList) {
            _dataList = [services.cache loadObjWithKey:NSStringFromClass([self class])];
        }
        // @xaoxuu: 本地资源
        if ([self respondsToSelector:@selector(dataListForTableView:)]) {
            _dataList = [self dataListForTableView:self.tableView];
            if (_dataList.count) {
                // @xaoxuu: 缓存列表
                [services.cache cacheObj:_dataList forKey:NSStringFromClass([self class]) completion:^{
                    
                }];
                [self.indicator stopAnimating];
            }
        }
        // @xaoxuu: 网络资源
        if ([self respondsToSelector:@selector(setupTableViewWithDataSource:)]) {
            [self.indicator startAnimating];
            [NSBlockOperation ax_delay:0 cooldown:reloadCooldown token:reloadToken performInBackground:^{
                [self setupTableViewWithDataSource:^(BaseTableModelListType sections) {
                    _dataList = sections;
                    // @xaoxuu: 缓存列表
                    [services.cache cacheObj:_dataList forKey:NSStringFromClass([self class]) completion:^{
                        
                    }];
                    // @xaoxuu: 重载界面
                    [self reloadTableViewWithDataSource:sections];
                    
                }];
            }];
        }
        
        
        if (!_dataList) {
            // @xaoxuu: 空数组
            _dataList = [NSMutableArray array];
        }
    }
    return _dataList;
}


#pragma mark - 功能

// @xaoxuu: 根据加载到的数据刷新tableview
- (void)reloadTableViewWithDataSource:(BaseTableModelListType)dataList{
    self.dataList = dataList;
    [self reloadTableView];
}


- (void)reloadTableView{
    [NSBlockOperation ax_delay:0 performInMainQueue:^{
        if (self.dataList.count) {
            [self.indicator stopAnimating];
        } else {
            [self.indicator startAnimating];
        }
        [self.tableView reloadData];
        for (UIBarButtonItem *item in self.controller.navigationItem.rightBarButtonItems) {
            item.enabled = YES;
        }
    }];
}

- (void)reloadDataSourceAndRefreshTableView{
    [NSBlockOperation ax_delay:0 cooldown:reloadCooldown token:@"reloadDataSourceAndRefreshTableView" performInMainQueue:^{
        [self.dataList removeAllObjects];
        [self reloadTableView];
    }];
}

- (void)deleteCellInSection:(NSUInteger)section row:(NSUInteger)row{
    [self.tableView deleteRow:row inSection:section withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.dataList[section].rows removeObjectAtIndex:row];
}

#pragma mark - base table view delegate


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
    BaseTableModelRow *model = self.dataList[section].rows[row];
    if ([self respondsToSelector:@selector(tableViewCellDetailForSection:row:)]) {
        NSString *detail = [self tableViewCellDetailForSection:section row:row];
        if (detail) {
            model.desc = detail;
        }
    }
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
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if ([self respondsToSelector:@selector(tableViewCellDidSelectedInSection:row:)]) {
        [self tableViewCellDidSelectedInSection:section row:row];
    }
    BaseTableModelRow *model = self.dataList[section].rows[row];
    if (!model) {
        return;
    }
    BaseViewController *vc = (BaseViewController *)UIViewControllerFromString(model.target);
    if (vc) {
        vc.title = NSLocalizedString(model.title, nil);
        [self tryToPushToViewController:vc withModel:model section:section row:row];
    } else if (model.target.length) {
        DefaultViewController *vc = [DefaultViewController defaultVCWithTitle:NSLocalizedString(model.title, nil) detail:NSLocalizedString(model.desc, nil)];
        [self tryToPushToViewController:vc withModel:model section:section row:row];
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
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return self.dataList[section].footer_height.floatValue;
//}



#pragma mark - util

- (void)tryToPushToViewController:(__kindof BaseViewController *)targetVC withModel:(BaseTableModelRow *)model section:(NSUInteger)section row:(NSUInteger)row{
    if ([self respondsToSelector:@selector(tableViewCellShouldPushToViewController:withModel:section:row:)]) {
        if ([self tableViewCellShouldPushToViewController:targetVC withModel:model section:section row:row]) {
            [self.controller.navigationController pushViewController:targetVC animated:YES];
        }
    } else {
        [self.controller.navigationController pushViewController:targetVC animated:YES];
    }
}




@end

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


static NSTimeInterval loadingTimeout = 5;

@interface BaseTableView () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>





// @xaoxuu: table view cell name
@property (copy, nonatomic) NSString *cellNibName;
// @xaoxuu: row height
//@property (assign, nonatomic) CGFloat rowHeight;

// @xaoxuu: indicator
@property (strong, nonatomic) DefaultIndicatorView *indicator;

@end

@implementation BaseTableView



- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [self initWithFrame:frame style:UITableViewStyleGrouped]) {
        _cellNibName = @"BaseTableViewCell";
        self.rowHeight = 44;
        [self _base_setupTableView];
        
        [self _base_setupDelegates];
        
        
    }
    return self;
}

- (void)_base_setupTableView{
    // @xaoxuu: 注册复用池
    if (_cellNibName.length) {
        [self registerNib:[UINib nibWithNibName:_cellNibName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:_cellNibName];
    }
    // @xaoxuu: 背景透明
    self.backgroundColor = [UIColor clearColor];
    // @xaoxuu: 高度
    self.estimatedRowHeight = 44;
    self.estimatedSectionHeaderHeight = 0;
    
    self.tableHeaderView = UIViewWithHeight(1);
    self.tableFooterView = services.app.tableFooter;
    // @xaoxuu: 指示器
    self.indicator = [DefaultIndicatorView defaultIndicatorAddToView:self];
    
    
    
}

- (void)_base_setupDelegates{
    // @xaoxuu: 设置table view
    if ([self respondsToSelector:@selector(setupTableView:)]) {
        [NSBlockOperation ax_delay:0 performInMainQueue:^{
            [self setupTableView:self];
        }];
    }
    
}




- (BaseTableModelListType)dataList{
    if (!_dataList.count) {
        // @xaoxuu: 先用上次的缓存填充界面
        if (!_dataList.count) {
            // @xaoxuu: 注意：如果使用本地数据源，如果json文件和tableview文件名一致，则无需实现"setupTableViewDataSource"方法即可自动加载数据源。
            _dataList = [services.cache loadObjWithKey:NSStringFromClass([self class])];
            if (_dataList.count) {
                [self.indicator stopAnimating];
            }
        }
        // @xaoxuu: 加载数据源
        if ([self respondsToSelector:@selector(setupTableViewDataSource:)]) {
            [self.indicator startAnimating];
            [NSBlockOperation ax_delay:0 cooldown:reloadCooldown token:reloadToken performInBackground:^{
                __block BOOL loadDone = NO;
                [self setupTableViewDataSource:^(BaseTableModelListType sections) {
                    loadDone = YES;
                    _dataList = sections;
                    // @xaoxuu: 缓存列表
                    [services.cache cacheObj:_dataList forKey:NSStringFromClass([self class]) completion:^{
                        
                    }];
                    // @xaoxuu: 重载界面
                    [self reloadTableViewWithDataSource:sections];
                    
                }];
                [NSBlockOperation ax_delay:loadingTimeout performInMainQueue:^{
                    if (!loadDone && self.controller) {
                        [self.indicator stopAnimating];
                        [UIAlertController ax_showAlertWithTitle:NSLocalizedString(@"加载失败", nil) message:NSLocalizedString(@"请确认数据源是否正确", nil)];
                    }
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
        [self reloadData];
        for (UIBarButtonItem *item in self.controller.navigationItem.rightBarButtonItems) {
            item.enabled = YES;
        }
    }];
}

- (void)reloadDataSourceAndRefreshTableView{
    [NSBlockOperation ax_delay:0 cooldown:reloadCooldown token:@"reload data source and refresh table view" performInMainQueue:^{
        [self.dataList removeAllObjects];
        [self reloadTableView];
    }];
}


- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath{
    [self.dataList[indexPath.section].rows removeObjectAtIndex:indexPath.row];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BaseTableModelRow *)rowModelWithIndexPath:(NSIndexPath *)indexPath{
    return self.dataList[indexPath.section].rows[indexPath.row];
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return self.dataList[section].header_height.floatValue;
}

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

#pragma mark - self delegate




@end

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
#import "MJRefresh.h"

static NSTimeInterval loadingTimeout = 20;

@interface BaseTableView () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>



// @xaoxuu: list
@property (strong, nonatomic) BaseTableModelListType dataList;


// @xaoxuu: table view cell name
@property (copy, nonatomic) NSString *cellName;


// @xaoxuu: indicator
@property (strong, nonatomic) UIActivityIndicatorView *indicator;



@end

@implementation BaseTableView



- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [self initWithFrame:frame style:UITableViewStyleGrouped]) {
        if ([self respondsToSelector:@selector(setupCustomTableViewCell)]) {
            _cellName = NSStringFromClass([self setupCustomTableViewCell].class);
        } else {
            _cellName = @"BaseTableViewCell";
        }
        
        
        self.rowHeight = 44;
        [self _base_setupTableView];
        
        [self _base_setupDelegates];
        
        
    }
    return self;
}

- (void)_base_setupTableView{
    // @xaoxuu: 注册复用池
    if (_cellName.length) {
        [self registerNib:[UINib nibWithNibName:_cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:_cellName];
    }
    // @xaoxuu: 背景
    self.backgroundColor = axColor.groupTableViewBackground;
    // @xaoxuu: 高度
    self.estimatedRowHeight = 44;
    self.estimatedSectionHeaderHeight = 0;
    
    self.tableHeaderView = UIViewWithHeight(1);
    self.tableFooterView = services.app.randomTableFooter;
    // @xaoxuu: 指示器
    self.indicator = [UIActivityIndicatorView defaultIndicatorWithLoading];
    [self.indicator addToView:self withLoading:YES];
    // @xaoxuu: 分割线
    self.separatorColor = axColor.separatorColor;
    
    
}

- (void)_base_setupDelegates{
    // @xaoxuu: 设置table view
    if ([self respondsToSelector:@selector(initTableView:)]) {
        [self initTableView:self];
    }
    
}




- (BaseTableModelListType)dataList{
    if (!_dataList.count) {
        // @xaoxuu: 先用上次的缓存填充界面
        if (!_dataList.count) {
            // @xaoxuu: 注意：如果使用本地数据源，如果json文件和tableview文件名一致，则无需实现"setupTableViewDataSource"方法即可自动加载数据源。
            _dataList = [services.cache loadObjWithKey:NSStringFromClass([self class])];
            if (_dataList.count) {
                // @xaoxuu: 重载界面
                [self reloadTableView];
            }
            
        }
        // @xaoxuu: 加载数据源
        if ([self respondsToSelector:@selector(setupTableViewDataSource:)]) {
            [self.indicator startAnimating];
            [NSBlockOperation ax_delay:0 cooldown:reloadCooldown token:reloadToken performInBackground:^{
                [self setupTableViewDataSource:^(BaseTableModelListType sections) {
                    // @xaoxuu: 缓存列表
                    [services.cache cacheObj:sections forKey:NSStringFromClass([self class]) completion:^{
                        
                    }];
                    // @xaoxuu: 重载界面
                    [self reloadTableViewWithDataSource:sections];
                    
                }];
                [NSBlockOperation ax_delay:loadingTimeout performInMainQueue:^{
                    [self.indicator stopAnimating];
                    if (self.controller && !_dataList.count) {
                        // @xaoxuu: 加载失败，请确认数据源是否正确
                        [UIAlertController ax_showAlertWithTitle:kStringLoadFail() message:kStringPleaseConfirmDataSourceCorrect() action:^(UIAlertController * _Nonnull alert) {
                            [alert ax_addCancelAction];
                            [alert ax_addDefaultActionWithTitle:kStringHelp() handler:^(UIAlertAction * _Nonnull sender) {
                                
                            }];
                            
                        }];
                    }
                }];
            }];
        } else {
            if (!_dataList.count) {
                [self.indicator stopAnimating];
                // @xaoxuu: 加载失败，请实现数据源协议
                [UIAlertController ax_showAlertWithTitle:kStringLoadFail() message:kStringPleaseImplementDataSource(kNSStringFromSelfClass) action:nil];
            }
        }
        
        if (!_dataList) {
            // @xaoxuu: 空数组
            _dataList = [NSMutableArray array];
        }
    }
    return _dataList;
}


#pragma mark - 功能

// @xaoxuu: 刷新tableView
- (void)reloadTableView{
    dispatch_async(dispatch_get_main_queue(), ^{
        // @xaoxuu: in background queue
        if (self.dataList.count) {
            [self.indicator stopAnimating];
        } else {
            [self.indicator startAnimating];
        }
        [self reloadData];
        for (UIBarButtonItem *item in self.controller.navigationItem.rightBarButtonItems) {
            item.enabled = YES;
        }
    });
    
}

// @xaoxuu: 重新获取数据源并刷新tableView
- (void)reloadDataSourceAndTableView{
    [NSBlockOperation ax_delay:0 cooldown:reloadCooldown token:@"reload data source and refresh table view" performInMainQueue:^{
        [self.dataList removeAllObjects];
        [self reloadTableView];
    }];
}

// @xaoxuu: 根据指定的新数据源重新加载tableView
- (void)reloadTableViewWithDataSource:(BaseTableModelListType)dataList{
    self.dataList = dataList;
    [self reloadTableView];
}

- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath{
    [self.dataList[indexPath.section].rows removeObjectAtIndex:indexPath.row];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BaseTableModelSection *)sectionModel:(NSInteger)section{
    return self.dataList[section];
}

- (BaseTableModelRow *)rowModel:(NSIndexPath *)indexPath{
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
    
    UITableViewCell<BaseTableViewCell> *cell = [tableView dequeueReusableCellWithIdentifier:self.cellName];
    
    BaseTableModelRow *model = self.dataList[section].rows[row];
    // @xaoxuu: 即将设置模型
    if ([self respondsToSelector:@selector(indexPath:willSetModel:)]) {
        [self indexPath:indexPath willSetModel:model];
    }
    // @xaoxuu: 设置模型
    if ([cell respondsToSelector:@selector(setModel:)]) {
        cell.model = model;
    }
    
    // @xaoxuu: 自定义icon
    if ([self respondsToSelector:@selector(indexPath:icon:)] && [cell respondsToSelector:@selector(setIcon:)]) {
        [self indexPath:indexPath icon:^(UIImage *icon) {
            cell.icon = icon;
        }];
    }
    
    // @xaoxuu: 是否显示开关
    if ([self respondsToSelector:@selector(indexPath:showSwitch:)]) {
        [self indexPath:indexPath showSwitch:^(BOOL show, BOOL open) {
            if (show) {
                BaseSettingSwitch *sw = [BaseSettingSwitch new];
                sw.on = open;
                cell.accessoryView = sw;
                if ([self respondsToSelector:@selector(indexPath:switchValueChanged:)]) {
                    [sw ax_addValueChangedHandler:^(__kindof UISwitch * _Nonnull sender) {
                        [self indexPath:indexPath switchValueChanged:sender];
                    }];
                }
            } else {
                cell.accessoryView = nil;
            }
        }];
    }
    
    // @xaoxuu: 默认显示">"
    if ([self respondsToSelector:@selector(indexPath:accessoryType:)]) {
        [self indexPath:indexPath accessoryType:^(UITableViewCellAccessoryType accessoryType) {
            cell.accessoryType = accessoryType;
        }];
    }
        
    
    
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
    BaseTableModelRow *model = self.dataList[section].rows[row];
    if (!model) {
        return;
    }
    // @xaoxuu: selection action
    if ([self respondsToSelector:@selector(indexPath:didSelected:)]) {
        [self indexPath:indexPath didSelected:model];
        return;
    }
    
    // @xaoxuu: push action
    BaseViewController *vc = (BaseViewController *)UIViewControllerFromString(model.target);
    if (vc) {
        vc.title = NSLocalizedString(model.title, nil);
        [self _indexPath:indexPath tryPush:vc withModel:model];
    } else if (model.target.length) {
        // @xaoxuu: push default vc
        DefaultViewController *vc = [DefaultViewController defaultVCWithTitle:NSLocalizedString(model.title, nil) detail:NSLocalizedString(model.desc, nil)];
        [self _indexPath:indexPath tryPush:vc withModel:model];
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

- (void)_indexPath:(NSIndexPath *)indexPath tryPush:(__kindof BaseViewController *)targetVC withModel:(BaseTableModelRow *)model{
    void (^block_push)() = ^{
        if ([self respondsToSelector:@selector(indexPath:willPush:)]) {
            [self indexPath:indexPath willPush:targetVC];
        }
        [self.controller.navigationController pushViewController:targetVC animated:YES];
    };
    if ([self respondsToSelector:@selector(indexPath:shouldPush:)]) {
        if ([self indexPath:indexPath shouldPush:targetVC]) {
            block_push();
        }
    } else {
        block_push();
    }
}


#pragma mark - self delegate


- (UITableViewCell<BaseTableViewCell> *)setupCustomTableViewCell{
    return [BaseTableViewCell new];
}

@end

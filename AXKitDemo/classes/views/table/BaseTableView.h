//
//  BaseTableView.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSwitch.h"
#import "BaseTableViewCell.h"
#import "BaseSettingSwitch.h"

@class BaseTableView,BaseViewController;
@protocol BaseTableViewDelegate <UITableViewDataSource,UITableViewDelegate>

@optional

/**
 初始化table view
 
 @param tableView table view
 */
- (void)initTableView:(BaseTableView *)tableView;


/**
 设置异步加载的数据源(使用本地同名json数据源可以不用实现此方法)
 
 @param dataSource 加载完成的回调
 */
- (void)setupTableViewDataSource:(void (^)(BaseTableModelListType sections))dataSource;



/**
 即将设置模型

 @param indexPath 索引
 @param model 数据模型
 */
- (void)indexPath:(NSIndexPath *)indexPath willSetModel:(BaseTableModelRow *)model;

/**
 cell的icon

 @param indexPath 索引
 @param icon icon
 */
- (void)indexPath:(NSIndexPath *)indexPath icon:(void (^)(UIImage *icon))icon;


/**
 选中了某一行(实现了此方法后点击cell将不会自动执行push操作，除非此方法内实现了push操作。)

 @param indexPath 索引
 @param model 数据模型
 */
- (void)indexPath:(NSIndexPath *)indexPath didSelected:(__kindof BaseTableModelRow *)model;


/**
 将要push到某个控制器

 @param indexPath 索引
 @param targetVC 目标控制器
 @return 是否可以push
 */
- (BOOL)indexPath:(NSIndexPath *)indexPath shouldPush:(__kindof BaseViewController *)targetVC;


/**
 将要push到某个控制器
 
 @param indexPath 索引
 @param targetVC 目标控制器
 */
- (void)indexPath:(NSIndexPath *)indexPath willPush:(__kindof BaseViewController *)targetVC;


/**
 accessory type 默认是">"

 @param indexPath 索引
 @param accessoryType accessory type
 */
- (void)indexPath:(NSIndexPath *)indexPath accessoryType:(void (^)(UITableViewCellAccessoryType accessoryType))accessoryType;

/**
 是否显示开关、开关默认状态

 @param indexPath 索引
 @param showSwitch 是否显示开关、开关默认状态
 */
- (void)indexPath:(NSIndexPath *)indexPath showSwitch:(void (^)(BOOL show, BOOL open))showSwitch;

/**
 开关状态改变事件

 @param indexPath 索引
 @param sender 开关
 */
- (void)indexPath:(NSIndexPath *)indexPath switchValueChanged:(BaseSettingSwitch *)sender;


@end

@interface BaseTableView : UITableView <BaseTableViewDelegate>


/**
 刷新tableView
 */
- (void)reloadTableView;

/**
 重新获取数据源并刷新tableView
 */
- (void)reloadDataSourceAndTableView;

/**
 根据指定的新数据源重新加载tableView

 @param dataList data source
 */
- (void)reloadTableViewWithDataSource:(BaseTableModelListType)dataList;



- (BaseTableModelSection *)sectionModel:(NSInteger)section;

- (BaseTableModelRow *)rowModel:(NSIndexPath *)indexPath;

//- (instancetype)initWithFrame:(CGRect)frame sourcePlistName:(NSString *)name;


//- (void)switchStatusChanged:(void (^)(NSIndexPath *indexPath, BOOL on))changed;

//- (void)deleteCellWithRowModel:(BaseTableModelRow *)rowModel;
- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath;



@end

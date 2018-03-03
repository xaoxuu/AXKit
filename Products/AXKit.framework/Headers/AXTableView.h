//
//  AXTableView.h
//  AXTableKit
//
//  Created by xaoxuu on 27/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXTableModel.h"
#import "AXTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@protocol AXTableView;
typedef UITableView<AXTableView> AXTableViewType;
@protocol AXTableView <UITableViewDataSource,UITableViewDelegate>

#pragma mark data source

@optional

/**
 预加载的数据源，只在tableview初始化的时候加载一次，刷新的时候不走此接口
 项目中有和类同名的json数据源可以不用实现此方法

 @return 预加载的数据源
 */
- (AXTableModelType *)ax_tableViewPreloadDataSource;

/**
 设置异步加载的数据源，刷新的时候会从此接口重新获取数据
 已经实现了预加载的数据源并且数据源不需要更新可以不实现此方法。
 
 @param tableView table view
 @param dataSource 加载完成的回调
 */
- (void)ax_tableView:(AXTableViewType *)tableView dataSource:(void (^)(AXTableModelType *dataSource))dataSource;


#pragma mark delegate

@optional
/**
 初始化table view
 
 @param tableView table view
 */
- (void)ax_tableViewDidLoadFinished:(AXTableViewType *)tableView;

/**
 即将设置数据模型

 @param tableView table view
 @param model 数据模型
 @param indexPath 索引
 */
- (void)ax_tableView:(AXTableViewType *)tableView willSetModel:(AXTableRowModelType *)model forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 已经设置了数据模型
 
 @param tableView table view
 @param cell cell
 @param indexPath 索引
 */
- (void)ax_tableView:(AXTableViewType *)tableView didSetModelForCell:(AXTableViewCellType *)cell atIndexPath:(NSIndexPath *)indexPath;

/**
 选中了某一行
 实现了此方法后点击cell将不会自动执行push操作，除非此方法内实现了push操作或者调用[super ...]。
 
 @param indexPath 索引
 */
- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModelType *)model;

/**
 将要push到某个控制器
 
 @param viewController 目标视图控制器
 @param indexPath 索引
 */
- (void)ax_tableView:(AXTableViewType *)tableView willPushViewController:(UIViewController *)viewController fromRowAtIndexPath:(NSIndexPath *)indexPath;



@end


@interface AXTableView : AXTableViewType


/**
 获取数据

 @return 数据
 */
- (AXTableModelType *)dataList;

/**
 重新获取数据源并刷新tableView
 */
- (void)reloadDataSourceAndRefreshTableView;

/**
 根据索引获取组模型
 
 @param section 组
 @return 组模型
 */
- (AXTableSectionModelType *)modelForSection:(NSInteger)section;

/**
 根据索引获取row模型
 
 @param indexPath 索引
 @return row模型
 */
- (AXTableRowModelType *)modelForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 删除某一行
 
 @param indexPath 索引
 */
- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath;


/**
 从bundle中加载数据源（需要与本类同名的json文件）

 @return 数据源
 */
- (nullable AXTableModelType *)loadDataSourceFromBundle;

/**
 从指定路径加载数据源

 @param path 路径
 @return 数据源
 */
- (nullable AXTableModelType *)loadDataSourceFromPath:(NSString *)path;

@end
NS_ASSUME_NONNULL_END

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



@protocol AXTableView <UITableViewDataSource,UITableViewDelegate>

#pragma mark data source

@optional
/**
 预加载的数据源，项目中有和类同名的json数据源可以不用实现此方法
 */
- (AXTableModelType *)ax_tableViewPreloadDataSource;

/**
 设置异步加载的数据源，已经实现了预加载的数据源并且数据源不需要更新可以不实现此方法。
 
 @param dataSource 加载完成的回调
 */
- (void)ax_tableViewDataSource:(void (^)(AXTableModelType *dataSource))dataSource;



#pragma mark delegate

@optional
/**
 初始化table view
 
 @param tableView table view
 */
- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView;

- (AXTableViewCellType *)ax_tableViewRegisterReuseableCell;
- (AXTableModelType *)ax_tableViewRegisterTableModel;


/**
 即将设置模型
 
 @param indexPath 索引
 @param cell cell
 @param model 数据模型
 */
- (void)ax_tableViewCell:(AXTableViewCellType *)cell willSetModel:(AXTableRowModelType *)model forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 cell的icon
 
 @param indexPath 索引
 @param icon icon
 */
- (void)ax_tableViewCellIcon:(void (^)(UIImage *icon))icon forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 选中了某一行(实现了此方法后点击cell将不会自动执行push操作，除非此方法内实现了push操作。)
 
 @param indexPath 索引
 */
- (void)ax_tableViewDidSelectedRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 是否允许push到某个控制器
 
 @param viewController 目标视图控制器
 @param indexPath 索引
 @return 是否可以进行push
 */
- (BOOL)ax_tableViewShouldPushToViewController:(UIViewController *)viewController fromRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 将要push到某个控制器
 
 @param viewController 目标视图控制器
 @param indexPath 索引
 */
- (void)ax_tableViewWillPushToViewController:(UIViewController *)viewController fromRowAtIndexPath:(NSIndexPath *)indexPath;



@end
typedef UITableView<AXTableView> AXTableViewType;

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
 
 @param indexPath 索引
 @return 组模型
 */
- (AXTableSectionModelType *)tableViewSectionModelForIndexPath:(NSIndexPath *)indexPath;

/**
 根据索引获取row模型
 
 @param indexPath 索引
 @return row模型
 */
- (AXTableRowModelType *)tableViewRowModelForIndexPath:(NSIndexPath *)indexPath;

/**
 删除某一行
 
 @param indexPath 索引
 */
- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath;


/**
 从bundle中加载数据源（需要与本类同名的json文件）

 @return 数据源
 */
- (AXTableModelType *)loadDataSourceFromBundle;

/**
 从指定路径加载数据源

 @param path 路径
 @return 数据源
 */
- (AXTableModelType *)loadDataSourceFromPath:(NSString *)path;

@end

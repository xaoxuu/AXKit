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

@class BaseTableView,BaseViewController;
@protocol BaseTableViewDelegate <UITableViewDataSource,UITableViewDelegate>

@required

/**
 异步加载的数据源
 
 @param dataSource 加载完成的回调
 */
- (void)setupTableViewDataSource:(void (^)(BaseTableModelListType sections))dataSource;

@optional


/**
 自定义table view

 @param tableView table view
 */
- (void)setupTableView:(BaseTableView *)tableView;

- (void)setupTableViewHeader:(UIView *)header;

- (void)setupTableViewFooter:(UIView *)footer;





- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row;

- (UIImage *)tableViewCellIconForSection:(NSUInteger)section row:(NSUInteger)row;

- (void)tableViewCellDidSelected:(__kindof BaseTableModelRow *)model;

- (void)tableViewCellDidSelectedInSection:(NSUInteger)section row:(NSUInteger)row;

- (BOOL)tableViewCellShouldPushToViewController:(__kindof BaseViewController *)targetVC withModel:(__kindof BaseTableModelRow *)model section:(NSUInteger)section row:(NSUInteger)row;

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 默认是显示">"
 
 @return 是否显示
 */
- (BOOL)tableViewCellShowAccessoryDisclosureIndicatorForSection:(NSUInteger)section row:(NSUInteger)row;

/**
 是否显示开关，默认不显示

 @param sw 开关
 @param section section
 @param row row
 @return 是否显示开关
 */
- (BOOL)tableViewCellShowSwitch:(BaseSwitch *)sw forSection:(NSUInteger)section row:(NSUInteger)row;


/**
 开关状态改变了

 @param sw 开关
 @param section section
 @param row row
 */
- (void)tableViewCellDidSwitchStatusChanged:(BaseSwitch *)sw forSection:(NSUInteger)section row:(NSUInteger)row;


@end

@interface BaseTableView : UITableView <BaseTableViewDelegate>

// @xaoxuu: table view
//@property (strong, nonatomic) UITableView *tableView;

- (void)reloadTableView;

- (void)reloadTableViewWithDataSource:(BaseTableModelListType)dataList;

- (void)reloadDataSourceAndRefreshTableView;

// @xaoxuu: list
@property (strong, nonatomic) BaseTableModelListType dataList;

- (BaseTableModelRow *)rowModelWithIndexPath:(NSIndexPath *)indexPath;

//- (instancetype)initWithFrame:(CGRect)frame sourcePlistName:(NSString *)name;


//- (void)switchStatusChanged:(void (^)(NSIndexPath *indexPath, BOOL on))changed;

//- (void)deleteCellWithRowModel:(BaseTableModelRow *)rowModel;
- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath;



@end

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

@class BaseTableView;
@protocol BaseTableViewDelegate <NSObject>

- (NSString *)sourceJsonFileNameForTableView:(UITableView *)tableView;


- (NSArray<BaseTableModelList *> *)dataListForTableView:(UITableView *)tableView;


@optional

- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row;

- (UIImage *)tableViewCellIconForSection:(NSUInteger)section row:(NSUInteger)row;

- (void)tableViewCellDidSelected:(__kindof BaseTableModel *)model;

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

@interface BaseTableView : UIView <BaseTableViewDelegate>

// @xaoxuu: delegate
//@property (weak, nonatomic) id<BaseTableViewDelegate> delegate;

//- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row;
//- (BOOL)tableViewCellSwitchOnForSection:(NSUInteger)section row:(NSUInteger)row;
//- (void)tableViewCellSwitchStatusChanged:(BOOL)on forSection:(NSUInteger)section row:(NSUInteger)row;

- (void)reloadData;

- (instancetype)initWithFrame:(CGRect)frame sourcePlistName:(NSString *)name;


//- (void)switchStatusChanged:(void (^)(NSIndexPath *indexPath, BOOL on))changed;

- (void)setupTableViewHeader:(UIView *)header;

- (void)setupTableViewFooter:(UIView *)footer;



@end

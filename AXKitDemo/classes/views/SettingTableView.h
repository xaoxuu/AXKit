//
//  SettingTableView.h
//  AXKit
//
//  Created by xaoxuu on 17/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableView : UIView

// @xaoxuu: 数据源plist名
@property (copy, nonatomic) NSString *sourcePlistName;
// @xaoxuu: table view cell name
@property (copy, nonatomic) NSString *cellNibName;
// @xaoxuu: row height
@property (assign, nonatomic) CGFloat rowHeight;


- (NSString *)ax_tableViewCellDetailForIndexPath:(NSIndexPath *)indexPath;
- (BOOL)ax_tableViewCellSwitchOnForIndexPath:(NSIndexPath *)indexPath;
- (void)ax_tableViewCellSwitchStatusChanged:(BOOL)on forIndexPath:(NSIndexPath *)indexPath;

- (void)reloadData;

- (instancetype)initWithFrame:(CGRect)frame sourcePlistName:(NSString *)name;


//- (void)switchStatusChanged:(void (^)(NSIndexPath *indexPath, BOOL on))changed;

- (void)setupTableViewHeader:(UIView *)header;

- (void)setupTableViewFooter:(UIView *)footer;

@end

//
//  BaseTableView.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UIView


- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row;
- (BOOL)tableViewCellSwitchOnForSection:(NSUInteger)section row:(NSUInteger)row;
- (void)tableViewCellSwitchStatusChanged:(BOOL)on forSection:(NSUInteger)section row:(NSUInteger)row;


- (void)reloadData;

- (instancetype)initWithFrame:(CGRect)frame sourcePlistName:(NSString *)name;


//- (void)switchStatusChanged:(void (^)(NSIndexPath *indexPath, BOOL on))changed;

- (void)setupTableViewHeader:(UIView *)header;

- (void)setupTableViewFooter:(UIView *)footer;




- (NSString *)tableViewJsonDataSourceName;


@end

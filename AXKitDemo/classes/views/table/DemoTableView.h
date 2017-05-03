//
//  DemoTableView.h
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoTableView : UIView

// @xaoxuu: 数据源plist名
@property (copy, nonatomic) NSString *sourcePlistName;
// @xaoxuu: table view cell name
@property (copy, nonatomic) NSString *cellNibName;
// @xaoxuu: row height
@property (assign, nonatomic) CGFloat rowHeight;


- (NSString *)tableViewCellDetailForSection:(NSUInteger)section row:(NSUInteger)row;
- (BOOL)tableViewCellSwitchOnForSection:(NSUInteger)section row:(NSUInteger)row;
- (void)tableViewCellSwitchStatusChanged:(BOOL)on forSection:(NSUInteger)section row:(NSUInteger)row;


- (void)reloadData;

- (instancetype)initWithFrame:(CGRect)frame sourcePlistName:(NSString *)name;


//- (void)switchStatusChanged:(void (^)(NSIndexPath *indexPath, BOOL on))changed;

- (void)setupTableViewHeader:(UIView *)header;

- (void)setupTableViewFooter:(UIView *)footer;


@end
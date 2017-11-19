//
//  UITableView+Creator.h
//  AXKit
//
//  Created by xaoxuu on 12/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


CG_INLINE CGRect
top0()
{
    return CGRectMake(0, 0, kScreenW, kScreenH);
}

CG_INLINE CGRect
top64()
{
    return CGRectMake(0, 64, kScreenW, kScreenH-64);
}

CG_INLINE CGRect
top(CGFloat height)
{
    return CGRectMake(0, height, kScreenW, kScreenH-height);
}

CG_INLINE UIView *
viewWithHeight(CGFloat height)
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, height)];
}

CG_INLINE UIView *
none()
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
}



@interface UITableView (Creator)

#pragma mark - creator


/**
 创建一个tableview到VC

 @param target vc
 @param frame frame
 @param style style
 @param reuseId cell复用池ID
 @return tableview
 */
+ (instancetype)ax_tableViewWithTarget:(UIViewController<UITableViewDataSource, UITableViewDelegate> *)target
                                 frame:(CGRect)frame
                                 style:(UITableViewStyle)style
     registerNibForCellReuseIdentifier:(NSString *)reuseId;


/**
 创建一个tableview到view

 @param target view
 @param frame frame
 @param style style
 @param reuseId cell复用池ID
 @return tableview
 */
+ (instancetype)ax_tableViewWithView:(UIView<UITableViewDataSource, UITableViewDelegate> *)target
                               frame:(CGRect)frame
                               style:(UITableViewStyle)style
   registerNibForCellReuseIdentifier:(NSString *)reuseId;


#pragma mark - action


/**
 当点击某个view的时候tableview回到顶部

 @param view 被点击的view
 */
- (void)scrollToTopWhenViewTapped:(UIView *)view;


/**
 点击某个view的时候刷新tableview

 @param view 被点击的view
 */
- (void)refreshWhenViewTapped:(UIView *)view;


#pragma mark - detail

#pragma mark table

/**
 header
 */
- (UITableView *(^)(UIView *))ax_tableHeaderView;


/**
 footer
 */
- (UITableView *(^)(UIView *))ax_tableFooterView;
#pragma mark section

/**
 section header height
 */
- (UITableView *(^)(CGFloat))ax_sectionHeaderHeight;


/**
 section footer height
 */
- (UITableView *(^)(CGFloat))ax_sectionFooterHeight;
#pragma mark table

/**
 row height
 */
- (UITableView *(^)(CGFloat))ax_rowHeight;

#pragma mark style

/**
 background color
 */
- (UITableView *(^)(UIColor *))ax_backgroundColor;



@end

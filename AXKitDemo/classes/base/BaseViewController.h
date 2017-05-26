//
//  BaseViewController.h
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"


typedef NS_ENUM(NSUInteger, ContentViewStyle) {
    ContentViewStyleNoTopBar, // 默认   // view的区域覆盖屏幕除了navBar以外的地方，（适用于只有navBar没tabBar的视图）
    ContentViewStyleNoBottomBar,       // view的区域覆盖屏幕除了tabBar以外的地方，（适用于只有tabBar没有navBar的视图）
    ContentViewStyleNoTopAndBottomBar, // view的区域覆盖屏幕除了navBar和tabBar以外的地方，（适用于既有navBar又有tabBar的视图）
    ContentViewStyleFullScreen,             // view的区域覆盖全屏幕，（适用于没有navBar和tabBar的视图）
};

#pragma mark - 基类协议
@protocol BaseVC <NSObject>
@optional


/**
 初始化内容区域
 */
- (void)initContentView:(UIView *)view style:(void (^)(ContentViewStyle style))style;

- (void)initSubview;


@end

#pragma mark - 模块化组件库
@protocol AXModuleKit <NSObject>
@optional

/**
 安装右上角刷新按钮
 
 @param sender 刷新按钮
 */
- (void)installRightRefreshBarButton:(UIBarButtonItem *)sender;


/**
 安装table view

 @return table view
 */
- (BaseTableView *)installTableView;


@end

@interface BaseViewController : UIViewController <BaseVC,AXModuleKit>

// @xaoxuu: table view
@property (strong, nonatomic) __kindof BaseTableView *tableView;

@end

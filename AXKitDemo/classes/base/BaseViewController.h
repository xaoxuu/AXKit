//
//  BaseViewController.h
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"

typedef NS_ENUM(NSUInteger, ViewControllerHeight) {
    ViewControllerHeightFullScreen,
    ViewControllerHeightWithoutBottomBar,
    ViewControllerHeightWithoutTopBar,
    ViewControllerHeightWithoutTopAndBottomBar,
};

@protocol BaseViewControllerDelegate <NSObject>

@required

- (ViewControllerHeight)setupViewControllerHeight;

@optional

- (BaseTableView *)setupTableView;

- (void)setupRightRefreshBarButton:(UIBarButtonItem *)sender;


- (void)setupButtons;





@end


@interface BaseViewController : UIViewController <BaseViewControllerDelegate>

// @xaoxuu: table view
@property (strong, nonatomic) __kindof BaseTableView *tableView;

@end

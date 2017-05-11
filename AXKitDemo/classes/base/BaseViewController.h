//
//  BaseViewController.h
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

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

- (void)setupTableView;
- (void)setupButtons;





@end


@interface BaseViewController : UIViewController <BaseViewControllerDelegate>

@end

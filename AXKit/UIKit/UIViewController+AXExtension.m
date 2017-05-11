//
//  UIViewController+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIViewController+AXExtension.h"

// @xaoxuu: 此类必须要有xib文件
inline UIViewController *UIViewControllerFromString(NSString *name){
    return [[NSClassFromString(name) class] new];
}


@implementation UIViewController (AXExtension)


//- (void)ax_hidesNavBarInRootController:(BOOL)hidden animated:(BOOL)animated{
//    if (self.navigationController.viewControllers.count == 1) {
//        // @xaoxuu: root controller
//        [self.navigationController setNavigationBarHidden:hidden animated:animated];
//    } else {
//        // @xaoxuu: not root controller
//        [self.navigationController setNavigationBarHidden:NO animated:animated];
//    }
//}
//
//- (void)ax_hidesBottomBarWhenPushed:(BOOL)pushed{
//    NSArray *arr = self.navigationController.viewControllers;
//    if (self.navigationController.viewControllers.count == 1) {
//        // @xaoxuu: root controller
//        self.hidesBottomBarWhenPushed = NO;
//    } else {
//        // @xaoxuu: not root controller
//        self.hidesBottomBarWhenPushed = pushed;
//    }
//}


@end

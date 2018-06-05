//
//  UIViewController+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 根据view controller的类名创建实例

 @param name view controller的类名
 @return view controller实例对象
 */
CG_EXTERN UIViewController *UIViewControllerNamed(NSString *name);


@interface UIViewController (AXExtension)

@end

NS_ASSUME_NONNULL_END

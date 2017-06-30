//
//  UIResponder+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

/**
 根控制器

 @return 根控制器
 */
FOUNDATION_EXTERN UIViewController * _Nullable AXRootViewController();


@interface UIResponder (AXExtension)


/**
 获取app根控制器
 
 @return 根控制器rootVC
 */
- (nullable UIViewController *)rootVC;

@end
NS_ASSUME_NONNULL_END

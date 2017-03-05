//
//  UIBarButtonItem+AXBlockWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foundation+AXMacros.h"

NS_ASSUME_NONNULL_BEGIN


@interface UIBarButtonItem (ATBlockWrapper)

+ (instancetype)ax_itemWithSystem:(UIBarButtonSystemItem)systemItem action:(void (^)(id sender))action;

- (instancetype)ax_initWithSystem:(UIBarButtonSystemItem)systemItem action:(void (^)(id sender))action AX_INITIALIZER;


+ (instancetype)ax_itemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action;

- (instancetype)ax_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action AX_INITIALIZER;


+ (instancetype)ax_itemWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action;

- (instancetype)ax_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action AX_INITIALIZER;

+ (instancetype)ax_itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action;

- (instancetype)ax_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style action:(void (^)(id sender))action AX_INITIALIZER;

@end

NS_ASSUME_NONNULL_END

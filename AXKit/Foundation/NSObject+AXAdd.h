//
//  NSObject+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 13/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AXAdd)

/**
 获取所有子类

 @return 所有子类
 */
+ (NSArray *)ax_allSubclasses;

/**
 isEqual:
 */
- (BOOL (^)(id object))isEqual;

/**
 respondsToSelector:
 */
- (BOOL (^)(SEL aSelector))respondsToSelector;

@end

NS_ASSUME_NONNULL_END

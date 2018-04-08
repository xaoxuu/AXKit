//
//  AXRuntimeHelper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AXRuntimeHelper : NSObject

/**
 交换类方法的实现

 @param cls 类
 @param selector1 类方法1
 @param selector2 类方法2
 */
+ (void)exchangeClassMethodImplementations:(Class)cls selector1:(SEL)selector1 selector2:(SEL)selector2;

/**
 交换实例方法的实现

 @param cls 类
 @param selector1 实例方法1
 @param selector2 实例方法2
 */
+ (void)exchangeInstanceMethodImplementations:(Class)cls selector1:(SEL)selector1 selector2:(SEL)selector2;

@end

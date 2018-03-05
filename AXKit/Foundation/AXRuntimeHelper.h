//
//  AXRuntimeHelper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AXRuntimeHelper : NSObject

+ (void)exchangeClassMethodImplementations:(Class)cls selector1:(SEL)selector1 selector2:(SEL)selector2;

+ (void)exchangeInstanceMethodImplementations:(Class)cls selector1:(SEL)selector1 selector2:(SEL)selector2;

@end

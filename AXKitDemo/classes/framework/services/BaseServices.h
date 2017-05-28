//
//  BaseServices.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BaseServicesDelegate <NSObject>
@optional

/**
 注册代理
 
 @param delegate 代理
 */
- (void)registerDelegate:(id<BaseServicesDelegate>)delegate;

/**
 取消注册代理
 
 @param delegate 代理
 */
- (void)unRegisterDelegate:(id<BaseServicesDelegate>)delegate;


@end

@protocol ServicesPrivateMethod <NSObject>

@optional

/**
 所有代理执行
 
 @param handler block
 */
- (void)allDelegates:(void (^)(id<BaseServicesDelegate> delegate))handler;


@end

@interface BaseServices : NSObject <BaseServicesDelegate>


@end


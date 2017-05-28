//
//  BaseServices.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"


@interface BaseServices () <ServicesPrivateMethod>


// @xaoxuu: delegates
@property (strong, nonatomic) NSMutableArray<id<BaseServicesDelegate>> *delegates;


@end

@implementation BaseServices



- (instancetype)init{
    if (self = [super init]) {
        
        _delegates = [NSMutableArray array];
        
    }
    return self;
}


- (void)registerDelegate:(id<BaseServicesDelegate>)delegate{
    for (id<BaseServicesDelegate> tmp in self.delegates) {
        // @xaoxuu: 注册过的类就不再重复注册
        if ([NSStringFromClass([delegate class]) isEqualToString:NSStringFromClass([tmp class])]) {
            return;
        }
    }
    if (delegate && ![self.delegates containsObject:delegate]) {
        [self.delegates addObject:delegate];
    }
}

- (void)unRegisterDelegate:(id<BaseServicesDelegate>)delegate{
    if (delegate && [self.delegates containsObject:delegate]) {
        [self.delegates removeObject:delegate];
    }
}

// @xaoxuu: 让所有的代理执行
- (void)allDelegates:(void (^)(id<BaseServicesDelegate> delegate))handler{
    [self.delegates enumerateObjectsUsingBlock:^(id<BaseServicesDelegate>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (handler) {
            handler(obj);
        }
    }];
}


@end

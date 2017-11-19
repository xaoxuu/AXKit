//
//  ServiceLayer.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ServiceLayer.h"

ServiceLayer *service = nil;

@implementation ServiceLayer

+ (instancetype)sharedInstance{
    if (!service) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            service = [[self alloc] init];
        });
    }
    return service;
}

- (instancetype)init{
    if (self = [super init]) {
        _cache = [CacheService new];
        
        
    }
    return self;
}


@end

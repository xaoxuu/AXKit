//
//  ServicesLayer.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ServicesLayer.h"

ServicesLayer *services = nil;

@implementation ServicesLayer



+ (instancetype)sharedInstance{
    if (!services) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!services) {
                services = [[ServicesLayer alloc] init];
            }
        });
    }
    return services;
}


- (instancetype)init{
    if (!services) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!services) {
                services = [super init];
            }
        });
    }
    
    _app = [AppServices new];
    _cache = [CacheServices new];
    _json = [JsonServices new];
    _alert = [AlertServices new];
    
    
    return services;
}



@end

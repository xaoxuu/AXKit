//
//  ServiceLayer.h
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseService.h"
#import "CacheService.h"

@class ServiceLayer;
extern ServiceLayer *service;

@interface ServiceLayer : BaseService


// @xaoxuu: cache
@property (strong, nonatomic) CacheService *cache;


+ (instancetype)sharedInstance;


@end

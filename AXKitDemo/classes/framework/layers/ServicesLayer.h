//
//  ServicesLayer.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"
#import "AppServices.h"
#import "CacheServices.h"
#import "JsonServices.h"

@class ServicesLayer;
extern ServicesLayer *services;

@interface ServicesLayer : BaseServices

// @xaoxuu: app
@property (strong, nonatomic) AppServices *app;
// @xaoxuu: cache
@property (strong, nonatomic) CacheServices *cache;
// @xaoxuu: json
@property (strong, nonatomic) JsonServices *json;

+ (instancetype)sharedInstance;

@end

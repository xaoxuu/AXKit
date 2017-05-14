//
//  DataAccessLayer.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseDataAccess.h"
#import "AssetsDataAccess.h"
#import "NetworkDataAccess.h"
#import "DeveloperDataAccess.h"
#import "AppDataAccess.h"
#import "GitHubApiDataAccess.h"
#import "CacheDataAccess.h"

@interface DataAccessLayer : BaseDataAccess


// @xaoxuu: developer
@property (strong, nonatomic) DeveloperDataAccess *developer;
// @xaoxuu: app
@property (strong, nonatomic) AppDataAccess *app;
// @xaoxuu: assets
@property (strong, nonatomic) AssetsDataAccess *assets;
// @xaoxuu: cache
@property (strong, nonatomic) CacheDataAccess *cache;
// @xaoxuu: network
@property (strong, nonatomic) NetworkDataAccess *network;

// @xaoxuu: github api
@property (strong, nonatomic) GitHubApiDataAccess *github;

+ (instancetype)sharedInstance;

@end

//
//  DataAccessLayer.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseDataAccess.h"
#import "AssetsDataAccess.h"


@interface DataAccessLayer : BaseDataAccess

// @xaoxuu: assets
@property (strong, nonatomic) AssetsDataAccess *assets;


+ (instancetype)sharedInstance;

@end

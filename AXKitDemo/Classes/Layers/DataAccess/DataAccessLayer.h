//
//  DataAccessLayer.h
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDA.h"


@interface DataAccessLayer : NSObject

// @xaoxuu: net
@property (strong, nonatomic) NetworkDA *network;

@end

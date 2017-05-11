//
//  DataAccessLayer.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DataAccessLayer.h"

DataAccessLayer *instance = nil;

@implementation DataAccessLayer


+ (instancetype)sharedInstance{
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!instance) {
                instance = [[DataAccessLayer alloc] init];
            }
        });
    }
    return instance;
}


- (instancetype)init{
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!instance) {
                instance = [super init];
            }
        });
    }
    
    _assets = [AssetsDataAccess new];
    
    
    
    return instance;
}



@end

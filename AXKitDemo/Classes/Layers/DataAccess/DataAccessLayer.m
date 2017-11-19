//
//  DataAccessLayer.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DataAccessLayer.h"

@implementation DataAccessLayer


- (instancetype)init{
    if (self = [super init]) {
        _network = [NetworkDA new];
    }
    return self;
}

@end

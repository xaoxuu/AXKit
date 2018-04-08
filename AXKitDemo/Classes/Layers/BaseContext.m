//
//  BaseContext.m
//  AXKitDemo
//
//  Created by xaoxuu on 2018/4/8.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "BaseContext.h"

BaseContext *instance = nil;

@implementation BaseContext


+ (instancetype)sharedInstance{
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[self alloc] init];
        });
    }
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        
        
        
    }
    return self;
}



@end

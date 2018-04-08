//
//  BaseContext.h
//  AXKitDemo
//
//  Created by xaoxuu on 2018/4/8.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseContext : NSObject

/**
 drawer open
 */
@property (assign, nonatomic) BOOL drawerOpened;

+ (instancetype)sharedInstance;

@end

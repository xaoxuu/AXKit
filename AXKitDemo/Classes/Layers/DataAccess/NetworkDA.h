//
//  NetworkDA.h
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkDA : NSObject

// @xaoxuu: request url string
@property (copy, nonatomic) NSString *URLString;


- (void)getURLCompletion:(void (^)(id response))completion fail:(void (^)(NSError * error))fail;

@end

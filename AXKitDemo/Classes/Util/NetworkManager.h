//
//  NetworkManager.h
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


#define BaseURLForApp   @"https://api-static.xaoxuu.com/app/axkit/"
#define BaseURLForTheme @"https://api-static.xaoxuu.com/theme/"

FOUNDATION_EXTERN NSString *kBaseURLStringForApp;
FOUNDATION_EXTERN NSString *kBaseURLStringForTheme;

@interface NetworkManager : NSObject

+ (void)getURLString:(NSString *)urlString completion:(void (^)(NSData * _Nullable data, id response))completion fail:(void (^)(NSError * error))fail;

//+ (void)getURLWithKey:(NSString *)urlString completion:(void (^)(id response))completion fail:(void (^)(NSError * error))fail;


@end

//
//  NetworkManager.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NetworkManager.h"

NSString *kBaseURLStringForApp = @"https://api-static.xaoxuu.com/app/axkit";
NSString *kBaseURLStringForTheme = @"https://api-static.xaoxuu.com/theme";

@implementation NetworkManager


+ (void)getURLString:(NSString *)urlString completion:(void (^)(NSData * _Nullable data, id response))completion fail:(void (^)(NSError * error))fail{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            AXLogError(error);
            if (fail) {
                fail(error);
            }
            
        } else {
            if (completion) {
                id ret = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                completion(data, ret);
            }
        }
    }];
    [dataTask resume];
}

@end

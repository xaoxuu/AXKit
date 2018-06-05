//
//  NetworkDA.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NetworkDA.h"

@implementation NetworkDA

- (instancetype)init{
    if (self = [super init]) {
        
        
        
        
    }
    return self;
}



- (void)getURLCompletion:(void (^)(id response))completion fail:(void (^)(NSError * error))fail{
    NSURL *url = [NSURL URLWithString:self.URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            AXCachedLogError(error);
            if (fail) {
                fail(error);
            }
            
        } else {
            if (completion) {
                id ret = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                completion(ret);
            }
        }
    }];
    [dataTask resume];
}
@end

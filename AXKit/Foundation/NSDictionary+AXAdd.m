//
//  NSDictionary+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSDictionary+AXAdd.h"
#import "NSObject+AXAdd.h"
#import "NSObject+AXJsonAdd.h"

@implementation NSDictionary (AXAdd)

+ (nullable instancetype)dictionaryWithJsonString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    } else {
        return nil;
    }
}

- (NSDictionary *(^)(NSString *key))dictionaryValueForKey{
    return ^(NSString *key){
        return key.length ? NSDictionary.parse(self[key]) : nil;
    };
    
}

- (NSArray *(^)(NSString *key))arrayValueForKey{
    return ^(NSString *key){
        return key.length ? NSArray.parse(self[key]) : nil;
    };
    
}

- (NSString *(^)(NSString *key))stringValueForKey{
    return ^(NSString *key){
        return key.length ? NSString.parse(self[key]) : nil;
    };
    
}

- (NSNumber *(^)(NSString *key))numberValueForKey{
    return ^(NSString *key){
        return key.length ? NSNumber.safe(self[key]) : nil;
    };
}

@end

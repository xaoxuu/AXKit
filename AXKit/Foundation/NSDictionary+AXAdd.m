//
//  NSDictionary+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSDictionary+AXAdd.h"
#import "NSObject+AXAdd.h"


static inline NSDictionary *dictionaryValueForKey(NSDictionary *dict, NSString *key){
    return autoDictionary(dict[key], nil);
}
static inline NSArray *arrayValueForKey(NSDictionary *dict, NSString *key){
    return autoArray(dict[key], nil);
}

static inline NSString *stringValueForKey(NSDictionary *dict, NSString *key){
    if (key.length) {
        return autoString(dict[key], nil);
    }
    return nil;
}
static inline NSNumber *numberValueForKey(NSDictionary *dict, NSString *key){
    if (key.length) {
        return autoNumber(dict[key], nil);
    }
    return nil;
}


@implementation NSDictionary (AXAdd)

+ (instancetype)dictionaryWithJsonString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    } else {
        return nil;
    }
}


- (NSDictionary * _Nonnull (^)(NSString * _Nonnull))dictionaryValue{
    return ^NSDictionary *(NSString *key){
        return dictionaryValueForKey(self, key);
    };
}

- (NSArray * _Nonnull (^)(NSString * _Nonnull))arrayValue{
    return ^NSArray *(NSString *key){
        return arrayValueForKey(self, key);
    };
}

- (NSString * _Nonnull (^)(NSString * _Nonnull))stringValue{
    return ^NSString *(NSString *key){
        return stringValueForKey(self, key);
    };
}
- (NSString * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))safeStringValue{
    return ^NSString *(NSString *key, NSString *def){
        return stringValueForKey(self, key)?:def;
    };
}
- (NSNumber * _Nonnull (^)(NSString * _Nonnull))numberValue{
    return ^NSNumber *(NSString *key){
        return numberValueForKey(self, key);
    };
}
- (NSNumber * _Nonnull (^)(NSString * _Nonnull, NSNumber * _Nonnull))safeNumberValue{
    return ^NSNumber *(NSString *key, NSNumber *def){
        return numberValueForKey(self, key)?:def;
    };
}



@end

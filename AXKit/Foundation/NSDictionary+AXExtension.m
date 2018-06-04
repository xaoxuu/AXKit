//
//  NSDictionary+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSDictionary+AXExtension.h"
#import "NSObject+AXExtension.h"


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


@implementation NSDictionary (AXExtension)


- (NSDictionary *)dictionaryValueForKey:(NSString *)key{
    return dictionaryValueForKey(self, key);
}

- (NSArray *)arrayValueForKey:(NSString *)key{
    return arrayValueForKey(self, key);
}

- (NSString *)stringValueForKey:(NSString *)key{
    return stringValueForKey(self, key);
}
- (NSNumber *)numberValueForKey:(NSString *)key{
    return numberValueForKey(self, key);
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

+ (instancetype)dictionaryWithJsonString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    } else {
        return nil;
    }
}


@end

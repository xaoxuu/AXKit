//
//  NSDictionary+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSDictionary+AXExtension.h"

@implementation NSDictionary (AXExtension)


- (NSDictionary *)dictionaryValueForKey:(NSString *)key{
    NSObject *obj = self[key];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)obj;
    } else {
        return [NSDictionary dictionary];
    }
}

- (NSArray *)arrayValueForKey:(NSString *)key{
    NSObject *obj = self[key];
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    } else {
        return [NSArray array];
    }
}

- (NSString *)stringValueForKey:(NSString *)key{
    NSObject *obj = self[key];
    if ([obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    } else {
        return @"";
    }
}

- (double)doubleValueForKey:(NSString *)key{
    NSObject *obj = self[key];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        return strValue.doubleValue;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber *numValue = (NSNumber *)obj;
        return numValue.doubleValue;
    } else {
        return 0;
    }
}

- (NSInteger)integerValueForKey:(NSString *)key{
    NSObject *obj = self[key];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        return strValue.integerValue;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber *numValue = (NSNumber *)obj;
        return numValue.integerValue;
    } else {
        return 0;
    }
}

- (BOOL)boolValueForKey:(NSString *)key{
    NSObject *obj = self[key];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        return strValue.boolValue;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber *numValue = (NSNumber *)obj;
        return numValue.boolValue;
    } else {
        return 0;
    }
}

@end

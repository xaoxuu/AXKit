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
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        NSData *data = [strValue dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        } else {
            return [NSDictionary dictionary];
        }
    } else {
        return [NSDictionary dictionary];
    }
}

- (NSArray *)arrayValueForKey:(NSString *)key{
    NSObject *obj = self[key];
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        NSData *data = [strValue dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        } else {
            return [NSArray array];
        }
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

- (NSNumber *)numberValueForKey:(NSString *)key{
    NSObject *obj = self[key];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        return @(strValue.doubleValue);
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)obj;
    } else {
        return @0;
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

- (float)floatValueForKey:(NSString *)key{
    NSObject *obj = self[key];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        return strValue.floatValue;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber *numValue = (NSNumber *)obj;
        return numValue.floatValue;
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

- (NSInteger)intValueForKey:(NSString *)key{
    NSObject *obj = self[key];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        return strValue.intValue;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber *numValue = (NSNumber *)obj;
        return numValue.intValue;
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

+ (instancetype)dictionaryWithJsonString:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    } else {
        return nil;
    }
}

@end

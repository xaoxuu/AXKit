//
//  NSObject+AXJsonAdd.m
//  AXKit
//
//  Created by xaoxuu on 2018/6/8.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "NSObject+AXJsonAdd.h"
#import "NSString+AXAdd.h"

static inline NSData *safeData(id obj, NSData *def){
    return [obj isKindOfClass:NSData.class]?obj:def;
}
static inline NSDictionary *safeDictionary(id obj, NSDictionary *def){
    return [obj isKindOfClass:NSDictionary.class]?obj:def;
}
static inline NSDictionary *autoDictionary(id obj, NSDictionary *def){
    NSDictionary *ret = safeDictionary(obj, nil);
    if (!ret) {
        id json = ((NSString *)obj).jsonValue.dictionaryValue;
        if ([json isKindOfClass:NSDictionary.class]) {
            return json;
        }
        return def;
    }
    return ret;
}

static inline NSArray *safeArray(id obj, NSArray *def){
    return [obj isKindOfClass:NSArray.class]?obj:def;
}
static inline NSArray *autoArray(id obj, NSArray *def){
    NSArray *ret = safeArray(obj, nil);
    if (!ret) {
        id json = ((NSString *)obj).jsonValue.arrayValue;
        if ([json isKindOfClass:NSArray.class]) {
            return json;
        }
        return def;
    }
    return ret;
}

static inline NSString *safeString(id obj, NSString *def){
    NSString *str = [obj isKindOfClass:NSString.class]?obj:nil;
    if (str.length) {
        str = str.lowercaseString;
        if ([str isEqualToString:@"<null>"]) {
            str = nil;
        } else if ([str isEqualToString:@"(null)"]) {
            str = nil;
        } else if ([str isEqualToString:@"null"]) {
            str = nil;
        } else if ([str isEqualToString:@"nil"]) {
            str = nil;
        }
    }
    return str?obj:def;
}
static inline NSString *autoString(id obj, NSString *def){
    NSString *ret = safeString(obj, nil);
    if (!ret) {
        if ([obj isKindOfClass:NSNumber.class]) {
            return ((NSNumber *)obj).description;
        }
        return def;
    }
    return ret;
}

static inline NSNumber *safeNumber(id obj, NSNumber *def){
    return [obj isKindOfClass:NSNumber.class]?obj:def;
}
static inline NSNumber *autoNumber(id obj, NSNumber *def){
    NSNumber *ret = safeNumber(obj, nil);
    if (!ret) {
        if ([obj isKindOfClass:NSString.class]) {
            return ((NSString *)obj).numberValue;
        }
        return def;
    }
    return ret;
}


@implementation NSData (AXJsonAdd)

+ (NSData *(^)(id obj, NSData *def))safeData{
    return ^NSData *(id obj, NSData *def){
        return safeData(obj, def);
    };
}
- (AXResult *)jsonValue{
    return self.jsonValueWithOptions(NSJSONReadingMutableContainers);
}

- (AXResult *(^)(NSJSONReadingOptions opt))jsonValueWithOptions{
    return ^AXResult *(NSJSONReadingOptions opt){
        return [AXResult resultWithJsonReadingOptions:opt data:^NSData * _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return self;
        }];
    };
}
@end

@implementation NSString (AXJsonAdd)

+ (NSString *(^)(id obj, NSString *def))safeString{
    return ^NSString *(id obj, NSString *def){
        return safeString(obj, def);
    };
}

+ (NSString *(^)(id obj, NSString *def))autoString{
    return ^NSString *(id obj, NSString *def){
        return autoString(obj, def);
    };
}

- (AXResult *)jsonValue{
    return self.jsonValueWithOptions(NSJSONReadingMutableContainers);
}

- (AXResult *(^)(NSJSONReadingOptions opt))jsonValueWithOptions{
    return ^AXResult *(NSJSONReadingOptions opt){
        return [AXResult resultWithJsonReadingOptions:opt data:^NSData * _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return [self dataUsingEncoding:NSUTF8StringEncoding];
        }];
    };
}


@end
@implementation NSNumber (AXJsonAdd)


+ (NSNumber *(^)(id obj, NSNumber *def))safeNumber{
    return ^NSNumber *(id obj, NSNumber *def){
        return safeNumber(obj, def);
    };
}

+ (NSNumber *(^)(id obj, NSNumber *def))autoNumber{
    return ^NSNumber *(id obj, NSNumber *def){
        return autoNumber(obj, def);
    };
}


@end


@implementation NSArray (AXJsonAdd)

+ (NSArray *(^)(id obj, NSArray *def))safeArray{
    return ^NSArray *(id obj, NSArray *def){
        return safeArray(obj, def);
    };
}

+ (NSArray *(^)(id obj, NSArray *def))autoArray{
    return ^NSArray *(id obj, NSArray *def){
        return autoArray(obj, def);
    };
}

- (AXResult *)jsonValue{
    return self.jsonValueWithOptions(NSJSONWritingPrettyPrinted);
}

- (AXResult *(^)(NSJSONWritingOptions opt))jsonValueWithOptions{
    return ^AXResult *(NSJSONWritingOptions opt){
        return [AXResult resultWithJsonWritingOptions:opt object:^id _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return self;
        }];
    };
}

@end


@implementation NSDictionary (AXJsonAdd)

+ (NSDictionary *(^)(id obj, NSDictionary *def))safeDictionary{
    return ^NSDictionary *(id obj, NSDictionary *def){
        return safeDictionary(obj, def);
    };
}

+ (NSDictionary *(^)(id obj, NSDictionary *def))autoDictionary{
    return ^NSDictionary *(id obj, NSDictionary *def){
        return autoDictionary(obj, def);
    };
}

- (AXResult *)jsonValue{
    return self.jsonValueWithOptions(NSJSONWritingPrettyPrinted);
}

- (AXResult *(^)(NSJSONWritingOptions opt))jsonValueWithOptions{
    return ^AXResult *(NSJSONWritingOptions opt){
        return [AXResult resultWithJsonWritingOptions:opt object:^id _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return self;
        }];
    };
}
@end


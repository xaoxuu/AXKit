//
//  NSObject+AXJsonAdd.m
//  AXKit
//
//  Created by xaoxuu on 2018/6/8.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "NSObject+AXJsonAdd.h"
#import "NSObject+AXAdd.h"

@implementation NSString (AXJsonAdd)

+ (NSString *(^)(id obj, NSString *def))autoString{
    return ^NSString *(id obj, NSString *def){
        NSString *str = self.safeString(obj, nil);
        if (str) {
            return str;
        } else if ([obj isKindOfClass:NSData.class]) {
            return [[NSString alloc] initWithData:(NSData *)obj encoding:NSUTF8StringEncoding] ?: def;
        } else if ([obj isKindOfClass:NSArray.class]) {
            return ((NSArray *)obj).toJson().stringValue ?: def;
        } else if ([obj isKindOfClass:NSDictionary.class]) {
            return ((NSDictionary *)obj).toJson().stringValue ?: def;
        } else {
            return def;
        }
    };
}

- (AXResult *(^)(void))toJson{
    return ^{
        return self.toJsonWithOptions(NSJSONReadingMutableContainers);
    };
}

- (AXResult *(^)(NSJSONReadingOptions opt))toJsonWithOptions{
    return ^AXResult *(NSJSONReadingOptions opt){
        return [AXResult resultWithJsonReadingOptions:opt data:^NSData * _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return [self dataUsingEncoding:NSUTF8StringEncoding];
        }];
    };
}

@end

@implementation NSData (AXJsonAdd)

+ (NSData *(^)(id obj, NSData *def))autoData{
    return ^NSData *(id obj, NSData *def){
        NSData *data = self.safeData(obj, nil);
        if (data) {
            return data;
        } else if ([obj isKindOfClass:NSString.class]) {
            return [(NSString *)obj dataUsingEncoding:NSUTF8StringEncoding] ?: def;
        } else if ([obj isKindOfClass:NSArray.class]) {
            return ((NSArray *)obj).toJson().dataValue ?: def;
        } else if ([obj isKindOfClass:NSDictionary.class]) {
            return ((NSDictionary *)obj).toJson().dataValue ?: def;
        } else {
            return def;
        }
    };
}

- (AXResult *(^)(void))toJson{
    return ^{
        return self.toJsonWithOptions(NSJSONReadingMutableContainers);
    };
}

- (AXResult *(^)(NSJSONReadingOptions opt))toJsonWithOptions{
    return ^AXResult *(NSJSONReadingOptions opt){
        return [AXResult resultWithJsonReadingOptions:opt data:^NSData * _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return self;
        }];
    };
}

@end


@implementation NSArray (AXJsonAdd)

+ (NSArray *(^)(id obj, NSArray *def))autoArray{
    return ^NSArray *(id obj, NSArray *def){
        NSArray *arr = self.safeArray(obj, nil);
        if (arr) {
            return arr;
        } else if ([obj isKindOfClass:NSData.class]) {
            return ((NSData *)obj).toJson().arrayValue ?: def;
        } else if ([obj isKindOfClass:NSString.class]) {
            return ((NSString *)obj).toJson().arrayValue ?: def;
        } else if ([obj isKindOfClass:NSDictionary.class]) {
            return ((NSDictionary *)obj).toJson().arrayValue ?: def;
        } else {
            return def;
        }
    };
}

- (AXResult *(^)(void))toJson{
    return ^{
        return self.toJsonWithOptions(NSJSONWritingPrettyPrinted);
    };
}

- (AXResult *(^)(NSJSONWritingOptions opt))toJsonWithOptions{
    return ^AXResult *(NSJSONWritingOptions opt){
        return [AXResult resultWithJsonWritingOptions:opt object:^id _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return self;
        }];
    };
}

@end


@implementation NSDictionary (AXJsonAdd)

+ (NSDictionary *(^)(id obj, NSDictionary *def))autoDictionary{
    return ^NSDictionary *(id obj, NSDictionary *def){
        NSDictionary *dict = self.safeDictionary(obj, nil);
        if (dict) {
            return dict;
        } else if ([obj isKindOfClass:NSData.class]) {
            return ((NSData *)obj).toJson().dictionaryValue ?: def;
        } else if ([obj isKindOfClass:NSString.class]) {
            return ((NSString *)obj).toJson().dictionaryValue ?: def;
        } else if ([obj isKindOfClass:NSArray.class]) {
            return ((NSArray *)obj).toJson().dictionaryValue ?: def;
        } else {
            return def;
        }
    };
}

- (AXResult *(^)(void))toJson{
    return ^{
        return self.toJsonWithOptions(NSJSONWritingPrettyPrinted);
    };
}

- (AXResult *(^)(NSJSONWritingOptions opt))toJsonWithOptions{
    return ^AXResult *(NSJSONWritingOptions opt){
        return [AXResult resultWithJsonWritingOptions:opt object:^id _Nonnull(NSError * _Nullable __autoreleasing * _Nullable error) {
            return self;
        }];
    };
}

@end


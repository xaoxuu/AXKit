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

+ (NSString *(^)(id obj))parse{
    return ^NSString *(id obj){
        NSString *str = self.safe(obj);
        if (str) {
            return str;
        } else if ([obj isKindOfClass:NSData.class]) {
            return [[NSString alloc] initWithData:(NSData *)obj encoding:NSUTF8StringEncoding] ?: nil;
        } else if ([obj isKindOfClass:NSArray.class]) {
            return ((NSArray *)obj).toJson().stringValue ?: nil;
        } else if ([obj isKindOfClass:NSDictionary.class]) {
            return ((NSDictionary *)obj).toJson().stringValue ?: nil;
        } else {
            return nil;
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

+ (NSData *(^)(id obj))parse{
    return ^NSData *(id obj){
        NSData *data = self.safe(obj);
        if (data) {
            return data;
        } else if ([obj isKindOfClass:NSString.class]) {
            return [(NSString *)obj dataUsingEncoding:NSUTF8StringEncoding] ?: nil;
        } else if ([obj isKindOfClass:NSArray.class]) {
            return ((NSArray *)obj).toJson().dataValue ?: nil;
        } else if ([obj isKindOfClass:NSDictionary.class]) {
            return ((NSDictionary *)obj).toJson().dataValue ?: nil;
        } else {
            return nil;
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


@implementation NSArray (AXJsonAdd2)

+ (NSArray *(^)(id obj))parse{
    return ^NSArray *(id obj){
        NSArray *arr = self.safe(obj);
        if (arr) {
            return arr;
        } else if ([obj isKindOfClass:NSData.class]) {
            return ((NSData *)obj).toJson().arrayValue ?: nil;
        } else if ([obj isKindOfClass:NSString.class]) {
            return ((NSString *)obj).toJson().arrayValue ?: nil;
        } else if ([obj isKindOfClass:NSDictionary.class]) {
            return ((NSDictionary *)obj).toJson().arrayValue ?: nil;
        } else {
            return nil;
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

+ (NSDictionary *(^)(id obj))parse{
    return ^NSDictionary *(id obj){
        NSDictionary *dict = self.safe(obj);
        if (dict) {
            return dict;
        } else if ([obj isKindOfClass:NSData.class]) {
            return ((NSData *)obj).toJson().dictionaryValue ?: nil;
        } else if ([obj isKindOfClass:NSString.class]) {
            return ((NSString *)obj).toJson().dictionaryValue ?: nil;
        } else if ([obj isKindOfClass:NSArray.class]) {
            return ((NSArray *)obj).toJson().dictionaryValue ?: nil;
        } else {
            return nil;
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


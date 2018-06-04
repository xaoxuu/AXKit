//
//  NSObject+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 13/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "NSObject+AXExtension.h"
#import "NSString+AXExtension.h"
@import ObjectiveC.runtime;


inline NSDictionary *safeDictionary(id obj, NSDictionary *def){
    return [obj isKindOfClass:NSDictionary.class]?obj:def;
}
inline NSDictionary *autoDictionary(id obj, NSDictionary *def){
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

inline NSArray *safeArray(id obj, NSArray *def){
    return [obj isKindOfClass:NSArray.class]?obj:def;
}
inline NSArray *autoArray(id obj, NSArray *def){
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

inline NSString *safeString(id obj, NSString *def){
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
inline NSString *autoString(id obj, NSString *def){
    NSString *ret = safeString(obj, nil);
    if (!ret) {
        if ([obj isKindOfClass:NSNumber.class]) {
            return ((NSNumber *)obj).description;
        }
        return def;
    }
    return ret;
}

inline NSNumber *safeNumber(id obj, NSNumber *def){
    return [obj isKindOfClass:NSNumber.class]?obj:def;
}
inline NSNumber *autoNumber(id obj, NSNumber *def){
    NSNumber *ret = safeNumber(obj, nil);
    if (!ret) {
        if ([obj isKindOfClass:NSString.class]) {
            return ((NSString *)obj).numberValue;
        }
        return def;
    }
    return ret;
}


@implementation NSObject (AXExtension)

+ (NSArray *)ax_allSubclasses{
    NSMutableArray *subclasses = [NSMutableArray array];
    unsigned int numOfClasses;
    Class *classes = objc_copyClassList(&numOfClasses);
    for (unsigned int ci = 0; ci < numOfClasses; ci++) {
        Class superClass = classes[ci];
        do{
            superClass = class_getSuperclass(superClass);
        } while (superClass && superClass != self);
        
        if (superClass)
        {
            [subclasses addObject: classes[ci]];
        }
    }
    free(classes);
    return subclasses;
}

@end


@implementation NSString (AXJsonExt)
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


@implementation NSData (AXJsonExt)
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


@implementation NSArray (AXJsonExt)
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


@implementation NSDictionary (AXJsonExt)
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


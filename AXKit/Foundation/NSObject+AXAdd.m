//
//  NSObject+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 13/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "NSObject+AXAdd.h"
#import "NSString+AXAdd.h"

@import ObjectiveC.runtime;

static inline BOOL isNull(id obj){
    if (obj == nil || [obj isKindOfClass:NSNull.class]) {
        return YES;
    } else if ([obj isKindOfClass:NSString.class] && ((NSString *)obj).length <= 8) {
        static NSArray<NSString *> *nullArray = nil;
        if (!nullArray) {
            nullArray = @[@"<null>", @"(null)", @"null", @"<nil>", @"(nil)", @"nil", @"<nsnull>", @"(nsnull)", @"nsnull"];
        }
        if ([nullArray containsObject:((NSString *)obj).lowercaseString]) {
            return YES;
        }
    }
    return NO;
}

@implementation NSObject (AXAdd)

+ (NSArray *)ax_subclasses{
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


@implementation NSString (AXSafeAdd)

+ (NSString *(^)(id obj, NSString *def))safeString{
    return ^NSString *(id obj, NSString *def){
        if (isNull(obj)) {
            return def;
        } else if ([obj isKindOfClass:NSString.class]) {
            return obj;
        } else if ([obj isKindOfClass:NSNumber.class]) {
            return ((NSNumber *)obj).stringValue;
        } else {
            return def;
        }
    };
}

@end

@implementation NSNumber (AXSafeAdd)

+ (NSNumber *(^)(id obj, NSNumber *def))safeNumber{
    return ^NSNumber *(id obj, NSNumber *def){
        if (isNull(obj)) {
            return def;
        } else if ([obj isKindOfClass:NSNumber.class]) {
            return obj;
        } else if ([obj isKindOfClass:NSString.class]) {
            return ((NSString *)obj).numberValue;
        } else {
            return def;
        }
    };
}

@end

@implementation NSData (AXSafeAdd)

+ (NSData *(^)(id obj, NSData *def))safeData{
    return ^NSData *(id obj, NSData *def){
        if (isNull(obj)) {
            return def;
        } else if ([obj isKindOfClass:NSData.class]) {
            return obj;
        } else {
            return def;
        }
    };
}

@end


@implementation NSArray (AXSafeAdd)

+ (NSArray *(^)(id obj, NSArray *def))safeArray{
    return ^NSArray *(id obj, NSArray *def){
        if (isNull(obj)) {
            return def;
        } else if ([obj isKindOfClass:NSArray.class]) {
            return obj;
        } else {
            return def;
        }
    };
}

@end


@implementation NSDictionary (AXSafeAdd)

+ (NSDictionary *(^)(id obj, NSDictionary *def))safeDictionary{
    return ^NSDictionary *(id obj, NSDictionary *def){
        if (isNull(obj)) {
            return def;
        } else if ([obj isKindOfClass:NSDictionary.class]) {
            return obj;
        } else {
            return def;
        }
    };
}

@end


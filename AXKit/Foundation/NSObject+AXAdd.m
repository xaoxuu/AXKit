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

static inline BOOL isNullStr(id obj){
    if ([obj isKindOfClass:NSString.class] && ((NSString *)obj).length <= 8) {
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

static inline NSData *safeData(NSData *obj){
    if ([obj isKindOfClass:NSData.class]) {
        return obj;
    } else {
        if ([obj isKindOfClass:NSString.class]) {
            if (isNullStr(obj)) {
                return nil;
            } else {
                return [(NSString *)obj dataUsingEncoding:NSUTF8StringEncoding] ?: nil;
            }
        } else {
            return nil;
        }
    }
}

static inline NSString *safeString(NSString *obj){
    if ([obj isKindOfClass:NSString.class]) {
        if (isNullStr(obj)) {
            return nil;
        } else {
            return obj;
        }
    } else {
        if ([obj isKindOfClass:NSNumber.class]) {
            return ((NSNumber *)obj).stringValue;
        } else if ([obj isKindOfClass:NSData.class]) {
            return [[NSString alloc] initWithData:(NSData *)obj encoding:NSUTF8StringEncoding] ?: nil;
        } else {
            return nil;
        }
    }
}

static inline NSNumber *safeNumber(NSNumber *obj){
    if ([obj isKindOfClass:NSNumber.class]) {
        return obj;
    } else {
        if ([obj isKindOfClass:NSString.class]) {
            if (isNullStr(obj)) {
                return nil;
            } else {
                return ((NSString *)obj).numberValue;
            }
        } else {
            return nil;
        }
    }
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

+ (NSString *(^)(NSString *obj))safe{
    return ^NSString *(NSString *obj){
        return safeString(obj);
    };
}


@end

@implementation NSNumber (AXSafeAdd)

+ (NSNumber *(^)(NSNumber *obj))safe{
    return ^NSNumber *(NSNumber *obj){
        return safeNumber(obj);
    };
}

@end

@implementation NSData (AXSafeAdd)

+ (NSData *(^)(NSData *obj))safe{
    return ^NSData *(NSData *obj){
        return safeData(obj);
    };
}

@end


@implementation NSArray (AXSafeAdd)

+ (NSArray *(^)(NSArray *obj))safe{
    return ^NSArray *(NSArray *obj){
        if ([obj isKindOfClass:NSArray.class]) {
            return obj;
        } else {
            return nil;
        }
    };
}

@end


@implementation NSDictionary (AXSafeAdd)

+ (NSDictionary *(^)(NSDictionary *obj))safe{
    return ^NSDictionary *(NSDictionary *obj){
        if ([obj isKindOfClass:NSDictionary.class]) {
            return obj;
        } else {
            return nil;
        }
    };
}

@end


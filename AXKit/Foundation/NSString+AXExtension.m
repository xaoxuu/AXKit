//
//  NSString+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#import "NSString+AXExtension.h"


inline NSString *NSStringFromBool(BOOL x){
    return [NSNumber numberWithBool:x].stringValue;
}

inline NSString *NSStringFromFloat(float x){
    return [NSNumber numberWithFloat:x].stringValue;
}

inline NSString *NSStringFromCGFloat(CGFloat x){
    return [NSNumber numberWithDouble:x].stringValue;
}

inline NSString *NSStringFromInt(int x){
    return [NSNumber numberWithInt:x].stringValue;
}

inline NSString *NSStringFromNSInteger(NSInteger x){
    return [NSNumber numberWithInteger:x].stringValue;
}

inline NSString *NSStringFromNSUInteger(NSUInteger x){
    return [NSNumber numberWithUnsignedInteger:x].stringValue;
}



inline NSString *NSStringFromPointer(id x){
    return [NSString stringWithFormat:@"%p",x];
}

inline NSString *NSStringFromPercent(CGFloat x){
    x = AXMakeFloatInRange(x, AXFloatRangeMake(0, 1));
    NSNumber *num = [NSNumber numberWithFloat:x * 100];
    return [NSString stringWithFormat:@"%@%%",num];
}

inline NSString *NSStringFromNSStringFromASCIIValue(unsigned char ASCIIValue){
    return [NSString stringWithFormat:@"%c",ASCIIValue];
}

@implementation NSString (AXAppendExtension)

- (NSString *(^)(NSString *string))append{
    return ^(NSString *string){
        if (string.length) {
            return [self stringByAppendingString:string];;
        } else{
            return self;
        }
    };
}

- (NSString *(^)(NSInteger x))appendNSInteger{
    return ^(NSInteger x){
        return [self stringByAppendingString:NSStringFromNSInteger(x)];;
    };
}
- (NSString *(^)(NSUInteger x))appendNSUInteger{
    return ^(NSUInteger x){
        return [self stringByAppendingString:NSStringFromNSUInteger(x)];;
    };
}
- (NSString *(^)(CGFloat x))appendCGFloat{
    return ^(CGFloat x){
        return [self stringByAppendingString:NSStringFromCGFloat(x)];;
    };
}
- (NSString *(^)())appendReturn{
    return ^{
        return [self stringByAppendingString:@"\n"];;
    };
}

@end


@implementation NSString (AXExtension)

- (NSURL *)absoluteURL{
    return [NSURL URLWithString:self].absoluteURL;
}

- (BOOL)isURLString{
    if ([self containsString:@"http://"] || [self containsString:@"https://"]) {
        return YES;
    } else {
        return NO;
    }
}

- (nullable UIImage *)image{
    return [UIImage imageNamed:self];
}

@end

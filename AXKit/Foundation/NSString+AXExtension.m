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

inline NSString *NSStringFromRandom(AXRandomStringType type, AXUIntegerRange length){
    switch (type) {
        case AXRandomName: {
            return [NSString ax_stringWithRandomNameWithLength:length];
            break;
        }
        case AXRandomPassword: {
            return [NSString ax_stringWithRandomPasswordWithLength:length];
            break;
        }
        case AXRandomLowerString: {
            return [NSString ax_stringWithRandomLowerStringWithLength:length];
            break;
        }
        case AXRandomUpperString: {
            return [NSString ax_stringWithRandomUpperStringWithLength:length];
            break;
        }
        case AXRandomCapitalizeString: {
            return [NSString ax_stringWithRandomCapitalizeStringWithLength:length];
            break;
        }
    }
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


@implementation NSString (AXRandomExtension)


+ (NSString *)ax_stringWithRandomLowerStringWithLength:(AXUIntegerRange)length{
    NSUInteger randomLength = AXRandomUIntegerFrom(length);
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<randomLength; i++) {
        [str appendFormat:@"%c",97 + arc4random_uniform(26)];
    }
    return str;
}

+ (NSString *)ax_stringWithRandomUpperStringWithLength:(AXUIntegerRange)length{
    NSUInteger randomLength = AXRandomUIntegerFrom(length);
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<randomLength; i++) {
        [str appendFormat:@"%c",65 + arc4random_uniform(26)];
    }
    return str;
}

+ (NSString *)ax_stringWithRandomCapitalizeStringWithLength:(AXUIntegerRange)length{
    NSUInteger randomLength = AXRandomUIntegerFrom(length);
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"%c",65 + arc4random_uniform(26)];
    for (NSUInteger i=0; i<randomLength-1; i++) {
        [str appendFormat:@"%c",97 + arc4random_uniform(26)];
    }
    return str;
}

+ (NSString *)ax_stringWithRandomNameWithLength:(AXUIntegerRange)length{
    // first name
    NSUInteger randomLength = AXRandomUIntegerFrom(length);
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"%c",65 + arc4random_uniform(26)];
    for (NSUInteger i=0; i<randomLength-1; i++) {
        [str appendFormat:@"%c",97 + arc4random_uniform(26)];
    }
    
    [str appendString:@" "];
    
    // last name
    randomLength = length.minValue + (NSUInteger)arc4random_uniform((int)length.maxValue-(int)length.minValue);
    [str appendFormat:@"%c",65 + arc4random_uniform(26)];
    for (NSUInteger i=0; i<randomLength-1; i++) {
        [str appendFormat:@"%c",97 + arc4random_uniform(26)];
    }
    return str;
}

+ (NSString *)ax_stringWithRandomPasswordWithLength:(AXUIntegerRange)length{
    // first name
    NSUInteger randomLength = AXRandomUIntegerFrom(length);
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<randomLength; i++) {
        [str appendFormat:@"%c",32 + arc4random_uniform(95)];
    }
    return str;
}

@end

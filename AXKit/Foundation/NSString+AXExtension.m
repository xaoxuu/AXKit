//
//  NSString+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#import "NSString+AXExtension.h"


NSString *NSStringFromInt32(int x){
    return [NSString stringWithFormat:@"%d",x];
}

NSString *NSStringFromNSInteger(NSInteger x){
    return [NSString stringWithFormat:@"%ld",(long)x];
}

NSString *NSStringFromNSUInteger(NSUInteger x){
    return [NSString stringWithFormat:@"%ld",(unsigned long)x];
}

NSString *NSStringFromCGFloat(CGFloat x){
    return [NSString stringWithFormat:@"%lf",x];
}

NSString *NSStringFromPointer(id x){
    return [NSString stringWithFormat:@"%p",x];
}


NSString *NSStringFromRandom(AXRandomStringType type, AXUIntegerRange length){
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

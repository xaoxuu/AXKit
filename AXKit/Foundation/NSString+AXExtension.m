//
//  NSString+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#import "NSString+AXExtension.h"
#import "NSError+AXExtension.h"
#import "_AXKitHelpServices.h"

inline NSString *NSStringFromBool(BOOL x){
    return @(x).stringValue;
}

inline NSString *NSStringFromFloat(float x){
    return @(x).stringValue;
}

inline NSString *NSStringFromCGFloat(CGFloat x){
    return @(x).stringValue;
}

inline NSString *NSStringFromInt(int x){
    return @(x).stringValue;
}

inline NSString *NSStringFromNSInteger(NSInteger x){
    return @(x).stringValue;
}

inline NSString *NSStringFromNSUInteger(NSUInteger x){
    return @(x).stringValue;
}



inline NSString *NSStringFromPointer(id x){
    return [NSString stringWithFormat:@"%p",x];
}

inline NSString *NSStringFromPercent(CGFloat x){
    x = AXMakeNumberInRange(@(x), @0, @1).doubleValue;
    return [NSString stringWithFormat:@"%@%%",@(100 * x)];
}

inline NSString *NSStringFromNSStringFromASCIIValue(unsigned char ASCIIValue){
    return [NSString stringWithFormat:@"%c",ASCIIValue];
}




inline void VersionLaterThanVersion(NSString *thisVersion, NSString *anotherVersion, void (^completion)(BOOL later), void (^failure)(NSError *error)){
    if (!completion) {
        return;
    }
    NSArray<NSString *> *thisVersionArr = [thisVersion componentsSeparatedByString:@"."];
    NSArray<NSString *> *anotherVersionArr = [anotherVersion componentsSeparatedByString:@"."];
    NSUInteger maxCount = MAX(thisVersionArr.count, anotherVersionArr.count);
    
    if (!thisVersionArr.count || !anotherVersionArr.count) {
        if (failure) {
            NSError *error = [NSError axkit_errorWithCode:0 reason:^NSString * _Nonnull{
                return @"invalid version string.";
            }];
            failure(error);
        }
        return;
    }
    
    for (NSUInteger i = 0; i < maxCount; i++) {
        NSInteger this = i<thisVersionArr.count ? thisVersionArr[i].integerValue : 0;
        NSInteger another = i<anotherVersionArr.count ? anotherVersionArr[i].integerValue : 0;
        if (this > another) {
            completion(YES);
            return;
        } else if (this < another) {
            completion(NO);
            return;
        }
    }
    completion(NO);
}


inline NSString *SpellForChinese(NSString *chinese){
    NSMutableString *pinyin = [NSMutableString stringWithString:chinese];
    // 将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    // 去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
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
- (NSString *(^)(void))appendReturn{
    return ^{
        return [self stringByAppendingString:@"\n"];;
    };
}

- (NSString *(^)(NSString *string))prefix{
    return ^(NSString *string){
        if (string.length) {
            return [string stringByAppendingString:self];;
        } else{
            return self;
        }
    };
}

@end

@interface NSVersionString ()

@end

@implementation NSVersionString : NSString

+ (instancetype)versionStringFromString:(NSString *)string{
    return [[self alloc] initWithString:string];
}

- (instancetype)initWithString:(NSString *)string{
    if (self = [super initWithString:string]) {
        NSArray<NSString *> *components = [string componentsSeparatedByString:@"."];
        [components enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                _majorVersionNumber = obj.integerValue;
            } else if (idx == 1) {
                _minorVersionNumber = obj.integerValue;
            } else if (idx == 2) {
                _revisionVersionNumber = obj.integerValue;
            }
        }];
    }
    return self;
}


- (NSVersionString *)laterVersion:(NSVersionString *)version{
    if (self.majorVersionNumber > version.majorVersionNumber) {
        return self;
    } else if (self.majorVersionNumber < version.majorVersionNumber) {
        return version;
    } else {
        if (self.minorVersionNumber > version.minorVersionNumber) {
            return self;
        } else if (self.minorVersionNumber < version.minorVersionNumber) {
            return version;
        } else {
            if (self.revisionVersionNumber > version.revisionVersionNumber) {
                return self;
            } else if (self.revisionVersionNumber < version.revisionVersionNumber) {
                return version;
            } else {
                return self;
            }
        }
    }
}

@end

@implementation NSString (AXExtension)

- (nullable NSURL *)absoluteURL{
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


- (CGFloat)ax_textHeightWithFont:(UIFont *)font width:(CGFloat)width{
    NSDictionary *dict = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil].size.height;
}

- (NSString *)laterVersion:(NSString *)version{
    NSVersionString *current = [NSVersionString versionStringFromString:self];
    NSVersionString *target = [NSVersionString versionStringFromString:version];
    return [current laterVersion:target];
}

@end




#pragma mark - 随机字符串


inline NSString *AXRandomStringFrom(RandomStringType type, AXUIntegerRange length){
    switch (type) {
        case RandomStringTypeName: {
            return [NSString ax_stringWithRandomNameWithLength:length];
            break;
        }
        case RandomStringTypePassword: {
            return [NSString ax_stringWithRandomPasswordWithLength:length];
            break;
        }
        case RandomStringTypeLower: {
            return [NSString ax_stringWithRandomLowerStringWithLength:length];
            break;
        }
        case RandomStringTypeUpper: {
            return [NSString ax_stringWithRandomUpperStringWithLength:length];
            break;
        }
        case RandomStringTypeCapitalize: {
            return [NSString ax_stringWithRandomCapitalizeStringWithLength:length];
            break;
        }
    }
}


/**
 产生指定位数的随机二进制数
 
 @param length 随机数的位数（字符串的长度）
 @return 随机数字
 */
inline NSString *AXRandomBinStringWithLength(NSUInteger length){
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<length; i++) {
        [str appendFormat:@"%c",48 + arc4random_uniform(2)];
    }
    return str;
}


/**
 产生指定位数的随机八进制数
 
 @param length 随机数的位数（字符串的长度）
 @return 随机数字
 */
inline NSString *AXRandomOctStringWithLength(NSUInteger length){
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<length; i++) {
        [str appendFormat:@"%c",48 + arc4random_uniform(8)];
    }
    return str;
}

/**
 产生指定位数的随机十进制数
 
 @param length 随机数的位数（字符串的长度）
 @return 随机数字
 */
inline NSString *AXRandomDecStringWithLength(NSUInteger length){
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<length; i++) {
        [str appendFormat:@"%c",48 + arc4random_uniform(10)];
    }
    return str;
}


/**
 产生指定位数的随机十六进制数
 
 @param length 随机数的位数（字符串的长度）
 @return 随机数字
 */
inline NSString *AXRandomHexStringWithLength(NSUInteger length){
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<length; i++) {
        int x = arc4random_uniform(16);
        if (x > 9) {
            x += 7;
        }
        char xChar = x + 48;
        [str appendFormat:@"%c",xChar];
    }
    return str;
}




@implementation NSString (AXRandomExtension)



+ (NSString *)ax_stringWithRandomLowerStringWithLength:(AXUIntegerRange)length{
    NSUInteger randomLength = AXRandomIntegerInRange(length.minValue, length.maxValue);
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<randomLength; i++) {
        [str appendFormat:@"%c",97 + arc4random_uniform(26)];
    }
    return str;
}

+ (NSString *)ax_stringWithRandomUpperStringWithLength:(AXUIntegerRange)length{
    NSUInteger randomLength = AXRandomIntegerInRange(length.minValue, length.maxValue);
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<randomLength; i++) {
        [str appendFormat:@"%c",65 + arc4random_uniform(26)];
    }
    return str;
}

+ (NSString *)ax_stringWithRandomCapitalizeStringWithLength:(AXUIntegerRange)length{
    NSUInteger randomLength = AXRandomIntegerInRange(length.minValue, length.maxValue);
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"%c",65 + arc4random_uniform(26)];
    for (NSUInteger i=0; i<randomLength-1; i++) {
        [str appendFormat:@"%c",97 + arc4random_uniform(26)];
    }
    return str;
}

+ (NSString *)ax_stringWithRandomNameWithLength:(AXUIntegerRange)length{
    // first name
    NSUInteger randomLength = AXRandomIntegerInRange(length.minValue, length.maxValue);
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
    NSUInteger randomLength = AXRandomIntegerInRange(length.minValue, length.maxValue);
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<randomLength; i++) {
        [str appendFormat:@"%c",32 + arc4random_uniform(95)];
    }
    return str;
}

@end






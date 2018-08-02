//
//  NSString+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#import "NSString+AXAdd.h"
#import "NSError+AXAdd.h"
#import "_AXKitError.h"
#import "NSObject+AXJsonAdd.h"
#import "CoreGraphics+AXAdd.h"

static inline CGSize boundingSize(NSString *str, UIFont *font, CGSize size, NSLineBreakMode lineBreakMode){
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([str respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [str boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [str sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}


/**
 产生指定位数的随机二进制数
 
 @param length 随机数的位数（字符串的长度）
 @return 随机数字
 */
static inline NSString *randomBin(NSUInteger length){
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
static inline NSString *randomOct(NSUInteger length){
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
static inline NSString *randomDec(NSUInteger length){
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
static inline NSString *randomHex(NSUInteger length){
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

static inline NSString *randomLowerString(NSUInteger min, NSUInteger max){
    NSUInteger randomLength = AXRandomIntegerInRange(min, max);
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<randomLength; i++) {
        [str appendFormat:@"%c",97 + arc4random_uniform(26)];
    }
    return str;
}
static inline NSString *randomUpperString(NSUInteger min, NSUInteger max){
    NSUInteger randomLength = AXRandomIntegerInRange(min, max);
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i=0; i<randomLength; i++) {
        [str appendFormat:@"%c",65 + arc4random_uniform(26)];
    }
    return str;
}

@implementation NSString (AXAdd)

- (BOOL)isURLString{
    if ([self containsString:@"http"] && [self containsString:@"://"]) {
        return YES;
    } else {
        return NO;
    }
}

- (CGSize)boundingSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    return boundingSize(self, font, maxSize, NSLineBreakByWordWrapping);
}

- (CGFloat)boundingHeightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    return boundingSize(self, font, CGSizeMake(maxWidth, MAXFLOAT), NSLineBreakByWordWrapping).height;
}

- (nullable NSNumber *)numberValue{
    NSString *lower = NSString.safeString(self, nil).lowercaseString;
    if (!lower.length) {
        return nil;
    }
    static NSCharacterSet *dot;
    if (!dot) {
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
    }
    if ([lower isEqualToString:@"true"] || [lower isEqualToString:@"yes"]) {
        return @(YES);
    } else if ([lower isEqualToString:@"false"] || [lower isEqualToString:@"no"]) {
        return @(NO);
    } else if ([self rangeOfCharacterFromSet:dot].location != NSNotFound) {
        return @(self.doubleValue);
    } else {
        return @(self.longLongValue);
    }
    
}

+ (NSString *(^)(NSString *))spellForChinese{
    return ^NSString *(NSString *chinese){
        NSMutableString *pinyin = [NSMutableString stringWithString:chinese];
        // 将汉字转换为拼音(带音标)
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
        // 去掉拼音的音标
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
        return pinyin;
    };
}

+ (NSString * _Nonnull (^)(id _Nonnull))pointerDescription{
    return ^NSString *(id x){
        return [NSString stringWithFormat:@"%p",x];
    };
}

// MARK: - 拼接

- (NSString *(^)(NSString *string))append{
    return ^(NSString *string){
        if (string.length) {
            return [self stringByAppendingString:string];;
        } else{
            return self;
        }
    };
}

- (NSString *(^)(NSNumber *number))appendNumber{
    return ^(NSNumber *number){
        return [self stringByAppendingString:number.stringValue];
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

// MARK: - 随机

+ (NSString * _Nonnull (^)(NSUInteger))randomBin{
    return ^NSString *(NSUInteger length){
        return randomBin(length);
    };
}

+ (NSString * _Nonnull (^)(NSUInteger))randomOct{
    return ^NSString *(NSUInteger length){
        return randomOct(length);
    };
}
+ (NSString * _Nonnull (^)(NSUInteger))randomDec{
    return ^NSString *(NSUInteger length){
        return randomDec(length);
    };
}
+ (NSString * _Nonnull (^)(NSUInteger))randomHex{
    return ^NSString *(NSUInteger length){
        return randomHex(length);
    };
}


+ (NSString * _Nonnull (^)(NSUInteger, NSUInteger))randomName{
    return ^NSString *(NSUInteger min, NSUInteger max){
        // first name
        NSMutableString *str = [NSMutableString string];
        [str appendString:self.randomLowerString(min, max).capitalizedString];
        [str appendString:@" "];
        [str appendString:self.randomLowerString(min, max).capitalizedString];
        return str;
    };
}

+ (NSString * _Nonnull (^)(NSUInteger, NSUInteger))randomPassword{
    return ^NSString *(NSUInteger min, NSUInteger max){
        NSUInteger randomLength = AXRandomIntegerInRange(min, max);
        NSMutableString *str = [NSMutableString string];
        for (NSUInteger i=0; i<randomLength; i++) {
            [str appendFormat:@"%c",32 + arc4random_uniform(95)];
        }
        return str;
    };
}

+ (NSString * _Nonnull (^)(NSUInteger, NSUInteger))randomLowerString{
    return ^NSString *(NSUInteger min, NSUInteger max){
        return randomLowerString(min, max);
    };
}

+ (NSString * _Nonnull (^)(NSUInteger, NSUInteger))randomUpperString{
    return ^NSString *(NSUInteger min, NSUInteger max){
        return randomUpperString(min, max);
    };
}

+ (NSString * _Nonnull (^)(NSUInteger, NSUInteger))randomCapitalizedString{
    return ^NSString *(NSUInteger min, NSUInteger max){
        return self.randomLowerString(min, max).capitalizedString;
    };
}

@end






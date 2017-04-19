//
//  NSString+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Foundation+CoreGraphics.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - get a string from ...


FOUNDATION_EXTERN NSString *NSStringFromInt32(int x);


FOUNDATION_EXTERN NSString *NSStringFromNSInteger(NSInteger x);


FOUNDATION_EXTERN NSString *NSStringFromNSUInteger(NSUInteger x);


FOUNDATION_EXTERN NSString *NSStringFromCGFloat(CGFloat x);


FOUNDATION_EXTERN NSString *NSStringFromPointer(id x);

typedef NS_ENUM(NSUInteger, AXRandomStringType){
    AXRandomName,
    AXRandomPassword,
    
    AXRandomLowerString,
    AXRandomUpperString,
    AXRandomCapitalizeString,
};


FOUNDATION_EXTERN NSString *NSStringFromRandom(AXRandomStringType type, AXUIntegerRange length);


@interface NSString (AXAppendExtension)

/**
 拼接字符串
 */
- (NSString *(^)(NSString *string))append;

/**
 拼接NSInteger
 */
- (NSString *(^)(NSInteger x))appendNSInteger;

/**
 拼接NSUInteger
 */
- (NSString *(^)(NSUInteger x))appendNSUInteger;

/**
 拼接CGFloat
 */
- (NSString *(^)(CGFloat x))appendCGFloat;

/**
 拼接换行符
 */
- (NSString *(^)())appendReturn;


@end


@interface NSString (AXRandomExtension)


/**
 产生指定长度的随机字符串（适用于用户名）

 @param length 长度范围（最小长度，最大长度）
 @return 随机字符串
 */
+ (NSString *)ax_stringWithRandomNameWithLength:(AXUIntegerRange)length;


/**
 产生指定长度的随机字符串（适用于密码）

 @param length 长度范围（最小长度，最大长度）
 @return 随机字符串
 */
+ (NSString *)ax_stringWithRandomPasswordWithLength:(AXUIntegerRange)length;


/**
 产生指定长度的随机字符串（纯小写）
 
 @param length 长度范围（最小长度，最大长度）
 @return 随机字符串
 */
+ (NSString *)ax_stringWithRandomLowerStringWithLength:(AXUIntegerRange)length;

/**
 产生指定长度的随机字符串（纯大写）
 
 @param length 长度范围（最小长度，最大长度）
 @return 随机字符串
 */
+ (NSString *)ax_stringWithRandomUpperStringWithLength:(AXUIntegerRange)length;

/**
 产生指定长度的随机字符串（首字母大写）
 
 @param length 长度范围（最小长度，最大长度）
 @return 随机字符串
 */
+ (NSString *)ax_stringWithRandomCapitalizeStringWithLength:(AXUIntegerRange)length;

@end


NS_ASSUME_NONNULL_END



//
//  Foundation+AXRandomExtension.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foundation+AXRangeExtension.h"



#pragma mark - 随机值

/**
 产生一个随机CGFloat
 
 @param range CGFloat取值范围
 @return 随机的CGFloat
 */
CG_EXTERN CGFloat AXRandomFloatFrom(AXFloatRange range);

/**
 产生一个随机NSInteger
 
 @param range NSInteger取值范围
 @return 随机的NSInteger
 */
CG_EXTERN NSInteger AXRandomIntegerFrom(AXIntegerRange range);

/**
 产生一个随机NSUInteger
 
 @param range NSUInteger取值范围
 @return 随机的NSUInteger
 */
CG_EXTERN NSUInteger AXRandomUIntegerFrom(AXUIntegerRange range);



#pragma mark - 随机字符串
#pragma mark 类型定义

typedef NS_ENUM(NSUInteger, RandomStringType){
    RandomStringTypeName,
    RandomStringTypePassword,
    
    RandomStringTypeLower,
    RandomStringTypeUpper,
    RandomStringTypeCapitalize,
};



/**
 产生随机字符串
 
 @param type 随机类型
 @param length 长度范围
 @return 字符串
 */
FOUNDATION_EXTERN NSString *AXRandomStringFrom(RandomStringType type, AXUIntegerRange length);


/**
 产生指定位数的随机二进制数
 
 @param length 随机数的位数（字符串的长度）
 @return 随机数字
 */
FOUNDATION_EXTERN NSString *AXRandomBinStringWithLength(NSUInteger length);


/**
 产生指定位数的随机八进制数
 
 @param length 随机数的位数（字符串的长度）
 @return 随机数字
 */
FOUNDATION_EXTERN NSString *AXRandomOctStringWithLength(NSUInteger length);

/**
 产生指定位数的随机十进制数
 
 @param length 随机数的位数（字符串的长度）
 @return 随机数字
 */
FOUNDATION_EXTERN NSString *AXRandomDecStringWithLength(NSUInteger length);


/**
 产生指定位数的随机十六进制数
 
 @param length 随机数的位数（字符串的长度）
 @return 随机数字
 */
FOUNDATION_EXTERN NSString *AXRandomHexStringWithLength(NSUInteger length);



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


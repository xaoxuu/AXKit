//
//  NSString+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreGraphics+AXExtension.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - get a string from ...

/**
 BOOL转字符串(0/1)
 
 @param x BOOL类型
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromBool(BOOL x);

/**
 CGFloat转字符串
 
 @param x CGFloat
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromFloat(float x);

/**
 CGFloat转字符串
 
 @param x CGFloat
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromCGFloat(CGFloat x);


/**
 int转字符串
 
 @param x int
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromInt(int x);

/**
 NSInteger转字符串
 
 @param x NSInteger
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromNSInteger(NSInteger x);

/**
 NSUInteger转字符串
 
 @param x NSUInteger
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromNSUInteger(NSUInteger x);



/**
 输出指针地址

 @param x id指针
 @return id指针的地址
 */
CG_EXTERN NSString *NSStringFromPointer(id x);

/**
 输出百分比

 @param x 0~1
 @return 0% ~ 100%
 */
FOUNDATION_EXTERN NSString *NSStringFromPercent(CGFloat x);



/**
 ASCIIValue转字符串
 
 @param ASCIIValue ASCII值
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromASCIIValue(unsigned char ASCIIValue);




FOUNDATION_EXTERN void VersionLaterThanVersion(NSString *thisVersion, NSString *anotherVersion, void (^completion)(BOOL later), void (^ _Nullable failure)(NSError *error));


/**
 汉字转拼音

 @param chinese 汉字
 @return 拼音
 */
FOUNDATION_EXTERN NSString *SpellForChinese(NSString *chinese);



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

/**
 添加前缀（在前面拼接字符串）
 */
- (NSString *(^)(NSString *string))prefix;


@end


@interface NSString (AXExtension)


/**
 以当前字符串为路径的URL

 @return 以当前字符串为路径的URL
 */
- (nullable NSURL *)absoluteURL;

/**
 是不是URL字符串

 @return 是不是URL字符串
 */
- (BOOL)isURLString;


/**
 以当前字符串为名的图片

 @return 图片
 */
- (nullable UIImage *)image;


/**
 文本在指定字体、宽度时候需要的高度

 @param font 字体
 @param width 文本框宽度
 @return 文本框高度
 */
- (CGFloat)ax_textHeightWithFont:(UIFont *)font width:(CGFloat)width;


@end



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



NS_ASSUME_NONNULL_END



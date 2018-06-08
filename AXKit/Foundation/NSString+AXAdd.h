//
//  NSString+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreGraphics+AXAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AXAdd)

/**
 是不是URL字符串

 @return 是不是URL字符串
 */
- (BOOL)isURLString;

/**
 isEqualToString:
 */
- (BOOL (^)(NSString *str))isEqualToString;


/**
 受约束的尺寸，文本使用指定的字体、在size中实际布局所需要的size
 */
- (CGSize (^)(UIFont *font, CGSize size))boundingSize;

/**
 受约束的尺寸，文本使用指定的字体、在指定的宽度中实际布局所需要的高度
 */
- (CGFloat (^)(UIFont *font, CGFloat width))boundingHeight;

/**
 转数字

 @return 数字
 */
- (NSNumber *)numberValue;

/**
 汉语转拼音
 */
+ (NSString *(^)(NSString *))spellForChinese;

/**
 指针转字符串
 */
+ (NSString *(^)(id))pointerDescription;

// MARK: - 拼接

/**
 拼接字符串
 */
- (NSString *(^)(NSString *string))append;

/**
 拼接数字
 */
- (NSString *(^)(NSNumber *number))appendNumber;

/**
 拼接换行符
 */
- (NSString *(^)(void))appendReturn;

/**
 添加前缀（在前面拼接字符串）
 */
- (NSString *(^)(NSString *string))prefix;

// MARK: - 随机

/**
 产生指定位数的随机二进制数
 */
+ (NSString *(^)(NSUInteger))randomBin;

/**
 产生指定位数的随机八进制数
 */
+ (NSString *(^)(NSUInteger))randomOct;

/**
 产生指定位数的随机十进制数
 */
+ (NSString *(^)(NSUInteger))randomDec;

/**
 产生指定位数的随机十六进制数
 */
+ (NSString *(^)(NSUInteger))randomHex;

/**
 产生指定长度的随机字符串（适用于用户名）
 length 长度范围（最小长度，最大长度）
 @return 随机字符串
 */
+ (NSString *(^)(NSUInteger min, NSUInteger max))randomName;

/**
 产生指定长度的随机字符串（适用于密码）
 length 长度范围（最小长度，最大长度）
 @return 随机字符串
 */
+ (NSString *(^)(NSUInteger min, NSUInteger max))randomPassword;

/**
 产生指定长度的随机字符串（纯小写）
 length 长度范围（最小长度，最大长度）
 @return 随机字符串
 */
+ (NSString *(^)(NSUInteger min, NSUInteger max))randomLowerString;

/**
 产生指定长度的随机字符串（纯大写）
 length 长度范围（最小长度，最大长度）
 @return 随机字符串
 */
+ (NSString *(^)(NSUInteger min, NSUInteger max))randomUpperString;

/**
 产生指定长度的随机字符串（首字母大写）
 length 长度范围（最小长度，最大长度）
 @return 随机字符串
 */
+ (NSString *(^)(NSUInteger min, NSUInteger max))randomCapitalizedString;

@end

NS_ASSUME_NONNULL_END

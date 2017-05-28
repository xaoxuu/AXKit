//
//  NSString+AXFileStreamChainedWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AXFileStreamChainedWrapper)

#pragma mark read

/**
 读取一个数组或可变数组(自动追加.plist)

 @return 数组
 */
- (nullable __kindof NSArray *)readArray;

/**
 读取一个字典或可变字典(自动追加.plist)

 @return 字典
 */
- (nullable __kindof NSDictionary *)readDictionary;

/**
 解档一个已归档的plist文件(自动追加.plist)

 @return 一个已归档的plist文件
 */
- (nullable id)readArchivedPlist;

/**
 读取一个json文件(自动追加.json)

 @return 数组或字典
 */
- (nullable id)readJson;

/**
 读取一个纯文本文件(自动追加.txt)

 @return txt文件
 */
- (nullable NSString *)readTxt;

/*!
 *	@author Aesir Titan
 *
 *	@brief read file
 *  解档一个已归档的文件
 *
 *	@return a file
 */
- (nullable id)readArchivedFile;

- (nullable id)readArchivedObject;

#pragma mark - save

/**
 保存一个plist文件（自动追加.plist）
 
 @return 成功与否
 */
- (BOOL(^)(id))savePlist;

/**
 归档一个实现NSCoding协议的plist文件（自动追加.plist）
 
 @return 成功与否
 */
- (BOOL(^)(NSObject<NSCoding> *))saveArchivedPlist;

/**
 归档一个实现NSCoding协议的文件
 
 @return 成功与否
 */
- (BOOL(^)(NSObject<NSCoding> *))saveArchivedObject;

/**
 归档一个文件
 
 @return 成功与否
 */
- (BOOL(^)(id <NSCoding>))save;

#pragma mark - remove


/**
 删除一个plist文件（自动追加.plist）

 @return 成功与否
 */
- (BOOL)removePlist;


/**
 删除一个json文件（自动追加.json）

 @return 成功与否
 */
- (BOOL)removeJson;


/**
 删除一个txt文件（自动追加.txt）

 @return 成功与否
 */
- (BOOL)removeTxt;


/**
 删除一个文件

 @return 成功与否
 */
- (BOOL)remove;

#pragma mark path

/**
 ‘self’在mainBundle中的完整路径

 @return ‘self’在mainBundle中的完整路径
 */
- (nullable NSString *)mainBundlePath;

/**
 ‘self’在documents中的完整路径

 @return ‘self’在documents中的完整路径
 */
- (NSString *)docPath;


/**
 ‘self’在cache中的完整路径

 @return ‘self’在cache中的完整路径
 */
- (NSString *)cachePath;


/**
 ‘self’在tmp中的完整路径

 @return ‘self’在tmp中的完整路径
 */
- (NSString *)tempPath;


/**
 ‘self’在NSSearchPathDirectory中的完整路径
 
 @return ‘self’在NSSearchPathDirectory中的完整路径
 */
- (NSString *(^)(NSSearchPathDirectory))path;

#pragma mark - extension


/**
 追加一个扩展名
 */
- (NSString *(^)(NSString *))extension;


/**
 追加.plist

 @return 追加.plist后的路径
 */
- (NSString *)plist;


/**
 追加.json

 @return 追加.json后的路径
 */
- (NSString *)json;



/**
 追加.txt

 @return 追加.txt后的路径
 */
- (NSString *)txt;

#pragma mark - subpath


/**
 ‘self’路径下的所有文件路径
 */
- (nullable NSArray<NSString *> *(^)(NSString *__nullable))subpaths;


@end

NS_ASSUME_NONNULL_END


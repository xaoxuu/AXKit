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
- (nullable __kindof NSArray *(^)(void))readArray;

/**
 读取一个字典或可变字典(自动追加.plist)

 @return 字典
 */
- (nullable __kindof NSDictionary *(^)(void))readDictionary;

/**
 读取一个json文件(自动追加.json)

 @return 数组或字典
 */
- (nullable id (^)(void))readJson;

/**
 读取一个纯文本文件(自动追加.txt)

 @return txt文件
 */
- (nullable NSString *(^)(void))readTxt;

/**
 解档一个已归档的文件
 
 @return 文件
 */
- (nullable id (^)(void))readArchivedFile;

#pragma mark - save

/**
 保存一个文件
 
 @return 成功与否
 */
- (BOOL(^)(id))saveFile;

/**
 归档一个实现NSCoding协议的文件
 
 @return 成功与否
 */
- (BOOL(^)(NSObject<NSCoding> *))saveArchivedFile;

/**
 拼接文本到沙盒文件
 
 @return 成功与否
 */
- (BOOL (^)(NSString *))saveStringByAppendingToEndOfFile;


#pragma mark - remove

/**
 删除一个文件

 @return 成功与否
 */
- (BOOL (^)(void))removeFile;

#pragma mark - path

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
- (NSString *)tmpPath;

/**
 ‘self’在NSSearchPathDirectory中的完整路径
 
 @return ‘self’在NSSearchPathDirectory中的完整路径
 */
- (NSString *(^)(NSSearchPathDirectory))path;

/**
 ‘self’路径下的所有文件路径
 */
- (nullable NSArray<NSString *> *(^)(NSString *__nullable))subpaths;

/**
 追加一个扩展名
 */
- (NSString *(^)(NSString *))extension;

/**
 路径
 */
- (NSString *(^)(NSString *))appendPathComponent;

/**
 创建路径是否存在
 
 @return 创建路径是否存在
 */
- (BOOL (^)(void))isDirectoryExist;

/**
 如果不存在创建路径
 
 @return 路径
 */
- (BOOL (^)(void))createDirectory;


@end

NS_ASSUME_NONNULL_END


//
//  FMDatabase+AXAdd.h
//  SmartWatch
//
//  Created by xaoxuu on 05/09/2017.
//  Copyright © 2017 Hinteen. All rights reserved.
//

#import <FMDB/FMDB.h>
NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN FMDatabaseQueue *databaseQueue(void);

FOUNDATION_EXTERN void databaseTransaction(void (^block)(FMDatabase *db, BOOL *rollback));

FOUNDATION_EXTERN void databaseDeferredTransaction(void (^block)(FMDatabase *db, BOOL *rollback));

@interface FMDatabase (AXExtension)

#pragma mark fmdb直接封装


/**
 所有更新数据库类的操作（对FMDB的直接封装）
 
 update sql增、删、改语句
 */
- (BOOL (^)(NSString *update))executeUpdate;

/**
 所有查询类的操作（对FMDB的直接封装）
 
 query sql查询语句
 @return 查询结果
 */
- (FMResultSet * _Nullable (^)(NSString *query))executeQuery;

#pragma mark select

/**
 查询（from where orderby）

 @param select 查询的列（*代表全部）
 @param from 从哪个表查询
 @param where 筛选条件
 @param orderBy 排序
 @param result 查询结果
 @return 查询结果
 */
- (NSMutableArray *)ax_select:(NSString *)select from:(NSString *)from where:(nullable NSString *)where orderBy:(nullable NSString *)orderBy result:(void (^)(NSMutableArray *result, FMResultSet *set))result;
/**
 查询（from where）
 
 @param select 查询的列（*代表全部）
 @param from 从哪个表查询
 @param where 筛选条件
 @param result 查询结果
 @return 查询结果
 */
- (NSMutableArray *)ax_select:(NSString *)select from:(NSString *)from where:(nullable NSString *)where result:(void (^)(NSMutableArray *result, FMResultSet *set))result;
/**
 查询（from）
 
 @param select 查询的列（*代表全部）
 @param from 从哪个表查询
 @param result 查询结果
 @return 查询结果
 */
- (NSMutableArray *)ax_select:(NSString *)select from:(NSString *)from result:(void (^)(NSMutableArray *result, FMResultSet *set))result;


#pragma mark create

/**
 创建表
 
 @param table 表名
 @param column 列名
 @param primaryKey 主键
 */
- (void)ax_createTable:(NSString *)table column:(NSString *)column primaryKey:(nullable NSString *)primaryKey;



#pragma mark insert

/**
 插入

 @param table 表名
 @param column 列名
 @param value 值
 */
- (void)ax_insertIntoTable:(NSString *)table column:(NSString *)column value:(NSString *)value;


#pragma mark update

/**
 更新

 @param table 表名
 @param set 新值
 @param where where
 */
- (void)ax_updateTable:(NSString *)table set:(NSString *)set where:(NSString *)where;


#pragma mark replace

/**
 替换

 @param table 表名
 @param column 列名
 @param value 值
 */
- (void)ax_replaceIntoTable:(NSString *)table column:(NSString *)column value:(NSString *)value;



#pragma mark delete


/**
 删除

 @param table 表名
 @param where where
 */
- (void)ax_deleteFromTable:(NSString *)table where:(NSString *)where;

#pragma mark drop

/**
 丢弃一个表
 
 @param table 表名
 */
- (void)ax_dropTable:(NSString *)table;

@end

@interface NSString (AXDatabaseExtension)

+ (instancetype)stringWithBlock:(void (^)(NSMutableString *string))block;


- (instancetype)stringByDeletingTypeAndComma;

@end

@interface NSMutableString (AXDatabaseExtension)

+ (instancetype)stringWithBlock:(void (^)(NSMutableString *string))block;

- (void)appendComma;
- (void)appendAnd;

- (void)appendVarcharColumn:(NSString *)column comma:(BOOL)comma;
- (void)appendIntegerColumn:(NSString *)column comma:(BOOL)comma;
- (void)appendLongColumn:(NSString *)column comma:(BOOL)comma;
- (void)appendDoubleColumn:(NSString *)column comma:(BOOL)comma;
- (void)appendFloatColumn:(NSString *)column comma:(BOOL)comma;

- (void)appendVarcharValue:(NSString *)value comma:(BOOL)comma;
- (void)appendIntegerValue:(NSInteger)value comma:(BOOL)comma;
- (void)appendLongValue:(long)value comma:(BOOL)comma;
- (void)appendDoubleValue:(double)value comma:(BOOL)comma;
- (void)appendFloatValue:(float)value comma:(BOOL)comma;

@end

NS_ASSUME_NONNULL_END

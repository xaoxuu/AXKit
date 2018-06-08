//
//  FMDatabase+AXAdd.m
//  SmartWatch
//
//  Created by xaoxuu on 05/09/2017.
//  Copyright © 2017 Hinteen. All rights reserved.
//

#import "FMDatabase+AXAdd.h"


static CGFloat currentDatabaseVersion = 3.2;
static FMDatabaseQueue *queue = nil;

inline FMDatabaseQueue *databaseQueue(){
    if (!queue) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            CGFloat lastDatabaseVersion = NSUserDefaults.numberForKey(@"DatabaseVersion").doubleValue;
            if (currentDatabaseVersion > lastDatabaseVersion) {
                NSUserDefaults.setObjectForKey(@(currentDatabaseVersion), @"DatabaseVersion");
                @"com.hinteen.linksmart.sqlite".docPath.removeFile();
            }
        });
        queue = [FMDatabaseQueue databaseQueueWithPath:@"com.hinteen.linksmart.sqlite".docPath];
    }
    return queue;
}

inline void databaseTransaction(void (^block)(FMDatabase *db, BOOL *rollback)){
    [databaseQueue() inTransaction:block];
}

inline void databaseDeferredTransaction(void (^block)(FMDatabase *db, BOOL *rollback)){
    [databaseQueue() inDeferredTransaction:block];
}



@implementation FMDatabase (AXAdd)

#pragma mark fmdb直接封装

/**
 所有更新数据库类的操作（对FMDB的直接封装）
 
 @param update sql增、删、改语句
 */
- (BOOL (^)(NSString * _Nonnull))executeUpdate {
    return ^BOOL(NSString *update){
        BOOL result = [self executeUpdate:update];
        if (!result) {
            AXLogFailure(@"database option failure: >>>>%@", update);
            AXCachedLogOBJ(update);
        }
        return result;
    };
}
/**
 所有查询类的操作（对FMDB的直接封装）
 
 @param query sql查询语句
 @return 查询结果
 */
- (FMResultSet * _Nullable (^)(NSString * _Nonnull))executeQuery{
    return ^FMResultSet *(NSString *query) {
        return [self executeQuery:query];
    };
}


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
- (NSMutableArray *)ax_select:(NSString *)select from:(NSString *)from where:(nullable NSString *)where orderBy:(nullable NSString *)orderBy result:(void (^)(NSMutableArray *result, FMResultSet *set))result{
    NSString *whereString = [NSString stringWithFormat:@"SELECT %@ FROM %@", select, from];
    if (where.length) {
        whereString = [whereString stringByAppendingFormat:@" WHERE %@", where];
    }
    if (orderBy.length) {
        whereString = [whereString stringByAppendingFormat:@" ORDER BY %@", orderBy];
    }
    NSMutableArray *ret = [NSMutableArray array];
    if (result) {
        FMResultSet *set = self.executeQuery(whereString);
        result(ret, set);
    }
    return ret;
}

/**
 查询（from where）
 
 @param select 查询的列（*代表全部）
 @param from 从哪个表查询
 @param where 筛选条件
 @param result 查询结果
 @return 查询结果
 */
- (NSMutableArray *)ax_select:(NSString *)select from:(NSString *)from where:(nullable NSString *)where result:(void (^)(NSMutableArray *result, FMResultSet *set))result{
    return [self ax_select:select from:from where:where orderBy:nil result:result];
}
/**
 查询（from）
 
 @param select 查询的列（*代表全部）
 @param from 从哪个表查询
 @param result 查询结果
 @return 查询结果
 */
- (NSMutableArray *)ax_select:(NSString *)select from:(NSString *)from result:(void (^)(NSMutableArray *result, FMResultSet *set))result{
    return [self ax_select:select from:from where:nil orderBy:nil result:result];
}


#pragma mark create

/**
 创建表
 
 @param table 表名
 @param column 列名
 @param primaryKey 主键
 */
- (void)ax_createTable:(NSString *)table column:(NSString *)column primaryKey:(NSString *)primaryKey{
    NSAssert(table.length, @"table name should not be nil");
    NSAssert(column.length, @"column name should not be nil");
    if (primaryKey.length) {
        if ([primaryKey isEqualToString:@"id"]) {
            self.executeUpdate([NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id integer PRIMARY KEY AUTOINCREMENT NOT NULL, %@)", table, column]);
        } else {
            self.executeUpdate([NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@, PRIMARY KEY(%@))", table, column, primaryKey]);
        }
    } else {
        self.executeUpdate([NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)", table, column]);
    }
}

#pragma mark insert


/**
 插入
 
 @param table 表名
 @param column 列名
 @param value 值
 */
- (void)ax_insertIntoTable:(NSString *)table column:(NSString *)column value:(NSString *)value{
    NSAssert(table.length, @"table name should not be nil");
    NSAssert(column.length, @"column name should not be nil");
    NSAssert(value.length, @"value should not be nil");
    self.executeUpdate([NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES(%@)", table, column, value]);
}


#pragma mark update
/**
 更新
 
 @param table 表名
 @param set 新值
 @param where where
 */
- (void)ax_updateTable:(NSString *)table set:(NSString *)set where:(NSString *)where{
    NSAssert(table.length, @"table name should not be nil");
    NSAssert(set.length, @"set should not be nil");
    if (where.length) {
        self.executeUpdate([NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@", table, set, where]);
    } else {
        self.executeUpdate([NSString stringWithFormat:@"UPDATE %@ SET %@", table, set]);
    }
}


#pragma mark replace
/**
 替换
 
 @param table 表名
 @param column 列名
 @param value 值
 */
- (void)ax_replaceIntoTable:(NSString *)table column:(NSString *)column value:(NSString *)value{
    NSAssert(table.length, @"table name should not be nil");
    NSAssert(column.length, @"columns should not be nil");
    NSAssert(value.length, @"values should not be nil");
    self.executeUpdate([NSString stringWithFormat:@"REPLACE INTO %@(%@) VALUES(%@)", table, column, value]);
}



#pragma mark delete

/**
 删除
 
 @param table 表名
 @param where where
 */
- (void)ax_deleteFromTable:(NSString *)table where:(NSString *)where{
    NSAssert(table.length, @"table name should not be nil");
    if (where.length) {
        self.executeUpdate([NSString stringWithFormat:@"DELETE FROM %@ WHERE %@", table, where]);
    } else {
        self.executeUpdate([NSString stringWithFormat:@"DELETE FROM %@", table]);
    }
}


#pragma mark drpp

/**
 丢弃一个表

 @param table 表名
 */
- (void)ax_dropTable:(NSString *)table{
    NSAssert(table.length, @"table name should not be nil");
    self.executeUpdate([NSString stringWithFormat:@"DROP TABLE %@", table]);
}




@end

@implementation NSString (AXDatabaseAdd)

+ (instancetype)stringWithBlock:(void (^)(NSMutableString *string))block{
    NSMutableString *string = [NSMutableString string];
    if (block) {
        block(string);
    }
    return string;
}

- (instancetype)stringByDeletingTypeAndComma{
    NSMutableString *target = [NSMutableString stringWithString:self];
    if ([target.uppercaseString containsString:@"PRIMARY KEY"]) {
        NSArray<NSString *> *coms = [target componentsSeparatedByString:@","];
        __block NSString *key;
        [coms enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.uppercaseString containsString:@"PRIMARY KEY"]) {
                
                if (idx == 0) {
                    key = [obj stringByAppendingString:@","];
                } else {
                    key = [@"," stringByAppendingString:obj];
                }
            }
        }];
        
        if (key.length) {
            [target replaceOccurrencesOfString:key withString:@"" options:NSLiteralSearch range:target.rangeOfAll];
        }
    }
    [target replaceOccurrencesOfString:@" integer," withString:@"," options:NSLiteralSearch range:target.rangeOfAll];
    [target replaceOccurrencesOfString:@" varchar," withString:@"," options:NSLiteralSearch range:target.rangeOfAll];
    [target replaceOccurrencesOfString:@" long," withString:@"," options:NSLiteralSearch range:target.rangeOfAll];
    [target replaceOccurrencesOfString:@" double," withString:@"," options:NSLiteralSearch range:target.rangeOfAll];
    [target replaceOccurrencesOfString:@" float," withString:@"," options:NSLiteralSearch range:target.rangeOfAll];

    // 去掉最后一个
    NSRange range = [target rangeOfString:@" " options:NSBackwardsSearch];
    NSString *tmp = [target substringFromIndex:range.location];
    [target replaceOccurrencesOfString:tmp withString:@"" options:NSLiteralSearch range:target.rangeOfAll];
    return target;
}


@end
@implementation NSMutableString (AXDatabaseAdd)

+ (instancetype)stringWithBlock:(void (^)(NSMutableString *string))block{
    NSMutableString *string = [NSMutableString string];
    if (block) {
        block(string);
    }
    return string;
}

- (void)appendComma{
    [self appendString:@", "];
}
- (void)appendAnd{
    [self appendString:@" and "];
}
- (void)appendVarcharColumn:(NSString *)column comma:(BOOL)comma{
    [self appendFormat:@"%@ varchar%@", column, comma?@", ":@""];
}
- (void)appendIntegerColumn:(NSString *)column comma:(BOOL)comma{
    [self appendFormat:@"%@ integer%@", column, comma?@", ":@""];
}
- (void)appendLongColumn:(NSString *)column comma:(BOOL)comma{
    [self appendFormat:@"%@ long%@", column, comma?@", ":@""];
}
- (void)appendDoubleColumn:(NSString *)column comma:(BOOL)comma{
    [self appendFormat:@"%@ double%@", column, comma?@", ":@""];
}
- (void)appendFloatColumn:(NSString *)column comma:(BOOL)comma{
    [self appendFormat:@"%@ float%@", column, comma?@", ":@""];
}

- (void)appendVarcharValue:(NSString *)value comma:(BOOL)comma{
    [self appendFormat:@"'%@'%@", (NSString *)value, comma?@", ":@""];
}
- (void)appendIntegerValue:(NSInteger)value comma:(BOOL)comma{
    [self appendFormat:@"%ld%@", (long)value, comma?@", ":@""];
}
- (void)appendLongValue:(long)value comma:(BOOL)comma{
    [self appendFormat:@"%ld%@", (long)value, comma?@", ":@""];
}
- (void)appendDoubleValue:(double)value comma:(BOOL)comma{
    [self appendFormat:@"%lf%@", (double)value, comma?@", ":@""];
}
- (void)appendFloatValue:(float)value comma:(BOOL)comma{
    [self appendFormat:@"%f%@", (float)value, comma?@", ":@""];
}
@end


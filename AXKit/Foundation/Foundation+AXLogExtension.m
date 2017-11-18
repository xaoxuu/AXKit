//
//  Foundation+AXLogExtension.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "Foundation+AXLogExtension.h"
#import "NSString+AXFileStreamChainedWrapper.h"

// 日志存放的文件夹名
static NSString *logFileDir = @"log";
// 日志文件扩展名
static NSString *logFileExtension = @"md";
static NSDateFormatter *formatter;

static inline dispatch_queue_t logQueue(){
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.xaoxuu.AXKit.log", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(queue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    });
    return queue;
}

static inline NSDateFormatter *dateFormatter(NSString *format){
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    formatter.dateFormat = format;
    return formatter;
}

static inline NSString *logPath(){
    static NSString *path;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDate *today = [NSDate date];
        NSString *fileName = [NSString stringWithFormat:@"%@.%@", [dateFormatter(@"yyyy-MM-dd") stringFromDate:today], logFileExtension];
        path = [[@"com.xaoxuu.AXKit" stringByAppendingPathComponent:logFileDir] stringByAppendingPathComponent:fileName].cachePath;
        // 写入第一行，文件标题
        path.saveStringByAppendingToEndOfFile([NSString stringWithFormat:@"## %@\n", [dateFormatter(@"yyyy-MM-dd HH:mm:ss") stringFromDate:today]]);
    });
    return path;
}


@implementation AXLog

/**
 获取所有的日志路径
 
 @return 日志路径
 */
+ (NSArray<NSString *> *)getAllCachedLogPath{
    return logPath().stringByDeletingLastPathComponent.subpaths(logFileExtension);
}

/**
 获取某个日期以后的日志路径
 
 @param date 日期
 @return 日志路径
 */
+ (NSArray<NSString *> *)getLatestCachedLogPathSinceDate:(NSDate *)date{
    NSMutableArray<NSString *> *result = [NSMutableArray arrayWithArray:[self getAllCachedLogPath]];
    for (int i = 0; i < result.count; i++) {
        NSString *obj = result[i];
        NSString *dateString = obj.lastPathComponent.stringByDeletingPathExtension;
        NSDate *targetDate = [dateFormatter(@"yyyy-MM-dd") dateFromString:dateString];
        NSTimeInterval targetTimestamp = [targetDate timeIntervalSince1970];
        if (targetTimestamp < [date timeIntervalSince1970]) {
            [result removeObjectAtIndex:i];
            i--;
        }
    }
    return result;
}

/**
 获取最近几条日志路径
 
 @param count 日志数量
 @return 日志路径
 */
+ (NSArray<NSString *> *)getLatestCachedLogPathWithCount:(NSUInteger)count{
    NSArray *result = [self getAllCachedLogPath];
    if (result.count > count) {
        NSRange range = NSMakeRange(result.count - count, count);
        result = [result subarrayWithRange:range];
    }
    return result;
}

/**
 根据路径读取某个日志内容
 
 @param path 日志路径
 @return 日志内容
 */
+ (NSString *)getLogStringWithPath:(NSString *)path{
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

/**
 写日志（每次启动保存一份日志文件，文件名为启动时间）
 要在日志中记录更详细的内容，需要重写输入对象的-description方法。
 
 @param func __FUNCTION__
 @param input 输入obj
 */
+ (void)writeLogWithFunc:(NSString *)func input:(NSObject *)input{
    if (!input) {
        return;
    }
    dispatch_async(logQueue(), ^{
        // @xaoxuu: in log queue
        NSString *str = [NSString stringWithFormat:@"%@\n```\n%@\n```\n\n", func, input.description];
#ifdef DEBUG
        NSLog(@"%@",str);
#endif
        logPath().saveStringByAppendingToEndOfFile(str);
    });
}

@end

// @xaoxuu: log字典
@implementation NSDictionary (AXLogExtension)

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"{\n"];
    // for-in all key-value
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    [str appendString:@"}"];
    // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end

// @xaoxuu: log数组
@implementation NSArray (AXLogExtension)
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"[\n"];
    // for-in all objects
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    [str appendString:@"]"];
    // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end


//
//  CacheDataAccess.m
//  AXKit
//
//  Created by xaoxuu on 14/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CacheDataAccess.h"
#import "MJExtension.h"


static NSString *key_cache_domain = @"com.xaoxuu.cache/";

@interface CacheDataAccess ()

// @xaoxuu: allCachePaths
@property (strong, nonatomic) NSMutableArray<NSString *> *allCachePaths;

@end

@implementation CacheDataAccess


- (instancetype)init{
    if (self = [super init]) {
        
        
        
    }
    return self;
}



#pragma mark - 指定文件

- (void)cacheObj:(BaseTableModelListType)obj forKey:(NSString *)key completion:(void (^)())completion fail:(void (^)())fail{
    BOOL ret = key.ax_cacheObj(obj);
    [NSBlockOperation ax_delay:0 performInMainQueue:^{
        if (ret) {
            if (completion) {
                completion();
            }
        } else {
            if (fail) {
                fail();
            }
        }
    }];
}

- (void)removeObjWithKey:(NSString *)key completion:(void (^)())completion fail:(void (^)())fail{
    BOOL ret = key.ax_removeObj;
    [NSBlockOperation ax_delay:0 performInMainQueue:^{
        if (ret) {
            if (completion) {
                completion();
            }
        } else {
            if (fail) {
                fail();
            }
        }
    }];
}

- (BaseTableModelListType)loadObjWithKey:(NSString *)key{
    @try {
        BaseTableModelListType list = key.ax_readObj;
        if (!list.count) {
            list = [BaseTableModelSection mj_objectArrayWithKeyValuesArray:self.jsonInBundle(key)];
            if (!list.count) {
                list = [NSMutableArray array];
            }
        }
        return list;
    } @catch (NSException *exception) {
        [UIAlertController ax_showAlertWithTitle:kStringError() message:exception.description action:nil];
        return [NSMutableArray array];
    } @finally {
        
    }
    
}

#pragma mark - util
//
//- (BaseTableModelListType (^)(NSString *json))modelList{
//    return ^(NSString *json){
//        BaseTableModelListType list = json.json.cachePath.readArchivedObject;
//        if (!list) {
//            list = [BaseTableModelSection mj_objectArrayWithKeyValuesArray:self.jsonInBundle(json)];
//            if (!list) {
//                list = [NSMutableArray array];
//            }
//        }
//        return list;
//    };
//}

- (NSArray *(^)(NSString *))jsonInBundle{
    return ^(NSString *json){
        NSDictionary *dict = json.json.mainBundlePath.readJson;
        return dict[@"sections"];
    };
}


- (NSMutableArray<NSString *> *)allCachePaths{
    if (!_allCachePaths.count) {
        _allCachePaths = [NSMutableArray arrayWithArray:key_cache_domain.cachePath.subpaths(@"")];
        [NSBlockOperation ax_delay:2 performInMainQueue:^{
            [_allCachePaths removeAllObjects];
        }];
    }
    return _allCachePaths;
}


#pragma mark - 清空

- (void)removeAllCacheCompletion:(void (^)())completion{
    [NSBlockOperation ax_delay:0 performInBackground:^{
        for (NSString *path in self.allCachePaths) {
            if (path.remove) {
                // @xaoxuu: 已清除缓存
            } else {
                AXLogFail(@"缓存清除失败:<%@>",path.lastPathComponent);
            }
        }
        [NSBlockOperation ax_delay:0 performInMainQueue:^{
            if (completion) {
                completion();
            }
        }];
    }];
}

#pragma mark 获取path路径下文件夹大小
- (NSString *)getCacheSizeWithFilePath:(NSString *)path{
    
    // 获取“path”文件夹下的所有文件
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    
    for (NSString *subPath in subPathArr){
        
        // 1. 拼接每一个文件的全路径
        filePath =[path stringByAppendingPathComponent:subPath];
        // 2. 是否是文件夹，默认不是
        BOOL isDirectory = NO;
        // 3. 判断文件是否存在
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        // 4. 以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        
        // 5. 指定路径，获取这个路径的属性
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        
        // 6. 获取每一个文件的大小
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        
        // 7. 计算总大小
        totleSize += size;
    }
    
    //8. 将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    
    if (totleSize > 1000 * 1000){
        totleStr = [NSString stringWithFormat:@"%.2fMB",totleSize / 1000.00f /1000.00f];
        
    }else if (totleSize > 1000){
        totleStr = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f ];
        
    }else{
        totleStr = [NSString stringWithFormat:@"%fbyte",totleSize / 1.00f];
    }
    
    return totleStr;
}


#pragma mark 清除path文件夹下缓存大小
- (BOOL)clearCacheWithFilePath:(NSString *)path{
    
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    NSString *filePath = nil;
    
    NSError *error = nil;
    
    for (NSString *subPath in subPathArr)
    {
        filePath = [path stringByAppendingPathComponent:subPath];
        
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }
    }
    return YES;
}


@end


@implementation NSString (AXCacheServices)



- (NSString *)cachedFilePath{
    return @"com.xaoxuu.cache/".append(self).json.cachePath;
}

- (BOOL(^)(NSObject<NSCoding> *))ax_cacheObj{
    return ^(id obj){
        return self.cachedFilePath.saveArchivedObject(obj);
    };
}

- (id)ax_readObj{
    return self.cachedFilePath.readArchivedObject;
}

- (BOOL)ax_removeObj{
    return self.cachedFilePath.remove;
}

@end

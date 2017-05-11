//
//  CacheServices.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CacheServices.h"
#import "MJExtension.h"

#define CACHE_SETTING @"setting"

@interface CacheServices ()

// @xaoxuu: setting list
@property (strong, nonatomic) BaseTableModelListType settingList;

// @xaoxuu: cache list
@property (strong, nonatomic) BaseTableModelListType cacheList;

// @xaoxuu: proj list
@property (strong, nonatomic) BaseTableModelListType projectList;

@end

@implementation CacheServices

- (instancetype)init{
    if (self = [super init]) {
        
        [self asyncCalculateCache];
        
    }
    return self;
}


- (BaseTableModelListType)settingList{
    if (!_settingList) {
        NSString *cachePath = CACHE_SETTING.json.cachePath;
        NSString *bundlePath = CACHE_SETTING.json.mainBundlePath;
        _settingList = cachePath.readArchivedObject;
        if (!_settingList) {
            NSDictionary *dict = bundlePath.readJson;
            NSArray *sections = dict[@"sections"];
            _settingList = [BaseTableModelSection mj_objectArrayWithKeyValuesArray:sections];
        }
        
        if (!_settingList) {
            _settingList = [NSArray array];
        }
        cachePath.saveArchivedObject(_settingList);
        
        [NSBlockOperation ax_delay:0 performInBackground:^{
            [self cacheList];
        }];
        
    }
    return _settingList;
}


- (void)updateSetting:(void (^)(BaseTableModelListType setting))update{
    if (update) {
        update(self.settingList);
        CACHE_SETTING.json.cachePath.saveArchivedObject(self.settingList);
    }
}


- (NSString *)cacheBytes{
    NSData *data = [NSData dataWithContentsOfFile:CACHE_SETTING.json.cachePath];
    return NSStringFromNSUInteger(data.length);
}


- (BaseTableModelListType)cacheList{
    if (!_cacheList) {
        // @xaoxuu: cache
        BaseTableModelSection *section1 = [BaseTableModelSection new];
        NSArray<NSString *> *subPathArr = @"".cachePath.subpaths(@"");
        section1.header_title = @"~/cache/";
        for (NSString *tmp in subPathArr) {
            BaseTableModelRow *row = [BaseTableModelRow new];
            row.title = tmp.lastPathComponent;
            row.desc = NSStringFromNSUInteger([NSData dataWithContentsOfFile:tmp].length).append(@"bytes");
            [section1.rows addObject:row];
        }
        _cacheList = [NSArray arrayWithObjects:section1, nil];
    }
    return _cacheList;
}

// @xaoxuu: 项目列表
- (BaseTableModelListType)projectList{
    if (!_projectList) {
        // @xaoxuu: json服务取出模型
        _projectList = services.json.modelList(@"projects");
        // @xaoxuu: cache缓存
        @"projects".json.cachePath.saveArchivedObject(_projectList);
        
    }
    return _projectList;
}

#pragma mark - 清除缓存


- (void)removeAllCacheCompletion:(void (^)())completion{
    
    [NSBlockOperation ax_delay:0 performInBackground:^{
        self.settingList = nil;
        self.projectList = nil;
        BOOL ret = [self clearCacheWithFilePath:@"".cachePath];
        if (completion) {
            [NSBlockOperation ax_delay:0 performInMainQueue:^{
                completion();
            }];
        }
        if (ret) {
            [services.alert alertForOptionDoneWithMessage:@"已清除缓存"];
        }
        AXLogBOOL(ret);
    }];
    
}

- (void)removeSettingCacheCompletion:(void (^)())completion{
    self.settingList = nil;
    BOOL ret = CACHE_SETTING.json.cachePath.remove;
    if (ret && completion) {
        completion();
    }
    if (ret) {
        [services.alert alertForOptionDoneWithMessage:@"已清除缓存"];
    }
    AXLogBOOL(ret);
}


#pragma mark - async
// @xaoxuu: 异步计算缓存大小、提前取出模型
- (void)asyncCalculateCache{
    [NSBlockOperation ax_delay:0 performInBackground:^{
        self.cacheFileSize = [self getCacheSizeWithFilePath:@"".cachePath];
        [self cacheList];
        [self cacheBytes];
        [self settingList];
    }];
}


#pragma mark - util

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
        totleStr = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f /1000.00f];
        
    }else if (totleSize > 1000){
        totleStr = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f ];
        
    }else{
        totleStr = [NSString stringWithFormat:@"%.2fB",totleSize / 1.00f];
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

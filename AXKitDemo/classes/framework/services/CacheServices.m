//
//  CacheServices.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CacheServices.h"
#import "MJExtension.h"
#import "DataAccessLayer.h"

#define daLayer [DataAccessLayer sharedInstance]

// @xaoxuu: 务必保证：【key = json文件名 = tableview类名】
static NSString *key_setting = @"SettingTableView";
static NSString *key_projects = @"ProjectsTableView";
static NSString *key_about = @"AboutTableView";


@interface CacheServices () <ServicesPrivateMethod>

// @xaoxuu: setting list
@property (strong, nonatomic) BaseTableModelListType settingList;

// @xaoxuu: cache list
@property (strong, nonatomic) BaseTableModelListType cacheList;

// @xaoxuu: proj list
@property (strong, nonatomic) BaseTableModelListType projectList;

// @xaoxuu: about list
@property (strong, nonatomic) BaseTableModelListType aboutList;

@end




@implementation CacheServices

- (instancetype)init{
    if (self = [super init]) {
        
        [self asyncCalculateCache];
        
    }
    return self;
}




#pragma mark - 指定文件

- (void)cacheObj:(BaseTableModelListType)obj forKey:(NSString *)key completion:(void (^)())completion{
    [daLayer.cache cacheObj:obj forKey:key completion:^{
        // @xaoxuu: async calculate cache
        [NSBlockOperation ax_delay:0 cooldown:1 token:@"async calculate cache" performInBackground:^{
            AXLogSuccess(@"%@ 已完成缓存",key);
            [self asyncCalculateCache];
            [self cacheList];
        }];
    } fail:^{
        AXLogFail(@"%@ 缓存失败",key);
    }];
}

- (void)removeObjWithKey:(NSString *)key completion:(void (^)())completion{
    [daLayer.cache removeObjWithKey:key completion:^{
        AXLogSuccess(@"%@ 已清除缓存",key);
        [self asyncCalculateCache];
    } fail:^{
        AXLogFail(@"%@ 清除缓存失败",key);
    }];
}

- (BaseTableModelListType)loadObjWithKey:(NSString *)key{
    return [daLayer.cache loadObjWithKey:key];
}



#pragma mark - 更新

- (void)updateSetting:(void (^)(BaseTableModelListType setting))update{
    if (update) {
        update(self.settingList);
        [self cacheObj:self.settingList forKey:key_setting completion:^{
            AXLogFormat(@"%@ 已更新",key_setting);
        }];
    }
}


#pragma mark - 清空

- (void)removeAllCacheCompletion:(void (^)())completion{
    [daLayer.cache removeAllCacheCompletion:completion];
}


#pragma mark - overwrite

- (BaseTableModelListType)settingList{
    if (!_settingList.count) {
        // @xaoxuu: 取出模型
        _settingList = [self loadObjWithKey:key_setting];
        // @xaoxuu: cache缓存
        [self cacheObj:_settingList forKey:key_setting completion:nil];
        
    }
    return _settingList;
}


// @xaoxuu: 项目列表
- (BaseTableModelListType)projectList{
    if (!_projectList.count) {
        // @xaoxuu: 取出模型
        _projectList = [self loadObjWithKey:key_projects];
        // @xaoxuu: cache缓存
        [self cacheObj:_projectList forKey:key_projects completion:nil];
        
    }
    return _projectList;
}

// @xaoxuu: 关于
- (BaseTableModelListType)aboutList{
    if (!_aboutList.count) {
        // @xaoxuu: 取出模型
        _aboutList = [self loadObjWithKey:key_about];
        // @xaoxuu: cache缓存
        [self cacheObj:_aboutList forKey:key_about completion:nil];
    }
    return _aboutList;
}




// @xaoxuu: 缓存列表
- (BaseTableModelListType)cacheList{
    if (!_cacheList.count) {
        // @xaoxuu: cache
        BaseTableModelSection *section1 = [BaseTableModelSection new];
        NSArray<NSString *> *subPathArr = daLayer.cache.allCachePaths;
        section1.header_title = @"~/cache/";
        for (NSString *path in subPathArr) {
            BaseTableModelRow *row = [BaseTableModelRow new];
            row.title = path.lastPathComponent;
            NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
            NSInteger size = [dict[@"NSFileSize"] integerValue];
            row.cmd = NSStringFromNSInteger(size);
            if (size > 10) {
                row.desc = [NSString stringWithFormat:@"%.2fKB",size/1000.0f];
            } else {
                row.desc = [NSString stringWithFormat:@"%.0fbytes",size/1.0f];
            }
            [section1.rows addObject:row];
        }
        AXLogWarning(@"计算了一次缓存");
        _cacheList = [NSMutableArray arrayWithArray:@[section1]];
    }
    return _cacheList;
}


#pragma mark - async
// @xaoxuu: 异步计算缓存大小、提前取出模型
- (void)asyncCalculateCache{
    [NSBlockOperation ax_delay:0 cooldown:3 token:@"asyncCalculateCache" performInBackground:^{
        [self settingList];
        _cacheList = nil;
        [self cacheList];
        
        NSInteger length = 0;
        for (BaseTableModelSection *sec in self.cacheList) {
            for (BaseTableModelRow *row in sec.rows) {
                length += row.cmd.integerValue;
            }
        }
        _cachedFileSize = [NSString stringWithFormat:@"%.2fKB",length/1000.0f];
    }];
}





@end

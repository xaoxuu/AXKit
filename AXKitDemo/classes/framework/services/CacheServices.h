//
//  CacheServices.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"

@protocol CacheServiceDelegate <BaseServicesDelegate>



@end

@interface CacheServices : BaseServices


// @xaoxuu: 缓存文件总大小
@property (copy, readonly, nonatomic) NSString *cachedFileSize;


#pragma mark - 缓存和读取默认的列表数据

///**
// 缓存列表模型
//
// @param list 列表模型
// */
//- (void)saveDefaultModelList:(NSMutableArray<BaseTableModelSection *> *)list forKey:(NSString *)key;
//
///**
// 读取默认的列表模型（用于加载列表时先填充缓存数据）
//
// @return 列表模型
// */
//- (NSMutableArray<BaseTableModelSection *> *)readDefaultModelListWithKey:(NSString *)key;
//

#pragma mark - 指定文件

- (void)cacheObj:(NSMutableArray<BaseTableModelSection *> *)obj forKey:(NSString *)key completion:(void (^)(void))completion;

- (NSMutableArray<BaseTableModelSection *> *)loadObjWithKey:(NSString *)key;

- (void)removeObjWithKey:(NSString *)key completion:(void (^)(void))completion;


#pragma mark - 更新

- (void)updateSetting:(void (^)(NSMutableArray<BaseTableModelSection *> *))update;

#pragma mark - 设置列表

- (NSMutableArray<BaseTableModelSection *> *)settingList;

- (NSMutableArray<BaseTableModelSection *> *)customStatusBarList;

- (NSMutableArray<BaseTableModelSection *> *)cacheList;


- (NSMutableArray<BaseTableModelSection *> *)projectList;

- (NSMutableArray<BaseTableModelSection *> *)aboutList;

#pragma mark - 清空

- (void)removeAllCacheCompletion:(void (^)(void))completion;


@end




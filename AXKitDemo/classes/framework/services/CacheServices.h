//
//  CacheServices.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"
#import "BaseTableModel.h"

typedef NSArray<__kindof BaseTableModelSection *> * BaseTableModelListType;

@interface CacheServices : BaseServices

// @xaoxuu: cache file size
@property (copy, nonatomic) NSString *cacheFileSize;


#pragma mark - 设置列表

- (BaseTableModelListType)settingList;

- (void)updateSetting:(void (^)(BaseTableModelListType setting))update;



- (NSString *)cacheBytes;

//- (void)setting:(void (^)(UserSettingModel *cachedUser))userSetting;
//- (UserSettingModel *)userSetting;

- (BaseTableModelListType)cacheList;


- (BaseTableModelListType)projectList;


#pragma mark - 清除缓存

- (void)removeAllCacheCompletion:(void (^)())completion;

- (void)removeSettingCacheCompletion:(void (^)())completion;



@end

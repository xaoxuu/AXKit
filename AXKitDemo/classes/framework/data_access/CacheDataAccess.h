//
//  CacheDataAccess.h
//  AXKit
//
//  Created by xaoxuu on 14/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseDataAccess.h"

@interface CacheDataAccess : BaseDataAccess




//- (NSMutableArray<BaseTableModelSection *> * (^)(NSString *json))modelList;

- (NSMutableArray<BaseTableModelSection *> *)loadObjWithKey:(NSString *)key;

- (void)cacheObj:(NSMutableArray<BaseTableModelSection *> *)obj forKey:(NSString *)key completion:(void (^)())completion fail:(void (^)())fail;

- (void)removeObjWithKey:(NSString *)key completion:(void (^)())completion fail:(void (^)())fail;


#pragma mark - util

- (NSMutableArray<NSString *> *)allCachePaths;

- (void)removeAllCacheCompletion:(void (^)())completion;

@end

@interface NSString (AXCacheServices)

- (BOOL(^)(NSObject<NSCoding> *))ax_cacheObj;
- (id)ax_readObj;
- (BOOL)ax_removeObj;
@end

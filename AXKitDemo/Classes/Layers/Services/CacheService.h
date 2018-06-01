//
//  CacheService.h
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeCollectionModel.h"



@interface CacheService : NSObject

- (NSString *)cacheForClassWithName:(NSString *)name;

- (ThemeCollectionModel *)cachedThemeList;
- (void)loadThemeList:(void (^)(ThemeCollectionModel *model))callback;

- (BOOL)isThemeDownloaded:(AXThemeModel *)model;

- (void)downloadTheme:(AXThemeModel *)model completion:(void (^)(AXThemeModel *theme))completion;



@end

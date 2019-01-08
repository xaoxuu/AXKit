//
//  CacheService.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CacheService.h"
#import "NetworkManager.h"

static NSString *jsonCachePath(NSString *name){
    return [NSString stringWithFormat:@"com.xaoxuu.AXKitDemo/Config/%@.json", name].cachePath;
}
static NSString *themeListCachePath(){
    return [NSString stringWithFormat:@"com.xaoxuu.AXKitDemo/Themes/index.json"].cachePath;
}
static NSString *themeCachePath(NSString *email, NSString *name){
    return [AXThemeModel filePathWithIdentifier:[AXThemeModel identifierWithEmail:email name:name]];
}


@implementation CacheService

- (NSString *)cacheForClassWithName:(NSString *)name{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // @xaoxuu: in background queue
        NSString *urlString = [NSString stringWithFormat:@"%@/%@.json", kBaseURLStringForApp, name];
        [NetworkManager getURLString:urlString completion:^(NSData * _Nullable data, id response) {
            if (response) {
                [jsonCachePath(name).saveJson(response) error:^(NSError * _Nullable error) {
                    AXCachedLogError(error);
                }];
            }
        } fail:^(NSError *error) {
            AXCachedLogError(error);
        }];
    });
    NSString *path = jsonCachePath(name);
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path = [[NSBundle bundleForClass:NSClassFromString(name)] pathForResource:name ofType:@"json"];
    }
    return path;
}


- (ThemeCollectionModel *)cachedThemeList{
    NSString *path = themeListCachePath();
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSDictionary *json = [path.readJsonResult() error:^(NSError * _Nullable error) {
            AXCachedLogError(error);
        }].dictionaryValue;
        return [ThemeCollectionModel modelWithDict:json];
    }
    return nil;
}

- (void)loadThemeList:(void (^)(ThemeCollectionModel *model))callback{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // @xaoxuu: in background queue
        NSString *urlString = [NSString stringWithFormat:@"%@/index.json", kBaseURLStringForTheme];
        [NetworkManager getURLString:urlString completion:^(NSData * _Nullable data, id response) {
            if (response) {
                if (callback) {
                    callback([ThemeCollectionModel modelWithDict:response]);
                }
                [themeListCachePath().saveJson(response) error:^(NSError * _Nullable error) {
                    AXCachedLogError(error);
                }];
            }
        } fail:^(NSError *error) {
            AXCachedLogError(error);
        }];
    });
}

- (BOOL)isThemeDownloaded:(AXThemeModel *)model{
    NSString *path = themeCachePath(model.info.email, model.info.name);
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

- (void)downloadTheme:(AXThemeModel *)model completion:(void (^)(AXThemeModel *theme))completion{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // @xaoxuu: in background queue
        NSString *urlString = [[NSString stringWithFormat:@"%@/%@/%@.json",BaseURLForTheme, model.info.email, model.info.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NetworkManager getURLString:urlString completion:^(NSData * _Nullable data, id response) {
            if (response) {
                [themeCachePath(model.info.email, model.info.name).saveJson(data) error:^(NSError * _Nullable error) {
                    AXCachedLogError(error);
                }];
            }
            if (completion) {
                completion(model);
            }
        } fail:^(NSError *error) {
            AXCachedLogError(error);
        }];
    });
}



@end

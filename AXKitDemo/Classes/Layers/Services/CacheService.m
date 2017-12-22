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
    return [UIThemeModel filePathWithIdentifier:[UIThemeModel identifierWithEmail:email name:name]];
}


@implementation CacheService

- (NSString *)cacheForClassWithName:(NSString *)name{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // @xaoxuu: in background queue
        NSString *urlString = [NSString stringWithFormat:@"%@/%@.json", kBaseURLStringForApp, name];
        [NetworkManager getURLString:urlString completion:^(NSData * _Nullable data, id response) {
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            jsonCachePath(name).saveFile(jsonString);
        } fail:^(NSError *error) {
            
        }];
    });
    NSString *path = jsonCachePath(name);
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    }
    return path;
}


- (ThemeCollectionModel *)cachedThemeList{
    NSString *path = themeListCachePath();
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return [ThemeCollectionModel modelWithDict:json];
    }
    return nil;
}

- (void)loadThemeList:(void (^)(ThemeCollectionModel *model))callback{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // @xaoxuu: in background queue
        NSString *urlString = [NSString stringWithFormat:@"%@/index.json", kBaseURLStringForTheme];
        [NetworkManager getURLString:urlString completion:^(NSData * _Nullable data, id response) {
            if (callback) {
                callback([ThemeCollectionModel modelWithDict:response]);
            }
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            themeListCachePath().saveFile(jsonString);
        } fail:^(NSError *error) {
            
        }];
    });
}

- (BOOL)isThemeDownloaded:(UIThemeModel *)model{
    NSString *path = themeCachePath(model.info.email, model.info.name);
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

- (void)downloadTheme:(UIThemeModel *)model completion:(void (^)(UIThemeModel *theme))completion{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // @xaoxuu: in background queue
        NSString *urlString = BaseURLForTheme.appendPathComponent(model.info.email).appendPathComponent([model.info.name stringByURLEncode]).extension(@"json");
        [NetworkManager getURLString:urlString completion:^(NSData * _Nullable data, id response) {
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            themeCachePath(model.info.email, model.info.name).saveFile(jsonString);
            if (completion) {
                completion(model);
            }
        } fail:^(NSError *error) {
            
        }];
    });
}



@end

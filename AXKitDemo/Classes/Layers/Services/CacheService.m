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
        [NetworkManager getURLString:BaseURLForApp.appendPathComponent(name).extension(@"json") completion:^(NSData * _Nullable data, id response) {
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
        [NetworkManager getURLString:BaseURLForTheme.appendPathComponent(@"index").extension(@"json") completion:^(NSData * _Nullable data, id response) {
            if (callback) {
                callback([ThemeCollectionModel modelWithDict:response]);
            }
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            themeListCachePath().saveFile(jsonString);
        } fail:^(NSError *error) {
            
        }];
    });
}

- (BOOL)isThemeDownloaded:(ThemeCollectionRowModel *)model{
    NSString *path = themeCachePath(model.email, model.name);
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

- (void)downloadTheme:(ThemeCollectionRowModel *)model completion:(void (^)(UIThemeModel *theme))completion{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // @xaoxuu: in background queue
        NSString *urlString = BaseURLForTheme.appendPathComponent(model.email).appendPathComponent([model.name stringByURLEncode]).extension(@"json");
        [NetworkManager getURLString:urlString completion:^(NSData * _Nullable data, id response) {
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            themeCachePath(model.email, model.name).saveFile(jsonString);
            if (completion) {
                UIThemeModel *tmp = [UIThemeModel modelWithPath:themeCachePath(model.email, model.name)];
                completion(tmp);
            }
        } fail:^(NSError *error) {
            
        }];
    });
}



@end

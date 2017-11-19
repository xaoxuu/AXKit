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

@end

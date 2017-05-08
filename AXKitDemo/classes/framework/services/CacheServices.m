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
@property (strong, nonatomic) NSArray<BaseTableModelList *> *settingList;



@end

@implementation CacheServices

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}


- (NSArray<BaseTableModelList *> *)settingList{
    if (!_settingList) {
        NSString *cachePath = CACHE_SETTING.json.cachePath;
        NSString *bundlePath = CACHE_SETTING.json.mainBundlePath;
        NSDictionary *dict = cachePath.readJson;
        if (!dict) {
            dict = bundlePath.readJson;
            CACHE_SETTING.json.cachePath.save(dict);
        }
        
        NSArray *sections = dict[@"sections"];
#warning rows没有解析
        _settingList = [BaseTableModelList mj_objectArrayWithKeyValuesArray:sections];
        if (!_settingList) {
            
            _settingList = [NSArray array];
        }
    }
    return _settingList;
}

@end

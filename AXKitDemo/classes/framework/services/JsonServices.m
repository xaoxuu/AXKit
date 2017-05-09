//
//  JsonServices.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "JsonServices.h"
#import "MJExtension.h"

#define CACHE_COLORS @"theme_color"
@interface JsonServices ()

// @xaoxuu: colors
@property (strong, nonatomic) NSArray<ThemeColorModelList *> *colors;

@end

@implementation JsonServices


- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (NSArray<ThemeColorModelList *> *)colors{
    if (!_colors) {
        NSDictionary *jsonFile = CACHE_COLORS.mainBundlePath.readJson;
        NSArray *sections = jsonFile[@"sections"];
        _colors = [ThemeColorModelList mj_objectArrayWithKeyValuesArray:sections];
        if (!_colors) {
            _colors = [NSArray array];
        }
    }
    return _colors;
}

@end

//
//  JsonServices.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "JsonServices.h"
#import "MJExtension.h"
#import "DataAccessLayer.h"

#define daLayer [DataAccessLayer sharedInstance]

#define CACHE_COLORS @"theme_color"

#define BUNDLE_VC_TITLES @"view_controller_titles".mainBundlePath

@interface JsonServices ()

// @xaoxuu: colors
@property (strong, nonatomic) BaseTableModelListType colors;

@end

@implementation JsonServices


- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}



- (BaseTableModelListType (^)(NSString *json))modelList{
    return ^(NSString *json){
        BaseTableModelListType list = json.json.cachePath.readArchivedObject;
        if (!list) {
            list = [BaseTableModelSection mj_objectArrayWithKeyValuesArray:self.jsonInBundle(json)];
            if (!list) {
                list = [NSMutableArray array];
            }
        }
        return list;
    };
}

- (NSArray *(^)(NSString *))jsonInBundle{
    return ^(NSString *json){
        NSDictionary *dict = json.json.mainBundlePath.readJson;
        return dict[@"sections"];
    };
}




- (BaseTableModelListType)colors{
    if (!_colors) {
        NSDictionary *jsonFile = CACHE_COLORS.mainBundlePath.readJson;
        NSArray *sections = jsonFile[@"sections"];
        _colors = [ThemeColorModelSection mj_objectArrayWithKeyValuesArray:sections];
        if (!_colors) {
            _colors = [NSMutableArray array];
        }
    }
    return _colors;
}


- (NSString *((^)(NSString *)))titleForVC{
    return ^(NSString *vcName){
        NSDictionary *dict = BUNDLE_VC_TITLES.readJson;
        NSString *title = NSLocalizedString(vcName, nil);
        for (NSDictionary *tmp in dict[@"items"]) {
            if ([tmp[@"vc"] isEqualToString:vcName]) {
                title = tmp[@"title"];
            }
        }
        return title;
    };
}

@end

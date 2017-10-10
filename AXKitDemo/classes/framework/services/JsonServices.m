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

#define CACHE_COLORS @"ThemeColorTableView"
#define CACHE_CUSTOM_STATUS_BAR @"CustomStatusBarTV"
//#define BUNDLE_VC_TITLES @"view_controller_titles".mainBundlePath

@interface JsonServices ()

// @xaoxuu: colors
@property (strong, nonatomic) NSMutableArray<BaseTableModelSection *> *colors;
// @xaoxuu: custom status bar list
@property (strong, nonatomic) NSMutableArray<BaseTableModelSection *> *customStatusBarList;

@end

@implementation JsonServices


- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}



- (NSMutableArray<BaseTableModelSection *> *(^)(NSString *json))modelList{
    return ^(NSString *json){
        NSMutableArray<BaseTableModelSection *> *list = json.extension(@"json").cachePath.readArchivedFile();
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
        NSDictionary *dict = json.mainBundlePath.readJson();
        return dict[@"sections"];
    };
}




- (NSMutableArray<BaseTableModelSection *> *)colors{
    if (!_colors) {
        NSDictionary *jsonFile = CACHE_COLORS.mainBundlePath.readJson();
        NSArray *sections = jsonFile[@"sections"];
        _colors = [ThemeColorModelSection mj_objectArrayWithKeyValuesArray:sections];
        if (!_colors) {
            _colors = [NSMutableArray array];
        }
    }
    return _colors;
}

- (NSMutableArray<BaseTableModelSection *> *)customStatusBarList{
    if (!_customStatusBarList.count) {
        NSDictionary *jsonFile = CACHE_CUSTOM_STATUS_BAR.mainBundlePath.readJson();
        NSArray *sections = jsonFile[@"sections"];
        _customStatusBarList = [ThemeColorModelSection mj_objectArrayWithKeyValuesArray:sections];
        if (!_customStatusBarList) {
            _customStatusBarList = [NSMutableArray array];
        }
    }
    return _customStatusBarList;
}

//- (NSString *((^)(NSString *)))titleForVC{
//    return ^(NSString *vcName){
//        NSDictionary *dict = BUNDLE_VC_TITLES.readJson();
//        NSString *title = NSLocalizedString(vcName, nil);
//        for (NSDictionary *tmp in dict[@"items"]) {
//            if ([tmp[@"vc"] isEqualToString:vcName]) {
//                title = tmp[@"title"];
//            }
//        }
//        return title;
//    };
//}

@end

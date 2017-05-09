//
//  AppServices.m
//  AXKit
//
//  Created by xaoxuu on 08/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AppServices.h"

@interface AppServices ()

// @xaoxuu: json file
@property (strong, nonatomic) NSDictionary *jsonFile;

@end

@implementation AppServices

- (instancetype)init{
    if (self = [super init]) {
        _placeholderForSetting = [UIImage imageNamed:@"setting_default"];
        
        _homePageURL = self.jsonFile[@"homePageURL"];
        _blogURL = self.jsonFile[@"blogURL"];
        _feedbackURL = self.jsonFile[@"feedbackURL"];
        _defaultVC = [DefaultViewController new];
        
    }
    return self;
}

- (NSDictionary *)jsonFile{
    if (!_jsonFile) {
        _jsonFile = @"urls".mainBundlePath.readJson;
    }
    return _jsonFile;
}

@end

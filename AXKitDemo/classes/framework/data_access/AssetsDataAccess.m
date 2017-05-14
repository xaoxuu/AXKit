//
//  AssetsDataAccess.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AssetsDataAccess.h"

@implementation AssetsDataAccess


- (instancetype)init{
    if (self = [super init]) {
        _setting = [SettingAssetsDataAccess new];
        _alert = [AlertAssetsDataAccess new];
    }
    return self;
}



@end


@implementation SettingAssetsDataAccess


- (NSString *)placeholder{
    return @"setting_default";
}


@end



@implementation AlertAssetsDataAccess

- (NSString *)done{
    return @"alert_theme";
}


- (NSString *)theme{
    return @"alert_theme";
}

@end

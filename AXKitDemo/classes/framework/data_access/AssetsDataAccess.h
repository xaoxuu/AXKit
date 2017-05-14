//
//  AssetsDataAccess.h
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseDataAccess.h"

@class SettingAssetsDataAccess;
@class AlertAssetsDataAccess;



@interface AssetsDataAccess : BaseDataAccess


// @xaoxuu: setting
@property (strong, nonatomic) SettingAssetsDataAccess *setting;


// @xaoxuu: alert
@property (strong, nonatomic) AlertAssetsDataAccess *alert;

@end




@interface SettingAssetsDataAccess : NSObject

// @xaoxuu: placeholder
@property (copy, nonatomic) NSString *placeholder;


@end

@interface AlertAssetsDataAccess : NSObject

// @xaoxuu: done
@property (copy, nonatomic) NSString *done;

// @xaoxuu: theme
@property (copy, nonatomic) NSString *theme;


@end

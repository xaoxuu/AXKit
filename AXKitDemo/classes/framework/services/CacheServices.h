//
//  CacheServices.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"
#import "BaseTableModel.h"

@interface CacheServices : BaseServices

#pragma mark - 设置列表

- (NSArray<BaseTableModelList *> *)settingList;

//- (void)setting:(void (^)(UserSettingModel *cachedUser))userSetting;
//- (UserSettingModel *)userSetting;

@end

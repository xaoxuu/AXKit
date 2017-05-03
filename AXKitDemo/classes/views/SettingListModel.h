//
//  SettingListModel.h
//  AXKit
//
//  Created by xaoxuu on 17/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingListModel : NSObject

#pragma mark ui
// @xaoxuu: icon path
@property (copy, nonatomic) NSString *icon;
// @xaoxuu: title
@property (copy, nonatomic) NSString *title;
// @xaoxuu: detail
@property (copy, nonatomic) NSString *detail;

#pragma mark style
// @xaoxuu: 是否显示">"，默认为YES
@property (assign, nonatomic) BOOL showAccessory;
// @xaoxuu: 是否显示开关，默认为NO
@property (assign, nonatomic) BOOL showSwitch;
// @xaoxuu: 是否显示消息数badge，默认为NO
@property (assign, nonatomic) BOOL showBadge;

#pragma mark 功能
// @xaoxuu: 跳转到某控制器
@property (copy, nonatomic) NSString *target;



@end

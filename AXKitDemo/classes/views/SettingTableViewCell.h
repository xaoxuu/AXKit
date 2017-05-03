//
//  SettingTableViewCell.h
//  AXKit
//
//  Created by xaoxuu on 17/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingListModel.h"

@interface SettingTableViewCell : UITableViewCell

// @xaoxuu: model
@property (strong, nonatomic) SettingListModel *model;
// @xaoxuu: switch
@property (strong, nonatomic) UISwitch *sw;


- (void)switchStatusChanged:(void (^)(BOOL on))changed;

@end

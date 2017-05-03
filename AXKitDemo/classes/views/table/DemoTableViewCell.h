//
//  DemoTableViewCell.h
//  AXKit
//
//  Created by xaoxuu on 03/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoTableModel.h"

@interface DemoTableViewCell : UITableViewCell

// @xaoxuu: model
@property (strong, nonatomic) DemoTableModel *model;
// @xaoxuu: switch
@property (strong, nonatomic) UISwitch *sw;


- (void)switchStatusChanged:(void (^)(BOOL on))changed;


@end

//
//  BaseTableViewCell.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableModel.h"
#import "BaseSwitch.h"

@interface BaseTableViewCell : UITableViewCell

// @xaoxuu: model
@property (strong, readwrite, nonatomic) BaseTableModel *model;

// @xaoxuu: switch
@property (strong, readonly, nonatomic) BaseSwitch *sw;


@end

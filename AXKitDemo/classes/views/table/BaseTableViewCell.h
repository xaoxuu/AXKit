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
@property (strong, readwrite, nonatomic) __kindof BaseTableModelRow *model;

// @xaoxuu: image
@property (strong, nonatomic) UIImage *icon;



@end

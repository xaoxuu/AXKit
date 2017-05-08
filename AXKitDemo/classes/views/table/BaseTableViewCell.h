//
//  BaseTableViewCell.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableModel.h"

@interface BaseTableViewCell : UITableViewCell

// @xaoxuu: model
@property (strong, nonatomic) BaseTableModel *model;

- (void)switchStatusChanged:(void (^)(BOOL on))changed;


@end

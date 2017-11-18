//
//  AXTableViewCell.h
//  AXTableKit
//
//  Created by xaoxuu on 27/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXTableModel.h"


@protocol AXTableViewCell <NSObject>
@required
/**
 cell必须要有数据模型
 
 @param model 数据模型
 */
- (void)setModel:(AXTableRowModelType *)model;
- (AXTableRowModelType *)model;

@optional
- (UIImageView *)icon;


@end
typedef UITableViewCell<AXTableViewCell> AXTableViewCellType;

@interface AXTableViewCell : AXTableViewCellType

// @xaoxuu: model
@property (strong, readwrite, nonatomic) NSObject<AXTableRowModel> *model;

// @xaoxuu: image
@property (strong, readonly, nonatomic) UIImageView *icon;

@end

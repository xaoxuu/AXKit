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

@protocol BaseTableViewCell <NSObject>
@required

/**
 cell必须要有数据模型

 @param model 数据模型
 */
- (void)setModel:(__kindof BaseTableModelRow *)model;
- (__kindof BaseTableModelRow *)model;

@optional

/**
 cell icon

 @param icon icon
 */
- (void)setIcon:(UIImage *)icon;
- (UIImage *)icon;

@end


@interface BaseTableViewCell : UITableViewCell <BaseTableViewCell>

// @xaoxuu: model
@property (strong, readwrite, nonatomic) __kindof BaseTableModelRow *model;

// @xaoxuu: image
@property (strong, nonatomic) UIImage *icon;



@end

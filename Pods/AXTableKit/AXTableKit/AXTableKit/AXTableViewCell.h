//
//  AXTableViewCell.h
//  AXTableKit
//
//  Created by xaoxuu on 27/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXTableModel.h"


@class AXTableViewCell;

@protocol AXTableViewCellDelegate <NSObject>

- (void)ax_tableViewCell:(AXTableViewCell *)cell needsLoadWebImageFromPath:(NSString *)path forImageView:(UIImageView *)imageView;

@end


@protocol AXTableViewCell <NSObject>
@required
/**
 cell必须要有数据模型
 
 @param model 数据模型
 */
- (void)setModel:(AXTableRowModelType *)model;
- (AXTableRowModelType *)model;
@optional

- (void)setDelegate:(NSObject<AXTableViewCellDelegate> *)delegate;
- (NSObject<AXTableViewCellDelegate> *)delegate;

@end
typedef UITableViewCell<AXTableViewCell> AXTableViewCellType;


@interface AXTableViewCell : AXTableViewCellType

// @xaoxuu: model
@property (strong, readwrite, nonatomic) NSObject<AXTableRowModel> *model;

/**
 delegate
 */
@property (weak, nonatomic) NSObject<AXTableViewCellDelegate> *delegate;

@end

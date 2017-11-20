//
//  ThemeCollectionViewCell.h
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeCollectionModel.h"


@interface ThemeCollectionViewCell : UICollectionViewCell

// @xaoxuu: model
@property (strong, nonatomic) ThemeCollectionRowModel *model;

@end

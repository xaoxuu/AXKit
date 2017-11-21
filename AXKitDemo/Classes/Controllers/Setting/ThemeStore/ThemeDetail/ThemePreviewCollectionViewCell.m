//
//  ThemePreviewCollectionViewCell.m
//  AXKitDemo
//
//  Created by xaoxuu on 21/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemePreviewCollectionViewCell.h"

@implementation ThemePreviewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.imgv.layer ax_shadow:LayerShadowDownFloat];
}

@end

//
//  FontTableViewCell.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FontTableViewCell.h"

@implementation FontTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(__kindof BaseTableModelRow *)model{
    AXLogFunc();
}

- (void)setIcon:(UIImage *)icon{
    AXLogFunc();
}

@end

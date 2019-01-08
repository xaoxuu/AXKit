//
//  FontTableViewCell.m
//  AXKitDemo
//
//  Created by xaoxuu on 20/11/2017.
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


- (UIFont *)fontForTitle{
    return [UIFont fontWithName:self.model.title size:axThemeManager.font.prefersFontSize];
}
- (UIFont *)fontForDetail{
    return [UIFont fontWithName:self.model.title size:12 * axThemeManager.font.prefersFontSize / 14];
}

@end

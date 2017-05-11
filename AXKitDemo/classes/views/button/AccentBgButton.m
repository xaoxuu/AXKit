//
//  AccentBgButton.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AccentBgButton.h"

@implementation AccentBgButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    
    self.backgroundColor = axColor.accent;
    UIColor *titleColor = axColor.white;
    if (axColor.theme.isLightColor) {
        titleColor = axColor.accent.dark;
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    
    
}

- (void)setNeedsLayout{
    [super setNeedsLayout];
    self.backgroundColor = axColor.accent;
    UIColor *titleColor = axColor.white;
    if (axColor.accent.isLightColor) {
        titleColor = axColor.accent.dark;
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];

}





@end

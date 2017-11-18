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
    
    
    self.backgroundColor = axThemeManager.color.accent;
    UIColor *titleColor = [UIColor whiteColor];
    if (axThemeManager.color.theme.isLightColor) {
        titleColor = axThemeManager.color.accent.dark;
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    
    
}

- (void)setNeedsLayout{
    [super setNeedsLayout];
    self.backgroundColor = axThemeManager.color.accent;
    UIColor *titleColor = [UIColor whiteColor];
    if (axThemeManager.color.accent.isLightColor) {
        titleColor = axThemeManager.color.accent.dark;
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];

}





@end

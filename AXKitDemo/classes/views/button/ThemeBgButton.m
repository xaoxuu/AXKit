//
//  ThemeBgButton.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeBgButton.h"

@implementation ThemeBgButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [self _initButton];
    
    
}

- (void)setNeedsLayout{
    [super setNeedsLayout];
    
    [self _initButton];
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    if (enabled) {
        self.alpha = 1;
    } else {
        self.alpha = 0.5;
    }
}


- (void)_initButton{
    self.backgroundColor = axColor.theme;
    UIColor *titleColor = axColor.white;
    if (axColor.theme.isLightColor) {
        titleColor = axColor.theme.dark;
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

@end

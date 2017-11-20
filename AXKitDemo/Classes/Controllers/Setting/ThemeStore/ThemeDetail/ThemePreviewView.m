//
//  ThemePreviewView.m
//  AXKitDemo
//
//  Created by xaoxuu on 20/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemePreviewView.h"

@interface ThemePreviewView ()
@property (weak, nonatomic) IBOutlet UIView *bg;

@property (weak, nonatomic) IBOutlet UIView *navBar;
@property (weak, nonatomic) IBOutlet UILabel *navTitle;

@property (weak, nonatomic) IBOutlet UITextView *content;

@property (weak, nonatomic) IBOutlet UIView *tabBar;

@end

@implementation ThemePreviewView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.height = 360;
    [self.bg.layer ax_shadow:LayerShadowDownFloat];
    [self.navBar.layer ax_shadow:LayerShadowDownNormal];
    [self.tabBar.layer ax_shadow:LayerShadowUpLight];
    
    self.model = axThemeManager;
    
}

- (void)setModel:(UIThemeModel *)model{
    _model = model;
    
    if (model) {
        self.bg.backgroundColor = model.color.background;
        self.navBar.backgroundColor = model.color.theme;
        if (model.color.theme.isLightColor) {
            self.navTitle.textColor = model.color.theme.adaptive;
        } else {
            self.navTitle.textColor = [UIColor whiteColor];
        }
        
        self.content.font = model.font.customNormal;
    }
    
    
}



@end

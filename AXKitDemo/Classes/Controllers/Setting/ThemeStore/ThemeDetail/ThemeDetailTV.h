//
//  ThemeDetailTV.h
//  AXKitDemo
//
//  Created by xaoxuu on 20/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AXTableKit.h"
#import "ThemeCollectionModel.h"

@interface ThemeDetailTV : AXTableView

@property (strong, nonatomic) UIThemeModel *theme;

- (void)updateWithTheme:(UIThemeModel *)theme;

@end

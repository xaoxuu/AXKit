//
//  ThemeDetailTV.h
//  AXKitDemo
//
//  Created by xaoxuu on 20/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseTableView.h"
#import "ThemeCollectionModel.h"

@interface ThemeDetailTV : BaseTableView

@property (strong, nonatomic) AXThemeModel *theme;

- (void)updateWithTheme:(AXThemeModel *)theme;

@end

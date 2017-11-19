//
//  BaseLabel.h
//  AXKit
//
//  Created by xaoxuu on 20/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLabel : UILabel


+ (instancetype)labelWithTitle:(NSString *)title;

+ (instancetype)labelWithTitle:(NSString *)title fontSize:(CGFloat)fontSize;


- (void)setupUI;


@end

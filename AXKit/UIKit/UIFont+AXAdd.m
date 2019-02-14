//
//  UIFont+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 2019/2/14.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

#import "UIFont+AXAdd.h"

@implementation UIFont (AXAdd)

- (UIFont *(^)(void))bold{
    return ^{
        UIFontDescriptor *fontDescriptor = [self fontDescriptor];
        UIFontDescriptorSymbolicTraits traits = fontDescriptor.symbolicTraits;
        traits = traits | UIFontDescriptorTraitBold;
        UIFontDescriptor *boldFontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:traits];
        return [UIFont fontWithDescriptor:boldFontDescriptor size:self.pointSize];
    };
}

@end

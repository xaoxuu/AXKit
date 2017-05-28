//
//  ThemeColorModel.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeColorModel.h"

@implementation ThemeColorModelRow

@end

@implementation ThemeColorModelSection

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rows":[ThemeColorModelRow class]};
}


@end

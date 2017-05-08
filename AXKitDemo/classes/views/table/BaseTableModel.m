//
//  BaseTableModel.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseTableModel.h"
#import "MJExtension.h"

@implementation BaseTableModel

@end

@implementation BaseTableModelList

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rows":[BaseTableModel class]};
}

@end

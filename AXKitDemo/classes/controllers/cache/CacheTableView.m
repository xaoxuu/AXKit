//
//  CacheTableView.m
//  AXKit
//
//  Created by xaoxuu on 11/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "CacheTableView.h"

@implementation CacheTableView


- (BaseTableModelListType)dataListForTableView:(UITableView *)tableView{
    return services.cache.cacheList;
}


@end

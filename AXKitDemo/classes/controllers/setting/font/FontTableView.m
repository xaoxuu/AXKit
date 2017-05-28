//
//  FontTableView.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FontTableView.h"
#import "FontTableViewCell.h"

@implementation FontTableView

- (void)setupTableViewDataSource:(void (^)(BaseTableModelListType))dataSource{
    
}

- (UITableViewCell<BaseTableViewCell> *)setupCustomTableViewCell{
    return [FontTableViewCell new];
}


@end

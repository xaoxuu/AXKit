//
//  GitHubIssueModel.m
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "GitHubIssueModel.h"
#import "GitHubLabelModel.h"


@implementation GitHubIssueListModel

- (instancetype)init{
    if (self = [super init]) {
        _items = [NSMutableArray array];
    }
    return self;
}


+ (instancetype)modelWithModelItems:(NSArray<GitHubIssueModel *> *)items{
    return [[self alloc] initWithModelItems:items];
}

- (instancetype)initWithModelItems:(NSArray<GitHubIssueModel *> *)items{
    if (self = [super init]) {
        _total_count = NSStringFromNSUInteger(items.count);
        _items = [NSMutableArray arrayWithArray:items];
    }
    return self;
}

- (void)setItems:(NSMutableArray<GitHubIssueModel *> *)items{
    for (NSMutableDictionary *dict in items) {
        GitHubIssueModel *model = [GitHubIssueModel modelWithDictionary:dict];
        [_items addObject:model];
    }
}



@end

@implementation GitHubIssueModel

- (instancetype)init{
    if (self = [super init]) {
        _labels = [NSMutableArray array];
    }
    return self;
}


- (void)setLabels:(NSMutableArray<GitHubLabelModel *> *)labels{
    for (NSMutableDictionary *dict in labels) {
        GitHubLabelModel *model = [GitHubLabelModel modelWithDictionary:dict];
        [_labels addObject:model];
    }
}

@end

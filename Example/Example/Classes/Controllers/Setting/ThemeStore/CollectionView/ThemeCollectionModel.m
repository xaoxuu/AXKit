//
//  ThemeCollectionModel.m
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ThemeCollectionModel.h"



@implementation ThemeCollectionModel

- (instancetype)init{
    if (self = [super init]) {
        _sections = [NSMutableArray array];
    }
    return self;
}

- (void)addSection:(void (^)(ThemeCollectionSectionModel *))section{
    ThemeCollectionSectionModel *model = [[ThemeCollectionSectionModel alloc] init];
    if (section) {
        section(model);
    }
    [self.sections addObject:model];
}

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    ThemeCollectionModel *model = [ThemeCollectionModel new];
    model.updateTime = [NSDate dateWithString:dict.stringForKey(@"update") format:@"yyyy-MM-dd HH:mm:ss"];
    NSArray<NSDictionary *> *sections = dict.arrayForKey(@"sections");
    [sections enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ThemeCollectionSectionModel *section = [ThemeCollectionSectionModel new];
        section.title = obj.stringForKey(@"title");
        NSArray<NSDictionary *> *themes = obj.arrayForKey(@"themes");
        [themes enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AXThemeModel *theme = [AXThemeModel modelWithDictionary:obj];
            [section.themes addObject:theme];
        }];
        [model.sections addObject:section];
    }];
    return model;
}



@end

@implementation ThemeCollectionSectionModel

- (instancetype)init{
    if (self = [super init]) {
        _themes = [NSMutableArray array];
    }
    return self;
}

- (void)addRow:(void (^)(AXThemeModel *))row{
    AXThemeModel *model = [[AXThemeModel alloc] init];
    if (row) {
        row(model);
    }
    [self.themes addObject:model];
}

@end


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
    model.updateTime = [NSDate dateWithString:[dict stringValueForKey:@"update"] format:@"yyyy-MM-dd HH:mm:ss"];
    NSMutableArray<ThemeCollectionSectionModel *> *sectionsArr = [NSMutableArray array];
    NSArray<NSDictionary *> *sections = [dict arrayValueForKey:@"sections"];
    [sections enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ThemeCollectionSectionModel *section = [ThemeCollectionSectionModel new];
        section.title = [obj stringValueForKey:@"title"];
        NSMutableArray<ThemeCollectionRowModel *> *themesArr = [NSMutableArray array];
        NSArray<NSDictionary *> *themes = [obj arrayValueForKey:@"themes"];
        [themes enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ThemeCollectionRowModel *theme = [ThemeCollectionRowModel new];
            theme.name = [obj stringValueForKey:@"name"];
            theme.author = [obj stringValueForKey:@"author"];
            theme.email = [obj stringValueForKey:@"email"];
            theme.image = [obj stringValueForKey:@"image"];
            theme.price = [obj doubleValueForKey:@"price"];
            [themesArr addObject:theme];
        }];
        section.themes = themesArr;
        [sectionsArr addObject:section];
    }];
    model.sections = sectionsArr;
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

- (void)addRow:(void (^)(ThemeCollectionRowModel *))row{
    ThemeCollectionRowModel *model = [[ThemeCollectionRowModel alloc] init];
    if (row) {
        row(model);
    }
    [self.themes addObject:model];
}

@end

@implementation ThemeCollectionRowModel

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

@end

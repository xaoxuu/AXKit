//
//  ThemeCollectionModel.h
//  AXKitDemo
//
//  Created by xaoxuu on 19/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ThemeCollectionSectionModel, ThemeCollectionRowModel;
@interface ThemeCollectionModel : NSObject


@property (strong, nonatomic) NSDate *updateTime;
@property (strong, nonatomic) NSMutableArray<ThemeCollectionSectionModel *> *sections;

- (void)addSection:(void (^)(ThemeCollectionSectionModel *section))section;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end

@interface ThemeCollectionSectionModel : NSObject

@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) NSMutableArray<UIThemeModel *> *themes;

- (void)addRow:(void (^)(UIThemeModel *row))row;

@end



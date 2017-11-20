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

@property (strong, nonatomic) NSMutableArray<ThemeCollectionRowModel *> *themes;

- (void)addRow:(void (^)(ThemeCollectionRowModel *row))row;

@end

@interface ThemeCollectionRowModel : NSObject

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *author;

@property (copy, nonatomic) NSString *email;

@property (copy, nonatomic) NSString *image;

@property (assign, nonatomic) CGFloat price;

@end

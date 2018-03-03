//
//  AXTableModel.m
//  AXTableKit
//
//  Created by xaoxuu on 27/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import "AXTableModel.h"
#import "NSDictionary+AXExtension.h"

@implementation AXTableModel

- (instancetype)init{
    if (self = [super init]) {
        _title = @"";
//        _headerTitle = @"";
//        _headerHeight = 0;
//        _footerTitle = @"";
//        _footerHeight = -1; // 小于0的值系统会按默认行高处理
        _sections = [NSMutableArray array];
    }
    return self;
}

- (void)addSection:(void (^)(AXTableSectionModel *))section{
    AXTableSectionModel *model = [[AXTableSectionModel alloc] init];
    if (section) {
        section(model);
    }
    [self.sections addObject:model];
}


+ (instancetype)modelWithDictionary:(NSDictionary *)dict{
    AXTableModel *model = [[AXTableModel alloc] init];
    if (dict) {
        model.title = [dict stringValueForKey:@"title"];
//        model.headerTitle = [dict stringValueForKey:@"headerTitle"];
//        model.headerHeight = [dict doubleValueForKey:@"headerHeight"];
//        model.footerTitle = [dict stringValueForKey:@"footerTitle"];
//        model.footerHeight = [dict doubleValueForKey:@"footerHeight"];
        NSArray<NSDictionary *> *sections = [dict arrayValueForKey:@"sections"];
        [sections enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [model.sections addObject:[AXTableSectionModel modelWithDictionary:obj]];
        }];
    }
    return model;
}

@end

@implementation AXTableSectionModel

- (instancetype)init{
    if (self = [super init]) {
        _headerTitle = @"";
        _headerHeight = -1;// 小于0的值系统会按默认行高处理
        _footerTitle = @"";
        _footerHeight = 0;
        _rowHeight = -1;// 小于0的值系统会按默认行高处理
        _rows = [NSMutableArray array];
    }
    return self;
}


- (void)addRow:(void (^)(AXTableRowModel *))row{
    AXTableRowModel *model = [[AXTableRowModel alloc] init];
    if (row) {
        row(model);
    }
    [self.rows addObject:model];
}


+ (instancetype)modelWithDictionary:(NSDictionary *)dict{
    AXTableSectionModel *model = [[AXTableSectionModel alloc] init];
    if (dict) {
        model.headerTitle = [dict stringValueForKey:@"headerTitle"];
        model.headerHeight = [dict doubleValueForKey:@"headerHeight"];
        model.footerTitle = [dict stringValueForKey:@"footerTitle"];
        model.footerHeight = [dict doubleValueForKey:@"footerHeight"];
        model.rowHeight = [dict doubleValueForKey:@"rowHeight"];
        NSArray<NSDictionary *> *rows = [dict arrayValueForKey:@"rows"];
        [rows enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [model.rows addObject:[AXTableRowModel modelWithDictionary:obj]];
        }];
    }
    return model;
}

@end

@implementation AXTableRowModel

- (instancetype)init{
    if (self = [super init]) {
        _title = @"";
        _detail = @"";
        _icon = @"";
        _target = @"";
        _rowHeight = -1; // 小于0的值系统会按默认行高处理
        self.cmd = @"";
        _accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}


+ (instancetype)modelWithDictionary:(NSDictionary *)dict{
    AXTableRowModel *model = [[AXTableRowModel alloc] init];
    if (dict) {
        model.title = [dict stringValueForKey:@"title"];
        model.detail = [dict stringValueForKey:@"detail"];
        model.icon = [dict stringValueForKey:@"icon"];
        model.target = [dict stringValueForKey:@"target"];
        model.cmd = [dict stringValueForKey:@"cmd"];
        CGFloat rowHeight = [dict doubleValueForKey:@"rowHeight"];
        if (rowHeight) {
            model.rowHeight = rowHeight;
        }
        if (model.target.length) {
            model.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            model.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return model;
}

@end

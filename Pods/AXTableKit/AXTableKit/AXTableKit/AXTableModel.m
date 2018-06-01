//
//  AXTableModel.m
//  AXTableKit
//
//  Created by xaoxuu on 27/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import "AXTableModel.h"

//static inline NSDictionary *dictionaryValueForKey(NSDictionary *dict, NSString *key){
//    NSObject *obj = dict[key];
//    if ([obj isKindOfClass:[NSDictionary class]]) {
//        return (NSDictionary *)obj;
//    } else if ([obj isKindOfClass:[NSString class]]) {
//        NSString *strValue = (NSString *)obj;
//        NSData *data = [strValue dataUsingEncoding:NSUTF8StringEncoding];
//        if (data) {
//            return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        } else {
//            return [NSDictionary dictionary];
//        }
//    } else {
//        return [NSDictionary dictionary];
//    }
//}

static inline NSArray *arrayValueForKey(NSDictionary *dict, NSString *key){
    NSObject *obj = dict[key];
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        NSData *data = [strValue dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        } else {
            return [NSArray array];
        }
    } else {
        return [NSArray array];
    }
}

static inline NSString *stringValueForKey(NSDictionary *dict, NSString *key){
    NSObject *obj = dict[key];
    if ([obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    } else {
        return @"";
    }
}
static inline NSNumber *numberValueForKey(NSDictionary *dict, NSString *key){
    NSObject *obj = dict[key];
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        return @(strValue.doubleValue);
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)obj;
    } else {
        return @0;
    }
}


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
        model.title = stringValueForKey(dict, @"title");
//        model.headerTitle = [dict stringValueForKey:@"headerTitle"];
//        model.headerHeight = [dict doubleValueForKey:@"headerHeight"];
//        model.footerTitle = [dict stringValueForKey:@"footerTitle"];
//        model.footerHeight = [dict doubleValueForKey:@"footerHeight"];
        NSArray<NSDictionary *> *sections = arrayValueForKey(dict, @"sections");
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
        model.headerTitle = stringValueForKey(dict, @"headerTitle");
        model.headerHeight = numberValueForKey(dict, @"headerHeight").doubleValue;
        model.footerTitle = stringValueForKey(dict, @"footerTitle");
        model.footerHeight = numberValueForKey(dict, @"footerHeight").doubleValue;
        model.rowHeight = numberValueForKey(dict, @"rowHeight").doubleValue;
        NSArray<NSDictionary *> *rows = arrayValueForKey(dict, @"rows");
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
        model.title = stringValueForKey(dict, @"title");
        model.detail = stringValueForKey(dict, @"detail");
        model.icon = stringValueForKey(dict, @"icon");
        model.target = stringValueForKey(dict, @"target");
        model.cmd = stringValueForKey(dict, @"cmd");
        CGFloat rowHeight = numberValueForKey(dict, @"rowHeight").doubleValue;
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

//
//  BaseTableModel.m
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseTableModel.h"
#import "MJExtension.h"

@implementation BaseTableModelRow


- (instancetype)init{
    if (self = [super init]) {
        _title = @"";
        _desc = @"";
        _icon = @"";
        _target = @"default";
        self.cmd = @"";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.target forKey:@"target"];
    [aCoder encodeObject:self.cmd forKey:@"cmd"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
        self.icon = [aDecoder decodeObjectForKey:@"icon"];
        self.target = [aDecoder decodeObjectForKey:@"target"];
        self.cmd = [aDecoder decodeObjectForKey:@"cmd"];
    }
    return self;
}


@end

@implementation BaseTableModelSection

- (instancetype)init{
    if (self = [super init]) {
        _header_title = @"";
        _header_height = @"32";
        _footer_title = @"";
        _footer_height = @"8";
        _rowHeight = @"44";
        _rows = [NSMutableArray array];
    }
    return self;
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rows":[BaseTableModelRow class]};
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.header_title forKey:@"header_title"];
    [aCoder encodeObject:self.header_height forKey:@"header_height"];
    [aCoder encodeObject:self.footer_title forKey:@"footer_title"];
    [aCoder encodeObject:self.footer_height forKey:@"footer_height"];
    [aCoder encodeObject:self.rowHeight forKey:@"rowHeight"];
    [aCoder encodeObject:self.rows forKey:@"rows"];
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.header_title = [aDecoder decodeObjectForKey:@"header_title"];
        self.header_height = [aDecoder decodeObjectForKey:@"header_height"];
        self.footer_title = [aDecoder decodeObjectForKey:@"footer_title"];
        self.footer_height = [aDecoder decodeObjectForKey:@"footer_height"];
        self.rowHeight = [aDecoder decodeObjectForKey:@"rowHeight"];
        self.rows = [aDecoder decodeObjectForKey:@"rows"];
    }
    return self;
}

@end

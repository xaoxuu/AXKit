//
//  AXThemeModel.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AXThemeModel.h"


NSString *ThemeKitBundleIdentify = @"com.xaoxuu.AXKit.theme";

static CGFloat standardSize = 14.0f;
static CGFloat smallSize = 12.0f;


static inline NSDictionary *dictionaryValueForKey(NSDictionary *dict, NSString *key){
    NSObject *obj = dict[key];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)obj;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *strValue = (NSString *)obj;
        NSData *data = [strValue dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        } else {
            return [NSDictionary dictionary];
        }
    } else {
        return [NSDictionary dictionary];
    }
}

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



static inline NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    str = [[str stringByTrimmingCharactersInSet:set] lowercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0x"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

static inline UIColor *colorWithHexString(NSString *hexStr){
    CGFloat r, g, b, a;
    if (hexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

static inline UIColor *darken(UIColor *color, CGFloat ratio){
    CGFloat red = 0.0,green = 0.0,blue = 0.0, alpha = 1.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    red   = red   * (1 - ratio);
    green = green * (1 - ratio);
    blue  = blue  * (1 - ratio);
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

static inline NSString *hexStringWithAlpha(UIColor *color0){
    CGColorRef color = color0.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex) {
        hex = [hex stringByAppendingFormat:@"%02lx",
               (unsigned long)(CGColorGetAlpha(color0.CGColor) * 255.0 + 0.5)];
    }
    return hex;
}

@implementation AXThemeModel

+ (instancetype)modelWithEmail:(NSString *)email name:(NSString *)name{
    NSString *path = [self filePathWithEmail:email name:name];
    return [self modelWithPath:path];
}

+ (instancetype)modelWithPath:(NSString *)path{
    return [[self alloc] initWithPath:path];
}

- (instancetype)initWithPath:(NSString *)path{
    NSData *data = [NSData dataWithContentsOfFile:path];
#if DEBUG
    NSParameterAssert(data != nil);
#endif
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return [self initWithDictionary:dictionary];
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        NSDictionary *info = dictionaryValueForKey(dictionary, @"info");
        self.info = [UIThemeInfoModel modelWithDictionary:info];
        NSDictionary *color = dictionaryValueForKey(dictionary, @"color");
        self.color = [UIThemeColorModel modelWithDictionary:color];
        NSDictionary *font = dictionaryValueForKey(dictionary, @"font");
        self.font = [UIThemeFontModel modelWithDictionary:font];
        NSDictionary *icon = dictionaryValueForKey(dictionary, @"icon");
        self.icon = [UIThemeIconModel modelWithDictionary:icon];
    }
    return self;
}

- (NSDictionary *)dictionaryWithModel{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"info"] = [self.info dictionaryWithModel];
    dict[@"color"] = [self.color dictionaryWithModel];
    dict[@"font"] = [self.font dictionaryWithModel];
    dict[@"icon"] = [self.icon dictionaryWithModel];
    return dict;
}


- (NSString *)filePath{
    return [AXThemeModel filePathWithEmail:self.info.email name:self.info.name];
}
- (NSString *)identifier{
    return [AXThemeModel identifierWithEmail:self.info.email name:self.info.name];
}


+ (NSString *)identifierWithEmail:(NSString *)email name:(NSString *)name{
    return [NSString stringWithFormat:@"%@/%@.json", email, name];
}
+ (NSString *)filePathWithIdentifier:(NSString *)identifier{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:ThemeKitBundleIdentify];
    path = [path stringByAppendingPathComponent:identifier];
    return path;
}
+ (NSString *)filePathWithEmail:(NSString *)email name:(NSString *)name{
    return [self filePathWithIdentifier:[self identifierWithEmail:email name:name]];
}


@end
@implementation UIThemeColorModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [self init]) {
        NSString *background = stringValueForKey(dictionary, @"background");
        NSString *theme = stringValueForKey(dictionary, @"theme");
        NSString *accent = stringValueForKey(dictionary, @"accent");
        NSString *groupTableViewBackground = stringValueForKey(dictionary, @"groupTableViewBackground");
        NSString *separatorColor = stringValueForKey(dictionary, @"separatorColor");
        
        if (background.length) {
            self.background = colorWithHexString(background);
        } else {
            self.background = [UIColor whiteColor];
        }
        self.theme = colorWithHexString(theme);
        self.accent = colorWithHexString(accent);
        
        if (groupTableViewBackground.length) {
            self.groupTableViewBackground = colorWithHexString(groupTableViewBackground);
        } else {
            self.groupTableViewBackground = [UIColor groupTableViewBackgroundColor];
        }
        if (separatorColor.length) {
            self.separatorColor = colorWithHexString(separatorColor);
        } else {
            self.separatorColor = darken(self.groupTableViewBackground, 0.08);
        }
        
    }
    return self;
}

- (NSDictionary *)dictionaryWithModel{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"background"] = hexStringWithAlpha(self.background);
    dict[@"theme"] = hexStringWithAlpha(self.theme);
    dict[@"accent"] = hexStringWithAlpha(self.accent);
    dict[@"groupTableViewBackground"] = hexStringWithAlpha(self.groupTableViewBackground);
    dict[@"separatorColor"] = hexStringWithAlpha(self.separatorColor);
    
    return dict;
}

- (UIColor *)background{
    if (!_background) {
        _background = [UIColor whiteColor];
    }
    return _background;
}
- (UIColor *)theme{
    if (!_theme) {
        _theme = [UIColor blueColor];
    }
    return _theme;
}
- (UIColor *)accent{
    if (!_accent) {
        _accent = [UIColor orangeColor];
    }
    return _accent;
}
- (UIColor *)groupTableViewBackground{
    if (!_groupTableViewBackground) {
        _groupTableViewBackground = [UIColor groupTableViewBackgroundColor];
    }
    return _groupTableViewBackground;
}
- (UIColor *)separatorColor{
    if (!_separatorColor) {
        _separatorColor = darken(self.groupTableViewBackground, 0.08);
    }
    return _separatorColor;
}

@end
@implementation UIThemeFontModel


- (void)setPrefersFontSize:(CGFloat)prefersFontSize{
    _prefersFontSize = prefersFontSize;
    [self updateFont];
}

- (void)setName:(NSString *)name{
    _name = name;
    [self updateFont];
}

- (void)updateFont{
    CGFloat ratio = self.prefersFontSize / standardSize;
    
    if (self.name.length) {
        _customSmall = [UIFont fontWithName:self.name size:smallSize * ratio];
        _customBoldSmall = [UIFont fontWithName:self.name size:smallSize * ratio];
        _customNormal = [UIFont fontWithName:self.name size:standardSize * ratio];
        _customBoldNormal = [UIFont fontWithName:self.name size:standardSize * ratio];
        _customLarge = [UIFont fontWithName:self.name size:standardSize * 1.2 * ratio];
        _customBoldLarge = [UIFont fontWithName:self.name size:standardSize * 1.2 * ratio];
    } else {
        _customSmall = [UIFont systemFontOfSize:smallSize * ratio];
        _customBoldSmall = [UIFont boldSystemFontOfSize:smallSize * ratio];
        _customNormal = [UIFont systemFontOfSize:standardSize * ratio];
        _customBoldNormal = [UIFont boldSystemFontOfSize:standardSize * ratio];
        _customLarge = [UIFont systemFontOfSize:standardSize * 1.2 * ratio];
        _customBoldLarge = [UIFont boldSystemFontOfSize:standardSize * 1.2 * ratio];
    }
    
}

- (UIFont *)fontWithCustomPrefersFontSize:(CGFloat)size{
    CGFloat ratio = size / standardSize;
    return [UIFont fontWithName:self.name size:standardSize * ratio];
}
- (UIFont *)boldFontWithCustomPrefersFontSize:(CGFloat)size{
    CGFloat ratio = size / standardSize;
    return [UIFont boldSystemFontOfSize:standardSize * ratio];
}


+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [self init]) {
        self.name = stringValueForKey(dictionary, @"name");
        CGFloat prefersFontSize = numberValueForKey(dictionary, @"prefersFontSize").doubleValue;
        if (prefersFontSize) {
            self.prefersFontSize = prefersFontSize;
        }
        
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        
        // init
        CGFloat small = [UIFont smallSystemFontSize]; //12
        CGFloat standard = [UIFont systemFontSize]; //14
        
        _systemSmall = [UIFont systemFontOfSize:small];
        _systemNormal = [UIFont systemFontOfSize:standard];
        self.prefersFontSize = standard;
        
    }
    return self;
}


- (NSDictionary *)dictionaryWithModel{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"prefersFontSize"] = @(self.prefersFontSize);
    dict[@"name"] = self.name;
    
    return dict;
}

@end
@implementation UIThemeIconModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [self init]) {
        self.dict = dictionary;
    }
    return self;
}


- (NSDictionary *)dictionaryWithModel{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//    dict[@"name"] = self.info.name;
//    dict[@"author"] = self.info.author;
//    dict[@"email"] = self.info.email;
//    dict[@"price"] = @(self.info.price);
//    dict[@"preview"] = self.info.preview;
    
    return self.dict;
}


@end
@implementation UIThemeInfoModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [self init]) {
        self.name = stringValueForKey(dictionary, @"name");
        self.author = stringValueForKey(dictionary, @"author");
        self.email = stringValueForKey(dictionary, @"email");
        self.price = numberValueForKey(dictionary, @"price").doubleValue;
        self.preview = arrayValueForKey(dictionary, @"preview");
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        _preview = [NSArray array];
    }
    return self;
}


- (NSDictionary *)dictionaryWithModel{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"name"] = self.name;
    dict[@"author"] = self.author;
    dict[@"email"] = self.email;
    dict[@"price"] = @(self.price);
    dict[@"preview"] = self.preview;
    
    return dict;
}

@end

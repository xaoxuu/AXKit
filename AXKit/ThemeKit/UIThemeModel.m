//
//  UIThemeModel.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIThemeModel.h"
#import "_AXKitBundle.h"
#import "NSDictionary+AXExtension.h"
#import "UIColor+AXExtension.h"
#import "NSString+AXFileStreamChainedWrapper.h"
#import "NSUserDefaults+AXWrapper.h"

NSString *ThemeKitBundleIdentify = @"com.xaoxuu.AXKit.theme";

NSString *ThemeKitNotificationColorChanged = @"com.xaoxuu.AXKit.theme.notification.ColorChanged";
NSString *ThemeKitNotificationFontChanged = @"com.xaoxuu.AXKit.theme.notification.FontChanged";
NSString *ThemeKitNotificationIconPackChanged = @"com.xaoxuu.AXKit.theme.notification.IconPackChanged";

static CGFloat standardSize = 14.0f;
static CGFloat smallSize = 12.0f;



@implementation UIThemeModel

+ (instancetype)modelWithEmail:(NSString *)email name:(NSString *)name{
    NSString *path = [self filePathWithEmail:email name:name];
    return [self modelWithPath:path];
}

+ (instancetype)modelWithPath:(NSString *)path{
    return [[self alloc] initWithPath:path];
}

- (instancetype)initWithPath:(NSString *)path{
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSAssert(data != nil, @"The theme file is missing.");
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return [self initWithDictionary:dictionary];
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        self.name = [dictionary stringValueForKey:@"name"];
        self.author = [dictionary stringValueForKey:@"author"];
        self.email = [dictionary stringValueForKey:@"email"];
        self.price = [dictionary doubleValueForKey:@"price"];
        
        NSDictionary *color = [dictionary dictionaryValueForKey:@"color"];
        self.color = [UIThemeColorModel modelWithDictionary:color];
        NSDictionary *font = [dictionary dictionaryValueForKey:@"font"];
        self.font = [UIThemeFontModel modelWithDictionary:font];
        NSDictionary *icon = [dictionary dictionaryValueForKey:@"icon"];
        self.icon = [UIThemeIconModel modelWithDictionary:icon];
    }
    return self;
}

- (NSMutableDictionary *)dictionaryWithModel{
    NSMutableDictionary *jsonFile = [NSMutableDictionary dictionary];
    jsonFile[@"name"] = self.name;
    jsonFile[@"author"] = self.author;
    jsonFile[@"email"] = self.email;
    jsonFile[@"price"] = @(self.price);
    
    NSMutableDictionary *colorDict = [NSMutableDictionary dictionary];
    colorDict[@"background"] = self.color.background.hexStringWithAlpha;
    colorDict[@"theme"] = self.color.theme.hexStringWithAlpha;
    colorDict[@"accent"] = self.color.accent.hexStringWithAlpha;
    colorDict[@"groupTableViewBackground"] = self.color.groupTableViewBackground.hexStringWithAlpha;
    colorDict[@"separatorColor"] = self.color.separatorColor.hexStringWithAlpha;
    jsonFile[@"color"] = colorDict;
    
    NSMutableDictionary *fontDict = [NSMutableDictionary dictionary];
    fontDict[@"prefersFontSize"] = @(self.font.prefersFontSize);
    fontDict[@"name"] = self.font.name;
    jsonFile[@"font"] = fontDict;
    
    NSMutableDictionary *iconDict = [NSMutableDictionary dictionary];
    jsonFile[@"icon"] = iconDict;
    return jsonFile;
}

- (void)saveCurrentTheme{
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:[self dictionaryWithModel] options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [UIThemeModel filePathWithEmail:self.email name:self.name].saveFile(jsonString);
    
    [NSUserDefaults ax_setString:[UIThemeModel identifierWithEmail:self.email name:self.name] forKey:ThemeKitBundleIdentify];
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeKitNotificationColorChanged object:nil];
}

- (void)deleteThemeFile{
    [UIThemeModel filePathWithEmail:self.email name:self.name].removeFile();
}

+ (void)deleteAllThemes{
    [UIThemeModel filePathWithIdentifier:@""].removeFile();
}

+ (NSString *)identifierWithEmail:(NSString *)email name:(NSString *)name{
    return [NSString stringWithFormat:@"%@/%@.json", email, name];
}
+ (NSString *)filePathWithIdentifier:(NSString *)identifier{
    return ThemeKitBundleIdentify.appendPathComponent(identifier).docPath;
}
+ (NSString *)filePathWithEmail:(NSString *)email name:(NSString *)name{
    return [self filePathWithIdentifier:[self identifierWithEmail:email name:name]];
}
+ (NSArray<UIThemeModel *> *)getAllDownloadedThemes{
    NSMutableArray<UIThemeModel *> *models = [NSMutableArray array];
    [ThemeKitBundleIdentify.docPath.subpaths(@"json") enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIThemeModel *model = [UIThemeModel modelWithPath:obj];
        [models addObject:model];
    }];
    return models;
}

@end
@implementation UIThemeColorModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [self init]) {
        NSString *background = [dictionary stringValueForKey:@"background"];
        NSString *theme = [dictionary stringValueForKey:@"theme"];
        NSString *accent = [dictionary stringValueForKey:@"accent"];
        NSString *groupTableViewBackground = [dictionary stringValueForKey:@"groupTableViewBackground"];
        NSString *separatorColor = [dictionary stringValueForKey:@"separatorColor"];
        
        if (background.length) {
            self.background = [UIColor colorWithHexString:background];
        } else {
            self.background = [UIColor whiteColor];
        }
        self.theme = [UIColor colorWithHexString:theme];
        self.accent = [UIColor colorWithHexString:accent];
        
        if (groupTableViewBackground.length) {
            self.groupTableViewBackground = [UIColor colorWithHexString:groupTableViewBackground];
        } else {
            self.groupTableViewBackground = [UIColor groupTableViewBackgroundColor];
        }
        if (separatorColor.length) {
            self.separatorColor = [UIColor colorWithHexString:separatorColor];
        } else {
            self.separatorColor = self.groupTableViewBackground.darkRatio(0.08);
        }
        
    }
    return self;
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
        _separatorColor = self.groupTableViewBackground.darkRatio(0.08);
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
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeKitNotificationFontChanged object:@YES];
}

- (UIFont *)fontWithCustomPrefersFontSize:(CGFloat)size{
    CGFloat ratio = size / standardSize;
    return [UIFont systemFontOfSize:standardSize * ratio];
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
        self.name = [dictionary stringValueForKey:@"name"];
        CGFloat prefersFontSize = [dictionary doubleValueForKey:@"prefersFontSize"];
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
@end

//
//  AXTableModel.h
//  AXTableKit
//
//  Created by xaoxuu on 27/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AXTableSectionModel,AXTableRowModel;

@protocol AXTableRowModel <NSObject>
@required
- (NSString *)title;

- (NSString *)detail;

- (NSString *)icon;

- (NSString *)target;
- (NSString *)cmd;

@optional
- (CGFloat)rowHeight;
- (UITableViewCellAccessoryType)accessoryType;
- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType;

@end

typedef NSObject<AXTableRowModel> AXTableRowModelType;

@protocol AXTableSectionModel <NSObject>
@required

- (NSMutableArray<AXTableRowModelType *> *)rows;

@optional
- (NSString *)headerTitle;
- (CGFloat)headerHeight;

- (NSString *)footerTitle;
- (CGFloat)footerHeight;

- (CGFloat)rowHeight;

@end
typedef NSObject<AXTableSectionModel> AXTableSectionModelType;

@protocol AXTableModel <NSObject>
@required

- (NSMutableArray<AXTableSectionModelType *> *)sections;

@end
typedef NSObject<AXTableModel> AXTableModelType;


@interface AXTableModel : NSObject <AXTableModel>

/**
 TableView的标题
 */
@property (copy, nonatomic) NSString *title;

/**
 TableView的sections
 */
@property (strong, nonatomic) NSMutableArray<AXTableSectionModel *> *sections;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

/**
 添加一个section
 
 @param section section
 */
- (void)addSection:(void (^)(AXTableSectionModel *section))section;


@end


@interface AXTableSectionModel : NSObject <AXTableSectionModel>

/**
 header title
 */
@property (copy, nonatomic) NSString *headerTitle;

/**
 header height
 */
@property (assign, nonatomic) CGFloat headerHeight;

/**
 footer title
 */
@property (copy, nonatomic) NSString *footerTitle;

/**
 footer height
 */
@property (assign, nonatomic) CGFloat footerHeight;

/**
 row height 行高
 */
@property (assign, nonatomic) CGFloat rowHeight;

/**
 rows
 */
@property (strong, nonatomic) NSMutableArray<AXTableRowModel *> *rows;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

/**
 添加一个row
 
 @param row row
 */
- (void)addRow:(void (^)(AXTableRowModel *row))row;

@end


@interface AXTableRowModel : NSObject <AXTableRowModel>

/**
 title
 */
@property (copy, nonatomic) NSString *title;

/**
 detail
 */
@property (copy, nonatomic) NSString *detail;

/**
 icon名，可以是Assets.xcassets中的icon名，也可以是bundle中的icon的路径，也可以是网络icon路径
 */
@property (copy, nonatomic) NSString *icon;

/**
 要跳转的地方，可以是ViewController的名字，也可以是一个网址
 */
@property (copy, nonatomic) NSString *target;

/**
 命令字符串，可以传递任何值或命令，需要自行解析
 */
@property (copy, nonatomic) NSString *cmd;

/**
 row height
 */
@property (assign, nonatomic) CGFloat rowHeight;

/**
 accessory
 */
@property (assign, nonatomic) UITableViewCellAccessoryType accessoryType;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end

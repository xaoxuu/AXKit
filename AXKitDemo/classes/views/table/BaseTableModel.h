//
//  BaseTableModel.h
//  AXKit
//
//  Created by xaoxuu on 07/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTableModel : NSObject

#pragma mark ui
// @xaoxuu: title
@property (copy, nonatomic) NSString *title;
// @xaoxuu: detail
@property (copy, nonatomic) NSString *desc;
// @xaoxuu: icon path(支持本地图片和网络图片)
@property (copy, nonatomic) NSString *icon;


#pragma mark action
// @xaoxuu: 跳转到某控制器
@property (copy, nonatomic) NSString *target;
// @xaoxuu: 命令
@property (copy, nonatomic) NSString *cmd;

@end

@interface BaseTableModelList : NSObject

// @xaoxuu: header_title
@property (copy, nonatomic) NSString *header_title;
// @xaoxuu: header_height
@property (copy, nonatomic) NSString *header_height;
// @xaoxuu: footer_title
@property (copy, nonatomic) NSString *footer_title;
// @xaoxuu: footer_height
@property (copy, nonatomic) NSString *footer_height;
// @xaoxuu: rowHeight
@property (copy, nonatomic) NSString *rowHeight;
// @xaoxuu: rows
@property (strong, nonatomic) NSArray<__kindof BaseTableModel *> *rows;


@end

//
//  EmailAttachmentDataSource.h
//  AXKit
//
//  Created by xaoxuu on 05/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface EmailAttachmentDataSource : NSObject


/**
 文件路径（必填）
 */
@property (copy, nonatomic) NSString *filePath;

/**
 文件mime类型（可选）
 */
@property (copy, nonatomic) NSString *mimeType;

/**
 文件名（可选，默认为实体文件名）
 */
@property (copy, nonatomic) NSString *fileName;


+ (instancetype)attachmentDataSourceWithFilePath:(NSString *)filePath mimeType:(nullable NSString *)mimeType fileName:(nullable NSString *)fileName;


@end
NS_ASSUME_NONNULL_END

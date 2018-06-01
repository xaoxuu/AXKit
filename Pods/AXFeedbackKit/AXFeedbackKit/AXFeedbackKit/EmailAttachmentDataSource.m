//
//  EmailAttachmentDataSource.m
//  AXKit
//
//  Created by xaoxuu on 05/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "EmailAttachmentDataSource.h"

@implementation EmailAttachmentDataSource

+ (instancetype)attachmentDataSourceWithFilePath:(NSString *)filePath mimeType:(NSString *)mimeType fileName:(NSString *)fileName{
    EmailAttachmentDataSource *model = [[EmailAttachmentDataSource alloc] init];
    model.filePath = filePath;
    model.mimeType = mimeType;
    model.fileName = fileName;
    return model;
}

@end

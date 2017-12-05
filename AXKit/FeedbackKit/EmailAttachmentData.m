//
//  EmailAttachmentData.m
//  AXKit
//
//  Created by xaoxuu on 05/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "EmailAttachmentData.h"

@implementation EmailAttachmentData

+ (instancetype)attachmentDataWithData:(NSData *)attachment mimeType:(NSString *)mimeType fileName:(NSString *)filename{
    EmailAttachmentData *model = [[EmailAttachmentData alloc] init];
    model.data = attachment;
    model.mimeType = mimeType;
    model.fileName = filename;
    return model;
}

@end

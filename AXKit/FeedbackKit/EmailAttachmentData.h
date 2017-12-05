//
//  EmailAttachmentData.h
//  AXKit
//
//  Created by xaoxuu on 05/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmailAttachmentData : NSObject

@property (strong, nonatomic) NSData *data;
@property (copy, nonatomic) NSString *mimeType;
@property (copy, nonatomic) NSString *fileName;

+ (instancetype)attachmentDataWithData:(NSData *)attachment mimeType:(NSString *)mimeType fileName:(NSString *)filename;

@end

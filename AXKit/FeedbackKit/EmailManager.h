//
//  EmailManager.h
//  AXKit
//
//  Created by xaoxuu on 04/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmailAttachmentData.h"
#import <MessageUI/MessageUI.h>

@interface EmailManager : NSObject <MFMailComposeViewControllerDelegate>


/**
 默认的收件人
 */
@property (strong, nonatomic) NSArray<NSString *> *defaultToRecipients;

/**
 默认的抄送
 */
@property (strong, nonatomic) NSArray<NSString *> *defaultCcRecipients;

/**
 默认的密送
 */
@property (strong, nonatomic) NSArray<NSString *> *defaultBccRecipients;


/**
 默认的主题
 */
@property (copy, nonatomic) NSString *defaultSubject;

/**
 默认的body
 */
@property (copy, nonatomic) NSString *defaultMessageBody;

/**
 默认的附件
 */
@property (strong, nonatomic) NSMutableArray<EmailAttachmentData *> *defaultAttachmentData;



#pragma mark - life circle

+ (instancetype)sharedInstance;

+ (instancetype)defaultManager;


/**
 配置默认compose

 @param defaultCompose 默认的compose
 */
- (void)configDefaultCompose:(void (^)(EmailManager *manager))defaultCompose;

/**
 添加默认的附件

 @param attachment 附件
 @param mimeType 附件类型
 @param filename 文件名
 */
- (void)addDefaultAttachmentData:(NSData *)attachment mimeType:(NSString *)mimeType fileName:(NSString *)filename;

/**
 发送邮件

 @param email 邮件内容
 @param completion 发送完成回调
 @param fail 发送失败回调
 */
- (void)sendEmail:(void (^)(MFMailComposeViewController *mailCompose))email completion:(void (^)(MFMailComposeResult result))completion fail:(void (^)(NSError *error))fail;


@end

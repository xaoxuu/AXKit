//
//  EmailManager.h
//  AXKit
//
//  Created by xaoxuu on 04/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmailAttachmentDataSource.h"
#import <MessageUI/MessageUI.h>

NS_ASSUME_NONNULL_BEGIN
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
 附件源（可提前设置好，但直到发送文件的时候才从路径中取出文件）
 */
@property (strong, nonatomic) NSMutableArray<EmailAttachmentDataSource *> *attachmentDataSource;



#pragma mark - life circle

+ (instancetype)sharedInstance;

+ (instancetype)defaultManager;


/**
 配置默认compose

 @param defaultCompose 默认的compose
 */
- (void)configDefaultCompose:(void (^)(EmailManager *manager))defaultCompose;

/**
 添加附件源
 可提前设置好，但直到发送文件的时候才从路径中取出文件。
 
 @param filePath 文件路径
 @param mimeType 文件类型
 @param fileName 文件名
 */
- (void)addAttachmentDataSourceWithFilePath:(NSString *)filePath mimeType:(nullable NSString *)mimeType fileName:(nullable NSString *)fileName;

/**
 发送邮件

 @param email 邮件内容
 @param completion 发送完成回调
 @param fail 发送失败回调
 */
- (void)sendEmail:(void (^)(MFMailComposeViewController *mailCompose))email completion:(void (^)(MFMailComposeResult result))completion fail:(void (^)(NSError *error))fail;


@end
NS_ASSUME_NONNULL_END

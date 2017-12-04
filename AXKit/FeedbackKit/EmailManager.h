//
//  EmailManager.h
//  AXKit
//
//  Created by xaoxuu on 04/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
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
 默认的body
 */
@property (copy, nonatomic) NSString *defaultMessageBody;


#pragma mark - life circle

+ (instancetype)sharedInstance;

+ (instancetype)defaultManager;


/**
 发送邮件

 @param email 邮件内容
 @param completion 发送完成回调
 @param fail 发送失败回调
 */
- (void)sendEmail:(void (^)(MFMailComposeViewController *mailCompose))email completion:(void (^)(MFMailComposeResult result))completion fail:(void (^)(NSError *error))fail;


@end

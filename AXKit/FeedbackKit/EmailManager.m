//
//  EmailManager.m
//  AXKit
//
//  Created by xaoxuu on 04/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "EmailManager.h"
#import "NSError+AXExtension.h"
#import "UIResponder+AXExtension.h"

typedef void(^BlockType)(MFMailComposeResult);
EmailManager *manager = nil;


@interface EmailManager()

@property (copy, nonatomic) BlockType block_callback;


@end


@implementation EmailManager


#pragma mark - life circle

// defaultManager
+ (instancetype)defaultManager{
    return [self sharedInstance];
}

// sharedInstance
+ (instancetype)sharedInstance{
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (!manager) {
                manager = [[self alloc] init];
                // init settings
                
            }
        });
    }
    return manager;
}

- (NSMutableArray<EmailAttachmentData *> *)defaultAttachmentData{
    if (!_defaultAttachmentData) {
        _defaultAttachmentData = [NSMutableArray array];
    }
    return _defaultAttachmentData;
}

#pragma mark - public func

/**
 配置默认compose
 
 @param defaultCompose 默认的compose
 */
- (void)configDefaultCompose:(void (^)(EmailManager *))defaultCompose{
    if (defaultCompose) {
        defaultCompose(self);
    }
}

/**
 添加默认的附件
 
 @param attachment 附件
 @param mimeType 附件类型
 @param filename 文件名
 */
- (void)addDefaultAttachmentData:(NSData *)attachment mimeType:(NSString *)mimeType fileName:(NSString *)filename{
    [self.defaultAttachmentData addObject:[EmailAttachmentData attachmentDataWithData:attachment mimeType:mimeType fileName:filename]];
}

/**
 发送邮件
 
 @param email 邮件内容
 @param completion 发送完成回调
 @param fail 发送失败回调
 */
- (void)sendEmail:(void (^)(MFMailComposeViewController *mailCompose))email completion:(void (^)(MFMailComposeResult result))completion fail:(void (^)(NSError *error))fail{
    if (![MFMailComposeViewController canSendMail]) {
        if (fail) {
            NSError *error = [NSError ax_errorWithMaker:^(NSErrorMaker * _Nonnull error) {
                error.domain = @"com.MFMailComposeViewController.error";
                error.localizedFailureReason = @"your device not support";
            }];
            fail(error);
        }
    } else {
        MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
        [mailCompose setMailComposeDelegate:self];
        
        // default
        [mailCompose setToRecipients:self.defaultToRecipients];
        [mailCompose setCcRecipients:self.defaultCcRecipients];
        [mailCompose setBccRecipients:self.defaultBccRecipients];
        [mailCompose setSubject:self.defaultSubject];
        
        if (self.defaultMessageBody.length) {
            [mailCompose setMessageBody:self.defaultMessageBody isHTML:NO];
        }
        
        [self.defaultAttachmentData enumerateObjectsUsingBlock:^(EmailAttachmentData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [mailCompose addAttachmentData:obj.data mimeType:obj.mimeType fileName:obj.fileName];
        }];
        
        // callback
        if (email) {
            email(mailCompose);
        }
        self.block_callback = completion;
        [AXRootViewController() presentViewController:mailCompose animated:YES completion:nil];
    }
}


- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
#if DEBUG
    switch (result) {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: \n%@", error.localizedDescription);
            break;
    }
#endif
    if (self.block_callback) {
        self.block_callback(result);
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end

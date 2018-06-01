//
//  EmailManager.m
//  AXKit
//
//  Created by xaoxuu on 04/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "EmailManager.h"


static inline NSError *errorWith(NSString *desc){
    return [NSError errorWithDomain:@"com.xaoxuu.error" code:0 userInfo:@{NSLocalizedDescriptionKey:desc}];
}

static inline UIViewController *sRootViewController(){
    UIResponder *appDelegate = (UIResponder *)[UIApplication sharedApplication].delegate;
    return (UIViewController *)[appDelegate valueForKeyPath:@"window.rootViewController"];
}


// -------

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

- (NSMutableArray<EmailAttachmentDataSource *> *)attachmentDataSource{
    if (!_attachmentDataSource) {
        _attachmentDataSource = [NSMutableArray array];
    }
    return _attachmentDataSource;
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
 添加附件源
 可提前设置好，但直到发送文件的时候才从路径中取出文件。
 
 @param filePath 文件路径
 @param mimeType 文件类型
 @param fileName 文件名
 */
- (void)addAttachmentDataSourceWithFilePath:(NSString *)filePath mimeType:(nullable NSString *)mimeType fileName:(nullable NSString *)fileName{
    [self.attachmentDataSource addObject:[EmailAttachmentDataSource attachmentDataSourceWithFilePath:filePath mimeType:mimeType fileName:fileName]];
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
//            NSError *error = [NSError ax_errorWithMaker:^(NSErrorMaker * _Nonnull error) {
//                error.domain = @"com.MFMailComposeViewController.error";
//                error.localizedFailureReason = @"your device not support";
//            }];
            fail(errorWith(@"your device not support"));
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
        
        // callback
        if (email) {
            email(mailCompose);
        }
        
        [self.attachmentDataSource enumerateObjectsUsingBlock:^(EmailAttachmentDataSource * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *data = [NSData dataWithContentsOfFile:obj.filePath];
            if (data.length) { // 如果有data.length==0的文件加进去，MFMailComposeViewController会自动dismiss
                NSString *fileName = obj.fileName;
                if (!fileName.length) {
                    fileName = obj.filePath.lastPathComponent;
                }
                [mailCompose addAttachmentData:data mimeType:obj.mimeType?:@"" fileName:fileName];
            }
        }];
        
        self.block_callback = completion;
        [sRootViewController() presentViewController:mailCompose animated:YES completion:nil];
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

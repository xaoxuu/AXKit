//
//  UIViewController+AXMailWrapper.m
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIViewController+AXMailWrapper.h"
#import "NSError+AXExtension.h"

static void (^block_callback)(MFMailComposeResult result);

@implementation UIViewController (AXMailWrapper)

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
        // 邮件服务器
        MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
        // 设置邮件代理
        [mailCompose setMailComposeDelegate:self];
        if (email) {
            email(mailCompose);
        }
        block_callback = completion;
        [self presentViewController:mailCompose animated:YES completion:nil];
    }
}


- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    switch (result)
    {
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
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    if (block_callback) {
        block_callback(result);
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end


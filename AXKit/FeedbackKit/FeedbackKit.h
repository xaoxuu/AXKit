//
//  FeedbackKit.h
//  AXKit
//
//  Created by xaoxuu on 18/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface UIViewController (AXMailWrapper) <MFMailComposeViewControllerDelegate>


/**
 发送Email

 @param email email
 @param completion 发送完成
 @param fail 发送失败
 */
- (void)sendEmail:(void (^)(MFMailComposeViewController *mailCompose))email completion:(void (^)(MFMailComposeResult result))completion fail:(void (^)(NSError *error))fail;


@end


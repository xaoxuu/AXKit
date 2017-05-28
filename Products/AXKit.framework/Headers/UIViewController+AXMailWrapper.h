//
//  UIViewController+AXMailWrapper.h
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface UIViewController (AXMailWrapper) <MFMailComposeViewControllerDelegate>


- (void)sendEmail:(void (^)(MFMailComposeViewController *mailCompose))email completion:(void (^)(MFMailComposeResult result))completion fail:(void (^)(NSError *error))fail;


@end

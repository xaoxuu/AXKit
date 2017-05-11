//
//  AlertServices.h
//  AXKit
//
//  Created by xaoxuu on 10/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"

@interface AlertServices : BaseServices

- (void)alertForConfirmTheme:(UIColor *)color message:(NSString *)msg completion:(void (^)())completion;

- (void)alertForOptionDoneWithMessage:(NSString *)msg;


- (void)hideAlertView;

@end

//
//  UIViewController+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 17/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIViewController+AXExtension.h"
#import "UIResponder+AXExtension.h"
#import "NSError+AXExtension.h"

@implementation UIViewController (AXExtension)

- (void)ax_pushViewControllerNamed:(NSString *)vcName animated:(BOOL)animated{
    [self ax_pushViewControllerNamed:vcName animated:animated completion:^(UIViewController * _Nonnull targetVC) {
        // @xaoxuu: do nothing.
    } fail:^(NSError * _Nonnull error) {
        // @xaoxuu: do nothing.
    }];
}

- (void)ax_pushViewControllerNamed:(NSString *)vcName animated:(BOOL)animated completion:(void (^)(UIViewController *targetVC))completion{
    [self ax_pushViewControllerNamed:vcName animated:animated completion:completion fail:^(NSError * _Nonnull error) {
        // @xaoxuu: do nothing.
    }];
}

- (void)ax_pushViewControllerNamed:(NSString *)vcName animated:(BOOL)animated completion:(void (^)(UIViewController *targetVC))completion fail:(void (^)(NSError *error))fail{
    UIViewController *vc = [[NSClassFromString(vcName) class] new];
    if (vc && self.navigationController) {
        [self.navigationController pushViewController:vc animated:animated];
        if (completion) {
            completion(vc);
        }
    } else {
        NSMutableString *reason = [NSMutableString stringWithString:@"\n"];
        if (!vc) {
            [reason appendString:@"\'targetVC\' not found.\n"];
        }
        if (!self.navigationController) {
            [reason appendString:@"\'self\' is not a navigation controller.\n"];
            
        }
        NSError *error = [NSError ax_errorWithDomain:ERROR_DEFAULT_DOMAIN code:AXErrorCodePushNavVC description:nil reason:reason suggestion:nil];
        if (fail && error) {
            fail(error);
        }
    }
}

@end

//
//  AXKitHelpServices.m
//  AXKit
//
//  Created by xaoxuu on 17/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "_AXKitError.h"
#import "NSError+AXExtension.h"
#import "UIAlertController+AXWrapper.h"
#import "UIApplication+AXExtension.h"

NSErrorDomain const AXKitErrorDomain = @"com.xaoxuu.axkit.error";

static NSString const *AXKitErrorBaseURL = @"https://github.com/xaoxuu/AXKit/issues";

static NSURL *urlForCode(NSInteger code){
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", AXKitErrorBaseURL, @(code)]];
}

@implementation NSError (AXKitHelpExtension)

- (NSURL *)URL{
    return urlForCode(self.code);
}

+ (instancetype)axkit_errorWithCode:(NSInteger)code reason:(nullable NSString *(^)(void))reason{
    NSError *error = [self ax_errorWithMaker:^(NSErrorMaker * _Nonnull error) {
        error.domain = AXKitErrorDomain;
        error.code = code;
        error.localizedFailureReason = reason?reason():@"";
        error.localizedRecoverySuggestion = [NSString stringWithFormat:@"See more at: %@", urlForCode(code)];
    }];
    NSString *msg = nil;
    if (reason) {
        msg = reason();
    }
    return error;
}

@end

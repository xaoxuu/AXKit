//
//  NSError+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSError+AXExtension.h"

static NSErrorDomain userErrorDomain = @"unknown";

@implementation NSError (AXExtension)

+ (void)configErrorDomain:(NSErrorDomain)domain{
    userErrorDomain = domain;
}

+ (instancetype)ax_errorWithDomain:(NSErrorDomain (^)())domain
                              code:(NSInteger)code
                       description:(nullable NSString *(^)())description
                            reason:(nullable NSString *(^)())reason
                        suggestion:(nullable NSString *(^)())suggestion{
    return [[self alloc] ax_initWithDomain:domain code:code description:description reason:reason suggestion:suggestion];
}


- (instancetype)ax_initWithDomain:(NSErrorDomain (^)())domain
                             code:(NSInteger)code
                      description:(nullable NSString *(^)())description
                           reason:(nullable NSString *(^)())reason
                       suggestion:(nullable NSString *(^)())suggestion{
    NSString *desc = nil;
    NSString *reas = nil;
    NSString *sugg = nil;
    
    if (description) {
        desc = description();
    }
    if (reason) {
        reas = reason();
    }
    if (suggestion) {
        sugg = suggestion();
    }
    desc = desc ? : ERROR_DEFAULT_DESCRIPTION;
    reas = reas.length?reas:ERROR_DEFAULT_REASON;
    sugg  = sugg  ? : ERROR_DEFAULT_SUGGESTION;
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey:NSLocalizedString(desc, nil),
                               NSLocalizedFailureReasonErrorKey:NSLocalizedString(reas, nil),
                               NSLocalizedRecoverySuggestionErrorKey:NSLocalizedString(sugg, nil),
                               };
    NSError *error = [NSError errorWithDomain:domain()?:@"unknown" code:code userInfo:userInfo];
    return error;
}

@end



//
//  NSError+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSError+AXExtension.h"

@implementation NSError (AXExtension)

+ (instancetype)ax_errorWithDomain:(NSErrorDomain)domain code:(NSInteger)code description:(nullable NSString *)description reason:(NSString *)reason suggestion:(nullable NSString *)suggestion{
    return [[self alloc] ax_initWithDomain:domain code:code description:description reason:reason suggestion:suggestion];
}

- (instancetype)ax_initWithDomain:(NSErrorDomain)domain code:(NSInteger)code description:(nullable NSString *)description reason:(NSString *)reason suggestion:(nullable NSString *)suggestion{
    description = description ? : ERROR_DEFAULT_DESCRIPTION;
    reason = reason.length?reason:ERROR_DEFAULT_REASON;
    suggestion  = suggestion  ? : ERROR_DEFAULT_SUGGESTION;
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey:NSLocalizedString(description, nil),
                               NSLocalizedFailureReasonErrorKey:NSLocalizedString(reason, nil),
                               NSLocalizedRecoverySuggestionErrorKey:NSLocalizedString(suggestion, nil),
                               };
    NSError *error = [NSError errorWithDomain:domain code:code userInfo:userInfo];
    return error;
}

@end

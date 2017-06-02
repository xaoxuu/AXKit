//
//  NSError+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSError+AXExtension.h"

@implementation NSError (AXExtension)


+ (instancetype)ax_errorWithMaker:(void (^)(NSErrorMaker * _Nonnull))maker{
    NSErrorMaker *make = [NSErrorMaker new];
    if (maker) {
        maker(make);
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (make.localizedDescription) {
        userInfo[NSLocalizedDescriptionKey] = make.localizedDescription;
    }
    if (make.localizedFailureReason) {
        userInfo[NSLocalizedFailureReasonErrorKey] = make.localizedFailureReason;
    }
    if (make.localizedRecoverySuggestion) {
        userInfo[NSLocalizedRecoverySuggestionErrorKey] = make.localizedRecoverySuggestion;
    }
    if (make.localizedRecoveryOptions.count) {
        userInfo[NSLocalizedRecoveryOptionsErrorKey] = make.localizedRecoveryOptions;
    }
    
    NSError *error = [NSError errorWithDomain:make.domain?:@"unknown" code:make.code userInfo:userInfo];
    return error;
}


- (NSString *)description{
    NSMutableString *desc = [NSMutableString string];
    [desc appendFormat:@"domain:      %@", self.domain];
    [desc appendFormat:@"\ncode:        %ld",self.code];
    if (self.localizedDescription) {
        [desc appendFormat:@"\ndescription: %@",self.localizedDescription];
    }
    if (self.localizedFailureReason) {
        [desc appendFormat:@"\nreason:      %@",self.localizedFailureReason];
    }
    if (self.localizedRecoverySuggestion) {
        [desc appendFormat:@"\nsuggestion:  %@",self.localizedRecoverySuggestion];
    }
    if (self.localizedRecoveryOptions.count) {
        [desc appendFormat:@"\noptions:     %@",self.localizedRecoveryOptions];
    }
    return desc;
}

@end


@implementation NSErrorMaker

- (instancetype)init{
    if (self = [super init]) {
        _localizedRecoveryOptions = [NSMutableArray array];
    }
    return self;
}

@end



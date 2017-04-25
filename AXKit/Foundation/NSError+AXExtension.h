//
//  NSError+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ERROR_DEFAULT_DOMAIN @"com.xaoxuu.axkit.error"
#define ERROR_DEFAULT_DESCRIPTION @"Operation fail"
#define ERROR_DEFAULT_REASON @"Unknown reason"
#define ERROR_DEFAULT_SUGGESTION @"You'd better check your code."

typedef NS_ENUM(NSUInteger, AXErrorCode) {
    AXErrorCodePushNavVC,
    
};


NS_ASSUME_NONNULL_BEGIN

@interface NSError (AXExtension)

+ (instancetype)ax_errorWithDomain:(NSErrorDomain)domain code:(NSInteger)code description:(nullable NSString *)description reason:(NSString *)reason suggestion:(nullable NSString *)suggestion;

@end

NS_ASSUME_NONNULL_END

//
//  AXKitHelpServices.h
//  AXKit
//
//  Created by xaoxuu on 17/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const AXKitErrorDomain;

// @xaoxuu: AXKit错误码（注意：错误码的枚举值和GitHub issues的id一致）
// @xaoxuu: https://github.com/xaoxuu/AXKit/issues/错误码
typedef NS_ENUM(NSUInteger, AXKitErrorCode) {
    AXKitErrorCodePushNavVC = 16,
    
    AXKitErrorCodeObjectForKeyNotFound = 17,
    
};

@interface NSError (AXKitHelpAdd)

/**
 错误信息的URL

 @return URL
 */
- (NSURL *)URL;

/**
 创建一个Error对象错误原因以及帮助信息网址

 @param code 错误码
 @param reason 原因
 @return Error实例
 */
+ (instancetype)axkit_errorWithCode:(NSInteger)code reason:(nullable NSString *(^)(void))reason;


@end
NS_ASSUME_NONNULL_END

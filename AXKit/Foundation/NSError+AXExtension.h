//
//  NSError+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ERROR_DEFAULT_DESCRIPTION @"Operation fail"
#define ERROR_DEFAULT_REASON @"Unknown reason"
#define ERROR_DEFAULT_SUGGESTION @"You'd better check your code."



@interface NSError (AXExtension)


/**
 创建一个error实例
 
 @param domain 域
 @param code 错误码
 @param description 描述
 @param reason 原因
 @param suggestion 建议
 @return error实例
 */
+ (instancetype)ax_errorWithDomain:(NSErrorDomain (^)())domain
                              code:(NSInteger)code
                       description:(nullable NSString *(^)())description
                            reason:(nullable NSString *(^)())reason
                        suggestion:(nullable NSString *(^)())suggestion;


@end

NS_ASSUME_NONNULL_END

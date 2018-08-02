//
//  NSError+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ERROR_DEFAULT_DESCRIPTION @"Operation failure"
#define ERROR_DEFAULT_REASON @"Unknown reason"
#define ERROR_DEFAULT_SUGGESTION @"You'd better check your code."


@class NSErrorMaker;
@interface NSError (AXAdd)


/**
 快速创建一个error

 @param maker error构造器
 @return error
 */
+ (instancetype)ax_errorWithMaker:(void (^)(NSErrorMaker *error))maker;


@end

@interface NSErrorMaker : NSObject


// @xaoxuu: NSErrorDomain
@property (copy, nonatomic) NSErrorDomain domain;
// @xaoxuu: error code
@property (assign, nonatomic) NSInteger code;


// @xaoxuu: description
@property (copy, nonatomic) NSString *localizedDescription;
// @xaoxuu: reason
@property (copy, nonatomic) NSString *localizedFailureReason;
// @xaoxuu: LocalizedRecoverySuggestion
@property (copy, nonatomic) NSString *localizedRecoverySuggestion;
// @xaoxuu: localizedRecoveryOptions
@property (strong, nonatomic) NSMutableArray<NSString *> *localizedRecoveryOptions;

@end

NS_ASSUME_NONNULL_END

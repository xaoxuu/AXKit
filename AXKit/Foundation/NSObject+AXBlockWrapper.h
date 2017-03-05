//
//  NSObject+AXBlockWrapper.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef __nonnull id <NSObject, NSCopying> AXOperationToken;

@interface NSObject (AXBlockWrapper)


- (AXOperationToken)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(id obj))action;


+ (AXOperationToken)ax_delay:(NSTimeInterval)delay performInMainQueue:(void (^)(void))action;



- (AXOperationToken)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(id obj))action;


+ (AXOperationToken)ax_delay:(NSTimeInterval)delay performInBackground:(void (^)(void))action;


- (AXOperationToken)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(id obj))action;


+ (AXOperationToken)ax_delay:(NSTimeInterval)delay queue:(dispatch_queue_t)queue perform:(void (^)(void))action;


+ (void)ax_cancelOperation:(AXOperationToken)token;

@end

NS_ASSUME_NONNULL_END

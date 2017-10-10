//
//  NSArray+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 03/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


FOUNDATION_EXTERN NSArray *NSClassGetAllSubclasses(Class cls);


@interface NSArray (AXExtension)


/**
 总和

 @return 总和
 */
- (CGFloat)ax_sum;

/**
 平均值

 @return 平均值
 */
- (CGFloat)ax_avg;


/**
 最大值

 @return 最大值
 */
- (CGFloat)ax_max;


/**
 最小值

 @return 最小值
 */
- (CGFloat)ax_min;

/**
 去重后的数组

 @return 去重后的数组
 */
- (instancetype)distinctUnionOfObjects;

@end


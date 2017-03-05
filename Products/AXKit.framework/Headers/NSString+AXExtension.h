//
//  NSString+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Foundation+CoreGraphics.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - get a string from ...


FOUNDATION_EXTERN NSString *NSStringFromInt32(int x);


FOUNDATION_EXTERN NSString *NSStringFromNSInteger(NSInteger x);


FOUNDATION_EXTERN NSString *NSStringFromNSUInteger(NSUInteger x);


FOUNDATION_EXTERN NSString *NSStringFromCGFloat(CGFloat x);


FOUNDATION_EXTERN NSString *NSStringFromPointer(id x);

typedef NS_ENUM(NSUInteger, AXRandomStringType){
    AXRandomName,
    AXRandomPassword,
    
    AXRandomLowerString,
    AXRandomUpperString,
    AXRandomCapitalizeString,
};


FOUNDATION_EXTERN NSString *NSStringFromRandom(AXRandomStringType type, AXUIntegerRange length);

@interface NSString (AXRandomExtension)


+ (NSString *)ax_stringWithRandomNameWithLength:(AXUIntegerRange)length;


+ (NSString *)ax_stringWithRandomPasswordWithLength:(AXUIntegerRange)length;


+ (NSString *)ax_stringWithRandomLowerStringWithLength:(AXUIntegerRange)length;


+ (NSString *)ax_stringWithRandomUpperStringWithLength:(AXUIntegerRange)length;


+ (NSString *)ax_stringWithRandomCapitalizeStringWithLength:(AXUIntegerRange)length;

@end

NS_ASSUME_NONNULL_END



//
//  Foundation+AXLogExtension.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#ifdef __OBJC__ // ==================== [ __OBJC__ Macro ] ==================== //
#ifdef DEBUG // ==================== [ DEBUG Macro ] ==================== //


#define AXLogFormat(format, ...) NSLog((@"\n➤ func:%s " "line:%d" "\n💬" format "\n\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define AXLogFunc() NSLog((@"\n➤ func:%s " "line:%d" "\n\n"), __FUNCTION__, __LINE__)


// result macro
#define AXLogBOOL(BOOL) NSLog((@"\n➤ func:%s " "line:%d" "\n%@" "\n\n"), __FUNCTION__, __LINE__, BOOL ? @"🔵true" : @"🔴false")

#define AXLogSuccess(format, ...) NSLog((@"\n➤ func:%s " "line:%d" "\n🔵success: " format "\n\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define AXLogWarning(format, ...) NSLog((@"\n➤ func:%s" " line:%d" "\n⚠️warning: " format "\n\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define AXLogFail(format, ...) NSLog((@"\n➤ func:%s " "line:%d" "\n🔴error: " format "\n\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define AXLogError(NSError) NSLog((@"\n➤ func:%s " "line:%d" "\n🔴error: \n%@" "\n\n"), __FUNCTION__, __LINE__, NSError.description)


// obj macro
#define AXLogOBJ(NSObject) NSLog((@"\n➤ func:%s " "line:%d" "\n💬%@" "\n\n"), __FUNCTION__, __LINE__, NSObject)


// CG macro
#define AXLogInt(int) NSLog((@"\n➤ func:%s " "line:%d" "\n💬%@" "\n\n"), __FUNCTION__, __LINE__, @(int))
#define AXLogNSInteger(NSInteger) NSLog((@"\n➤ func:%s " "line:%d" "\n💬%@" "\n\n"), __FUNCTION__, __LINE__, @(NSInteger))
#define AXLogNSUInteger(NSUInteger) NSLog((@"\n➤ func:%s " "line:%d" "\n💬%@" "\n\n"), __FUNCTION__, __LINE__, @(NSUInteger))

#define AXLogFloat(float) NSLog((@"\n➤ func:%s " "line:%d" "\n💬%@" "\n\n"), __FUNCTION__, __LINE__, @(float))
#define AXLogCGFloat(CGFloat) NSLog((@"\n➤ func:%s " "line:%d" "\n💬%@" "\n\n"), __FUNCTION__, __LINE__, @(CGFloat))
#define AXLogCGPoint(CGPoint) NSLog((@"\n➤ func:%s " "line:%d" "\n💬CGPoint: %@" "\n\n"), __FUNCTION__, __LINE__, NSStringFromCGPoint(CGPoint))

#define AXLogCGSize(CGSize) NSLog((@"\n➤ func:%s " "line:%d" "\n💬CGSize: %@" "\n\n"), __FUNCTION__, __LINE__, NSStringFromCGSize(CGSize))
#define AXLogCGRect(CGRect) NSLog((@"\n➤ func:%s " "line:%d" "\n💬CGRect: %@" "\n\n"), __FUNCTION__, __LINE__, NSStringFromCGRect(CGRect))


#else

#define AXLogFormat(format, ...)
#define AXLogFunc()
// result macro
#define AXLogBOOL(BOOL)
#define AXLogSuccess(format, ...)
#define AXLogWarning(format, ...)
#define AXLogFail(format, ...)
#define AXLogError(NSError)
// obj macro
#define AXLogOBJ(NSObject)
// CG macro
#define AXLogInt(int)
#define AXLogNSInteger(NSInteger)
#define AXLogNSUInteger(NSUInteger)
#define AXLogFloat(float)
#define AXLogCGFloat(CGFloat)
#define AXLogCGPoint(CGPoint)
#define AXLogCGSize(CGSize)
#define AXLogCGRect(CGRect)


#endif // ==================== [ DEBUG Macro ] ==================== //

#else
#endif // ==================== [ __OBJC__ Macro ] ==================== //


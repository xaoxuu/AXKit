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


#define AXLog(format, ...) NSLog((@"\nfunc:%s" "line:%d\n" "💬" format "\n\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define AXLogFunc NSLog((@"\nfunc:%s" "line:%d\n" "\n"), __FUNCTION__, __LINE__)


// result macro
#define AXLogBOOL(BOOL) NSLog((@"\nfunc:%s" "line:%d\n" "%@" "\n\n"), __FUNCTION__, __LINE__, BOOL ? @"🔵Success" : @"🔴Fail")

#define AXLogSuccess(format, ...) NSLog((@"\nfunc:%s" "line:%d\n" "🔵success: " format "\n\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define AXLogFail(format, ...) NSLog((@"\nfunc:%s" "line:%d\n" "🔴error: " format "\n\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define AXLogError(NSError) NSLog((@"\nfunc:%s" "line:%d\n" "🔴%@" "\n\n"), __FUNCTION__, __LINE__, NSError.localizedDescription)


// obj macro
#define AXLogOBJ(NSObject) NSLog((@"\nfunc:%s" "line:%d\n" "💬%@" "\n\n"), __FUNCTION__, __LINE__, NSObject)


// CG macro
#define AXLogNSInteger(NSInteger) NSLog((@"\nfunc:%s" "line:%d\n" "💬%ld" "\n\n"), __FUNCTION__, __LINE__, NSInteger)
#define AXLogNSUInteger(NSUInteger) NSLog((@"\nfunc:%s" "line:%d\n" "💬%lld" "\n\n"), __FUNCTION__, __LINE__, NSUInteger)

#define AXLogCGFloat(CGFloat) NSLog((@"\nfunc:%s" "line:%d\n" "💬%f" "\n\n"), __FUNCTION__, __LINE__, CGFloat)
#define AXLogCGPoint(CGPoint) NSLog((@"\nfunc:%s" "line:%d\n" "💬%@" "\n\n"), __FUNCTION__, __LINE__, NSStringFromCGPoint(CGPoint))

#define AXLogCGSize(CGSize) NSLog((@"\nfunc:%s" "line:%d\n" "💬%@" "\n\n"), __FUNCTION__, __LINE__, NSStringFromCGSize(CGSize))
#define AXLogCGRect(CGRect) NSLog((@"\nfunc:%s" "line:%d\n" "💬%@" "\n\n"), __FUNCTION__, __LINE__, NSStringFromCGRect(CGRect))


#else

#define AXLog(format, ...)
#define AXLogFunc
// result macro
#define AXLogBOOL(BOOL)
#define AXLogSuccess(format, ...)
#define AXLogFail(format, ...)
#define AXLogError(NSError)
// obj macro
#define AXLogOBJ(NSObject)
// CG macro
#define AXLogNSInteger(NSInteger)
#define AXLogNSUInteger(NSUInteger)
#define AXLogCGFloat(CGFloat)
#define AXLogCGPoint(CGPoint)
#define AXLogCGSize(CGSize)
#define AXLogCGRect(CGRect)


#endif // ==================== [ DEBUG Macro ] ==================== //

#else
#endif // ==================== [ __OBJC__ Macro ] ==================== //






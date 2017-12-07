//
//  UIScreen+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 07/12/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 屏幕尺寸
 
 UIScreenSizeUnknown: 未知
 UIScreenSize_3_5: 3.5英寸屏幕：1、2、3、3g、3gs、4、4s
 UIScreenSize_4_0: 4.0英寸屏幕：5、5c、5s
 UIScreenSize_4_7: 4.7英寸屏幕：6、6s、7、8
 UIScreenSize_5_5: 5.5英寸屏幕：6 plus、6s plus、7 plus、8 plus
 UIScreenSize_5_8: 5.8英寸屏幕：iPhone X
 */
typedef NS_ENUM(NSUInteger, UIScreenSize) {
    UIScreenSizeUnknown,
    UIScreenSize_3_5,
    UIScreenSize_4_0,
    UIScreenSize_4_7,
    UIScreenSize_5_5,
    UIScreenSize_5_8
};

@interface UIScreen (AXExtension)

+ (UIScreenSize)screenSize;



@end

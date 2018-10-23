//
//  CoreGraphics+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#import <UIKit/UIKit.h>

#pragma mark - 常量


/**
 屏幕尺寸枚举
 
 kCGScreenSizeEnumUnknown: 未知
 kCGScreenSizeEnum_3_5: 3.5英寸屏幕：1、2、3、3G、3GS、4、4s
 kCGScreenSizeEnum_4_0: 4.0英寸屏幕：5、5c、5s
 kCGScreenSizeEnum_4_7: 4.7英寸屏幕：6、6s、7、8
 kCGScreenSizeEnum_5_5: 5.5英寸屏幕：6 Plus、6s Plus、7 Plus、8 Plus
 kCGScreenSizeEnum_5_8: 5.8英寸屏幕：X、XS
 kCGScreenSizeEnum_6_1: 6.1英寸屏幕：XR
 kCGScreenSizeEnum_6_5: 6.5英寸屏幕：XS Max
 */
typedef NS_ENUM(NSUInteger, kCGScreenSizeEnum) {
    kCGScreenSizeEnumUnknown = 0,
    kCGScreenSizeEnum_3_5 = 1,
    kCGScreenSizeEnum_4_0 = 2,
    kCGScreenSizeEnum_4_7 = 3,
    kCGScreenSizeEnum_5_5 = 4,
    kCGScreenSizeEnum_5_8 = 10,
    kCGScreenSizeEnum_6_1 = 11,
    kCGScreenSizeEnum_6_5 = 12
};

/**
 获取当前屏幕尺寸枚举

 @return 当前屏幕尺寸枚举
 */
CG_EXTERN kCGScreenSizeEnum CGConstGetScreenSizeEnum(void);

/**
 当前屏幕CGRect
 
 @return 当前屏幕CGRect
 */
CG_EXTERN CGRect CGConstGetScreenBounds(void);
#ifndef kScreenBounds
#define kScreenBounds CGConstGetScreenBounds()
#endif

/**
 当前屏幕尺寸

 @return 当前屏幕尺寸
 */
CG_EXTERN CGSize CGConstGetScreenSize(void);
#ifndef kScreenSize
#define kScreenSize CGConstGetScreenSize()
#endif
#ifndef kScreenW
#define kScreenW CGConstGetScreenSize().width
#endif
#ifndef kScreenH
#define kScreenH CGConstGetScreenSize().height
#endif


/**
 当前屏幕中心点坐标

 @return 当前屏幕中心点坐标
 */
CG_EXTERN CGPoint CGConstGetScreenCenter(void);
#ifndef kScreenCenter
#define kScreenCenter CGConstGetScreenCenter()
#endif
#ifndef kScreenCenterX
#define kScreenCenterX (0.5 * kScreenW)
#endif
#ifndef kScreenCenterY
#define kScreenCenterY (0.5 * kScreenH)
#endif

/**
 状态栏高度

 @return 状态栏高度
 */
CG_EXTERN CGFloat CGConstGetStatusBarHeight(void);
#ifndef kStatusBarHeight
#define kStatusBarHeight CGConstGetStatusBarHeight()
#endif

/**
 导航栏高度
 */
CG_EXTERN const CGFloat kNavBarHeight;

/**
 状态栏+导航栏高度
 
 @return 状态栏+导航栏高度
 */
CG_EXTERN CGFloat CGConstGetTopBarHeight(void);
#ifndef kTopBarHeight
#define kTopBarHeight CGConstGetTopBarHeight()
#endif

/**
 底部安全区域高度（iPhone X为34，其他机型为0）

 @return 底部安全区域高度（iPhone X为34，其他机型为0）
 */
CG_EXTERN CGFloat CGConstGetScreenBottomSafeAreaHeight(void);
#ifndef kScreenBottomSafeAreaHeight
#define kScreenBottomSafeAreaHeight CGConstGetScreenBottomSafeAreaHeight()
#endif

/**
 tabbar高度

 @return tabbar高度
 */
CG_EXTERN CGFloat CGConstGetTabBarHeight(void);
#ifndef kTabBarHeight
#define kTabBarHeight CGConstGetTabBarHeight()
#endif

/**
 系统弹窗的宽度
 */
CG_EXTERN const CGFloat kAlertViewWidth;




#pragma mark 取值范围类型定义

/**
 Float类型的取值范围（最小值，最大值）
 */
struct AXFloatRange{
    CGFloat minValue;
    CGFloat maxValue;
};
typedef struct AXFloatRange AXFloatRange;


/**
 NSUInteger类型的取值范围（最小值，最大值）
 */
struct AXIntegerRange {
    NSInteger minValue;
    NSInteger maxValue;
};

typedef struct AXIntegerRange AXIntegerRange;



/**
 NSUInteger类型的取值范围（最小值，最大值）
 */
struct AXUIntegerRange {
    NSUInteger minValue;
    NSUInteger maxValue;
};

typedef struct AXUIntegerRange AXUIntegerRange;



#pragma mark 取值范围创建


/**
 产生一个Float取值范围
 
 @param minValue 最小Float值
 @param maxValue 最大Float值
 @return Float范围
 */
CG_EXTERN AXFloatRange AXFloatRangeMake(CGFloat minValue, CGFloat maxValue);

/**
 产生一个NSInteger取值范围
 
 @param minValue 最小NSInteger值
 @param maxValue 最大NSInteger值
 @return 长度范围
 */
CG_EXTERN AXIntegerRange AXIntegerRangeMake(NSInteger minValue, NSInteger maxValue);



/**
 产生一个NSUInteger取值范围
 
 @param minValue 最小NSUInteger值
 @param maxValue 最大NSUInteger值
 @return 长度范围
 */
CG_EXTERN AXUIntegerRange AXUIntegerRangeMake(NSUInteger minValue, NSUInteger maxValue);




#pragma mark 确保值的范围

/**
 确保值在某个范围内

 @param value 初始值
 @param minValue 最小值
 @param maxValue 最大值
 @return 最终值
 */
CG_EXTERN NSNumber *AXMakeNumberInRange(NSNumber *value, NSNumber *minValue, NSNumber *maxValue);

#pragma mark 判断值是否在范围内
/**
 值是否在某个范围内
 
 @param value 要判断的值
 @param minValue 最小值
 @param maxValue 最大值
 @return 是否在[最小值,最大值]范围内
 */
CG_EXTERN BOOL AXNumberContainedInRange(NSNumber *value, NSNumber *minValue, NSNumber *maxValue);

#pragma mark - 随机值

/**
 产生一个随机的CGFloat数

 @param minValue 最小值
 @param maxValue 最大值
 @return 随机的CGFloat
 */
CG_EXTERN CGFloat AXRandomFloatInRange(CGFloat minValue, CGFloat maxValue);

/**
 产生一个随机的NSInteger数
 
 @param minValue 最小值
 @param maxValue 最大值
 @return 随机的NSInteger
 */
CG_EXTERN NSInteger AXRandomIntegerInRange(NSInteger minValue, NSInteger maxValue);



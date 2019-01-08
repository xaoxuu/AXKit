//
//  DemoString.h
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXTERN NSString *kStringTip(void);
FOUNDATION_EXTERN NSString *kStringPleaseWait(void);

FOUNDATION_EXTERN NSString *kStringLoadFail(void);


FOUNDATION_EXTERN NSString *kStringPleaseConfirmDataSourceCorrect(void);

FOUNDATION_EXTERN NSString *kStringPleaseImplementDataSource(NSString *cls);


#define NOTI_DRAWER_CLOSE @"com.xaoxuu.axkit.drawerclose"

@interface DemoString : NSObject

@end

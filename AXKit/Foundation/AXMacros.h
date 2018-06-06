//
//  AXMacros.h
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//


#ifndef AXMacros_h
#define AXMacros_h

#if !defined(AX_INITIALIZER)
# if __has_attribute(objc_method_family)
#  define AX_INITIALIZER __attribute__((objc_method_family(init)))
# else
#  define AX_INITIALIZER
# endif
#endif

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1010)
#define DISPATCH_CANCELLATION_SUPPORTED 1
#else
#define DISPATCH_CANCELLATION_SUPPORTED 1
#endif


#endif /* AXMacros_h */

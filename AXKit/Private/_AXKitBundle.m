//
//  _AXKitBundle.m
//  AXKit
//
//  Created by xaoxuu on 26/06/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "_AXKitBundle.h"

static NSBundle *bundle = nil;

inline NSString *NSLocalizedStringFromAXKit(NSString *key){
    // @xaoxuu: in main bundle
    if (!bundle) {
        bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"AXKit" ofType:@"bundle"]];
    }
    
    // @xaoxuu: in AXKit.framework/AXKit.bundle
    if (!bundle) {
        NSString *path_frameworks = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Frameworks"];
        bundle = [NSBundle bundleWithPath:[path_frameworks stringByAppendingPathComponent:@"AXKit.framework"]];
        bundle = [NSBundle bundleWithPath:[bundle pathForResource:@"AXKit" ofType:@"bundle"]];
    }
    
    return NSLocalizedStringFromTableInBundle(key, nil, bundle, nil) ?: key;
}

@implementation _AXKitBundle

@end

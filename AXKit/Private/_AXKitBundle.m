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
    if (!bundle) {
        bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"AXKit" ofType:@"bundle"]];
    }
    return NSLocalizedStringFromTableInBundle(key, nil, bundle, nil);
}

@implementation _AXKitBundle

@end

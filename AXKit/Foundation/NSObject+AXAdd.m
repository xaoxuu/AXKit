//
//  NSObject+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 13/03/2018.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "NSObject+AXAdd.h"

@import ObjectiveC.runtime;


@implementation NSObject (AXAdd)

+ (NSArray *)ax_allSubclasses{
    NSMutableArray *subclasses = [NSMutableArray array];
    unsigned int numOfClasses;
    Class *classes = objc_copyClassList(&numOfClasses);
    for (unsigned int ci = 0; ci < numOfClasses; ci++) {
        Class superClass = classes[ci];
        do{
            superClass = class_getSuperclass(superClass);
        } while (superClass && superClass != self);
        
        if (superClass)
        {
            [subclasses addObject: classes[ci]];
        }
    }
    free(classes);
    return subclasses;
}

- (BOOL (^)(id object))isEqual{
    return ^(id obj){
        return [self isEqual:obj];
    };
}

- (BOOL (^)(SEL aSelector))respondsToSelector{
    return ^(SEL aSelector){
        return [self respondsToSelector:aSelector];
    };
}

@end



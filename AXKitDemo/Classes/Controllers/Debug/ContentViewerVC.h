//
//  ContentViewerVC.h
//  AXKitDemo
//
//  Created by xaoxuu on 2018/4/20.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "BaseViewController.h"

@interface ContentViewerVC : BaseViewController

/**
 content
 */
@property (copy, nonatomic) NSString *content;
@property (strong, nonatomic) UIFont *font;


- (void)requestUpdate:(NSString *(^)(void))callback;

@end

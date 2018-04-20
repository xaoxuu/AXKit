//
//  CacheableLogVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 2018/4/20.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "CacheableLogVC.h"
#import "CacheableLogTV.h"
#import "AXDrawerKit.h"

@interface CacheableLogVC ()

@end

@implementation CacheableLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AXCachedLogOBJ(self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    AXCachedLogOBJ(self);
}

- (void)dealloc{
    AXCachedLogOBJ(@"dealloc");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AXCachedLogOBJ(self);
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AXCachedLogOBJ(self);
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AXCachedLogOBJ(self);
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    AXCachedLogOBJ(self);
}


- (AXTableViewType *)installTableView{
    CGRect frame = self.view.bounds;
    return [[CacheableLogTV alloc] initWithFrame:frame];
}


@end

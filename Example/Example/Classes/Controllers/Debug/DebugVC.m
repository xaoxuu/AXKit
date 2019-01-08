//
//  DebugVC.m
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DebugVC.h"
#import "DebugTV.h"
#import "Example-Swift.h"

@interface DebugVC ()



@end

@implementation DebugVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSString *ret = safeString(@"a1",@"a2");
//    [TestSwift testWithObj:@"a12" obj2:@"A23"];
    NSString *ret4 = NSString.safeString(nil, @"123");
    NSString *ret1 = NSString.safeString(@2, @"123");
    NSString *ret2 = NSString.safeString(@"null", @"123");
    NSString *ret3 = NSString.safeString(@"<Null>", @"123");
    
    self.view.backgroundColor = axThemeManager.color.groupTableViewBackground;
    self.title = @"AXKit";
    if (@available(iOS 11.0, *)) {
        // on newer versions
//        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    } else {
        // Fallback on earlier versions
        
    }
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithImageName:@"icon_help" action:^(UIBarButtonItem * _Nonnull sender) {
        [weakSelf presentSafariViewControllerWithURL:[NSURL URLWithString:[BaseContext docsURLString]] completion:nil];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutSubviews];
}


- (AXTableViewType *)installTableView{
    CGRect frame = self.view.bounds;
    return [[DebugTV alloc] initWithFrame:frame];
}



@end

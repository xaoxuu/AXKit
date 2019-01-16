//
//  BaseViewController.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseViewController.h"
#import "AXDrawerKit.h"

@interface BaseViewController ()



@end

@implementation BaseViewController

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (@available(iOS 11.0, *)) {
        // on newer versions
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    } else {
        // Fallback on earlier versions
        
    }
    
    // @xaoxuu: 基类 初始化 顶部区域 NavigationBar
    [self baseInitNavBar];
    // @xaoxuu: 基类 初始化 内容区域
    [self baseInitContentView];
    
    
    // @xaoxuu: 基类 初始化 ModuleKit组件库
    [self baseInitModuleKitLibrary];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self at_disableGeatureInChlidController];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    AXLogSuccess(@"%@ deallocated", NSStringFromClass([self class]));
}

- (BOOL)hidesBottomBarWhenPushed{
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - base init
// @xaoxuu: 基类 初始化 顶部区域 NavigationBar
- (void)baseInitNavBar{
    // @xaoxuu: default title
    if (!self.title.length) {
        self.title = NSStringFromClass([self class]);
    }
    
    // @xaoxuu: back bar item
    [self.navigationItem ax_hideBackBarButtonTitle];
    // @xaoxuu: ...
    
}

// @xaoxuu: 基类 初始化 内容区域
- (void)baseInitContentView{
    // @xaoxuu: color
    self.view.backgroundColor = axThemeManager.color.background;
    // @xaoxuu: frame
    self.view.frame = kScreenBounds;
    if ([self respondsToSelector:@selector(initContentFrame:)]) {
        self.view.frame = [self initContentFrame:self.view.frame];
    }
    
    if ([self respondsToSelector:@selector(initContentView:)]) {
        [self initContentView:self.view];
    }
    
    // @xaoxuu: subview
    if ([self respondsToSelector:@selector(initSubview)]) {
        [self initSubview];
    }
    
    // @xaoxuu: 通知中心的block中也要用弱引用
//    __weak typeof(self) weakSelf = self;
//    [[NSNotificationCenter defaultCenter] addObserverForName:ThemeKitNotificationFontChanged object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        [weakSelf.view layoutSubviews];
//    }];
    // @xaoxuu: ...
    
}




#pragma mark - module kit


// @xaoxuu: 初始化ModuleKit组件库
- (void)baseInitModuleKitLibrary{
    // @xaoxuu: 导航栏区域的组件
    [self baseModuleKitNavBar];
    // @xaoxuu: 内容区域的组件
    [self baseModuleKitContentView];
    
}

// @xaoxuu: module kit for navigation bar
- (void)baseModuleKitNavBar{
    // @xaoxuu: refresh button
    if ([self respondsToSelector:@selector(installRightRefreshBarButton:)]) {
        __weak typeof(self) weakSelf = self;
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithSystem:UIBarButtonSystemItemRefresh action:^(UIBarButtonItem * _Nonnull sender) {
            sender.enabled = NO;
            ax_dispatch_cooldown(0, reloadBtnCooldown, reloadBtnToken, dispatch_get_main_queue(), ^{
                [weakSelf installRightRefreshBarButton:sender];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reloadBtnCooldown * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    sender.enabled = YES;
                });
            }, ^{
                
            });
        }];
    }
}

// @xaoxuu: module kit for content view
- (void)baseModuleKitContentView{
    // @xaoxuu: table view
    if ([self respondsToSelector:@selector(installTableView)]) {
        if (@available(iOS 11.0, *)) {
            // on newer versions
            
        } else {
            // Fallback on earlier versions
            [self.view addSubview:[[UIView alloc] initWithHeight:1]];
        }
        AXTableViewType *tableView = [self installTableView];
        // init and add to superview
        self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [tableView setAutoresizesSubviews:NO];
        [self.view addSubview:tableView];
        
        // @xaoxuu: done
        if ([self respondsToSelector:@selector(didTableViewInstalled:)]) {
            [self didTableViewInstalled:tableView];
        }
        
    }
    
    
}




#pragma mark - delegate

- (CGRect)initContentFrame:(CGRect)frame{
    frame.origin.y += kTopBarHeight;
    frame.size.height = kScreenH - kTopBarHeight;
    return frame;
}

@end

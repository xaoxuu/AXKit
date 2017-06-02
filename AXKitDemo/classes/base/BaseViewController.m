//
//  BaseViewController.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)dealloc{
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
    self.navigationItem.backBarButtonItem = [UIBarButtonItem ax_itemWithTitle:NSLocalizedString(@"", nil) action:^(id  _Nonnull sender) {
    }];
    // @xaoxuu: ...
    
}

// @xaoxuu: 基类 初始化 内容区域
- (void)baseInitContentView{
    // @xaoxuu: color
    self.view.backgroundColor = axColor.background;
    // @xaoxuu: frame
    self.view.frame = CGRectFromScreen();
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
            [NSBlockOperation ax_delay:0 cooldown:reloadBtnCooldown token:reloadBtnToken performInMainQueue:^{
                [weakSelf installRightRefreshBarButton:sender];
                
                [NSBlockOperation ax_delay:reloadBtnCooldown performInMainQueue:^{
                    sender.enabled = YES;
                }];
            }];
        }];
    }
}

// @xaoxuu: module kit for content view
- (void)baseModuleKitContentView{
    // @xaoxuu: table view
    if ([self respondsToSelector:@selector(installTableView)]) {
        [self.view addSubview:UIViewWithHeight(1)];
        self.tableView = [self installTableView];
        // init and add to superview
        self.tableView.dataSource = self.tableView;
        self.tableView.delegate = self.tableView;
        self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.tableView setAutoresizesSubviews:NO];
        [self.view addSubview:self.tableView];
        
        // @xaoxuu: done
        if ([self respondsToSelector:@selector(didTableViewInstalled:)]) {
            [self didTableViewInstalled:self.tableView];
        }
        
    }
    
    
}




#pragma mark - delegate

- (CGRect)initContentFrame:(CGRect)frame{
    frame.origin.y = kTopBarHeight;
    frame.size.height = kScreenH - kTopBarHeight;
    return frame;
}

@end

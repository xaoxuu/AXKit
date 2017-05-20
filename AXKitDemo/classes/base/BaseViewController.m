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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self _base_setupTopBar];
    [self _base_setupContentView];
    [self _base_setupTableView];
    
    
    
    [self setupChildViewControllerUIKit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}



- (void)setupChildViewControllerUIKit{
    
    // @xaoxuu: refresh button
    if ([self respondsToSelector:@selector(setupRightRefreshBarButton:)]) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem ax_itemWithSystem:UIBarButtonSystemItemRefresh action:^(UIBarButtonItem * _Nonnull sender) {
            sender.enabled = NO;
            [NSBlockOperation ax_delay:0 cooldown:reloadBtnCooldown token:reloadBtnToken performInMainQueue:^{
                [self setupRightRefreshBarButton:sender];
                
                [NSBlockOperation ax_delay:reloadBtnCooldown performInMainQueue:^{
                    sender.enabled = YES;
                }];
            }];
        }];
        
    }
    
    // @xaoxuu: table view
    if ([self respondsToSelector:@selector(setupTableView)]) {
        [self.view addSubview:UIViewWithHeight(1)];
        self.tableView = [self setupTableView];
        // init and add to superview
        self.tableView.dataSource = self.tableView;
        self.tableView.delegate = self.tableView;
        self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.tableView setAutoresizesSubviews:NO];
        [self.view addSubview:self.tableView];
    }
    if ([self respondsToSelector:@selector(setupButtons)]) {
        [self setupButtons];
    }
    
}



- (BOOL)hidesBottomBarWhenPushed{
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    } else {
        return YES;
    }
}


- (void)_base_setupTopBar{
    
    if (!self.title.length) {
        self.title = services.json.titleForVC(NSStringFromClass([self class]));
    }
    
    self.navigationItem.backBarButtonItem = [UIBarButtonItem ax_itemWithTitle:NSLocalizedString(@"", nil) action:^(id  _Nonnull sender) {
    }];
    
    
}

- (void)_base_setupContentView{
    self.view.frame = CGRectFromScreen();
    self.view.backgroundColor = axColor.background;
    if ([self respondsToSelector:@selector(setupViewControllerHeight)]) {
        ViewControllerHeight height = [self setupViewControllerHeight];
        switch (height) {
            case ViewControllerHeightFullScreen:
            
            break;
            case ViewControllerHeightWithoutTopBar:
            self.view.top = kTopBarHeight;
            self.view.height -= kTopBarHeight;
            break;
            case ViewControllerHeightWithoutBottomBar:
            self.view.height -= kTabBarHeight;
            break;
            case ViewControllerHeightWithoutTopAndBottomBar:
            self.view.top = kTopBarHeight;
            self.view.height -= kTopBarHeight + kTabBarHeight;
            break;
            default:
            break;
        }
    }
}

- (void)_base_setupTableView{
    
    
}




#pragma mark - delegate

- (ViewControllerHeight)setupViewControllerHeight{
    return ViewControllerHeightWithoutTopBar;
}

@end

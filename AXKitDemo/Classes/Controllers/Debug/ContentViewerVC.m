//
//  ContentViewerVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 2018/4/20.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

#import "ContentViewerVC.h"

@interface ContentViewerVC ()

@property (strong, nonatomic) UITextView *textView;
@property (copy, nonatomic) NSString *(^block)(void);

@end

@implementation ContentViewerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupContent];
    
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

- (void)setupContent{
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.textView];
    self.textView.editable = NO;
    if (self.font) {
        self.textView.font = self.font;
    }
    if (self.content.length) {
        self.textView.text = self.content;
    }
}

- (void)setContent:(NSString *)content{
    _content = content;
    self.textView.text = content;
}

- (void)installRightRefreshBarButton:(UIBarButtonItem *)sender{
    if (self.block) {
        self.content = self.block();
    }
}

- (void)requestUpdate:(NSString *(^)(void))callback{
    self.block = callback;
}

@end

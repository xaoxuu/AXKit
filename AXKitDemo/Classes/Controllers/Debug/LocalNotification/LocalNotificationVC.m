//
//  LocalNotificationVC.m
//  AXKitDemo
//
//  Created by xaoxuu on 29/11/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "LocalNotificationVC.h"
#import "LocalNotificationTV.h"
@interface LocalNotificationVC ()

@end

@implementation LocalNotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (AXTableViewType *)installTableView{
    return [[LocalNotificationTV alloc] initWithFrame:self.view.bounds];
}

@end

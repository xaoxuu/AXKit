//
//  DemoString.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DemoString.h"


inline NSString *kStringTip(){
    return NSLocalizedString(@"提示", nil);
}
inline NSString *kStringPleaseWait(){
    return NSLocalizedString(@"请稍等", nil);
}
inline NSString *kStringLoadFail(){
    return NSLocalizedString(@"加载失败", nil);
}
inline NSString *kStringPleaseConfirmDataSourceCorrect(){
    return NSLocalizedString(@"请确认数据源是否正确", nil);
}
inline NSString *kStringPleaseImplementDataSource(NSString *cls){
    return [NSString stringWithFormat:NSLocalizedString(@"请在\"%@.m\"文件中实现数据源协议：\n\"- (void)setupTableViewDataSource:(void (^)(NSMutableArray<BaseTableModelSection *> *sections))dataSource;\"", nil), cls];
}



@implementation DemoString

@end

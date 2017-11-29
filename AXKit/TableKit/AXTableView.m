//
//  AXTableView.m
//  AXTableKit
//
//  Created by xaoxuu on 27/10/2017.
//  Copyright © 2017 xaoxuu. All rights reserved.
//

#import "AXTableView.h"
#import "AXTableViewCell.h"

static CGFloat defaultRowHeight = 44;


@interface AXTableView () <UIScrollViewDelegate>



// @xaoxuu: list
@property (strong, nonatomic) NSObject<AXTableModel> *dataList;

@property (copy, nonatomic) NSString *modelClassName;

/**
 复用id，如果自定义cell，需要将此值设置为cell的NibName
 */
@property (copy, nonatomic) NSString *reuseIdentifier;

@end


@implementation AXTableView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [self initWithFrame:frame style:UITableViewStyleGrouped]) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        
        
        [self setupData];
        
        
        [self setupTableView];
        
        [self setupDelegates];
        
        
        // load finished
        if ([self respondsToSelector:@selector(ax_tableViewDidLoadFinished:)]) {
            [self ax_tableViewDidLoadFinished:self];
        }
    }
    return self;
    
}

- (void)setupData{
    self.reuseIdentifier = NSStringFromClass([AXTableViewCell class]);
    self.modelClassName = NSStringFromClass(AXTableModel.class);
    
    if ([self respondsToSelector:@selector(ax_tableViewRegisterReuseableCell)]) {
        self.reuseIdentifier = NSStringFromClass([self ax_tableViewRegisterReuseableCell].class);
    }
    if ([self respondsToSelector:@selector(ax_tableViewRegisterTableModel)]) {
        self.modelClassName = NSStringFromClass([self ax_tableViewRegisterTableModel].class);
    }
}

- (void)setupTableView{
    // @xaoxuu: 注册复用池
    if (self.reuseIdentifier.length) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.reuseIdentifier ofType:@"nib"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [self registerNib:[UINib nibWithNibName:self.reuseIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:self.reuseIdentifier];
        } else {
            [self registerClass:NSClassFromString(self.reuseIdentifier) forCellReuseIdentifier:self.reuseIdentifier];
        }
    }
    self.dataSource = self;
    self.delegate = self;
    // @xaoxuu: 高度
    self.estimatedRowHeight = 44;
    self.estimatedSectionHeaderHeight = 0;
    self.rowHeight = 44;
    // @xaoxuu: 分割线
    
    
    
}

- (void)setupDelegates{
    // @xaoxuu: 设置table view
    
    
}


#pragma mark - func

- (void)reloadData{
    dispatch_async(dispatch_get_main_queue(), ^{
        // @xaoxuu: in main queue
        
        [super reloadData];
    });
}

- (void)reloadDataSourceAndRefreshTableView{
    if ([self respondsToSelector:@selector(ax_tableViewDataSource:)]) {
        [self ax_tableViewDataSource:^(NSObject<AXTableModel> *dataSource) {
            _dataList = dataSource;
            [self reloadData];
        }];
    }
}

- (AXTableSectionModelType *)tableViewSectionModelForIndexPath:(NSIndexPath *)indexPath{
    return self.dataList.sections[indexPath.section];
}
- (AXTableRowModelType *)tableViewRowModelForIndexPath:(NSIndexPath *)indexPath{
    return self.dataList.sections[indexPath.section].rows[indexPath.row];
}



- (void)deleteCellWithIndexPath:(NSIndexPath *)indexPath{
    [self.dataList.sections[indexPath.section].rows removeObjectAtIndex:indexPath.row];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (AXTableModelType *)loadDataSourceFromBundle{
    NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@".json"];
    return [self loadDataSourceFromPath:path];
}


- (AXTableModelType *)loadDataSourceFromPath:(NSString *)path{
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) {
        return nil;
    }
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (!dict) {
#if DEBUG
        if (error) {
            NSLog(@"load data source error: %@", error.description);
        }
#endif
        return nil;
    }
    
    
    NSObject<AXTableModel> *model = [NSClassFromString(self.modelClassName) modelWithDictionary:dict];
    return model;
}

#pragma mark - priv

- (NSObject<AXTableModel> *)dataList{
    if (!_dataList) {
        if ([self respondsToSelector:@selector(ax_tableViewPreloadDataSource)]) {
            _dataList = [self ax_tableViewPreloadDataSource];
        }
        if ([self respondsToSelector:@selector(ax_tableViewDataSource:)]) {
            [self ax_tableViewDataSource:^(NSObject<AXTableModel> *dataSource) {
                _dataList = dataSource;
                [self reloadData];
            }];
        }
    }
    return _dataList;
}


#pragma mark - data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.sections[section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    AXTableSectionModelType *section = self.dataList.sections[indexPath.section];
    AXTableRowModelType *model = section.rows[indexPath.row];
    AXTableViewCellType *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier];
    if (cell.frame.size.width != self.frame.size.width) {
        CGRect frame = cell.frame;
        frame.size.width = self.frame.size.width;
        cell.frame = frame;
    }
    
    
    // @xaoxuu: 即将设置模型
    if ([self respondsToSelector:@selector(ax_tableViewCell:willSetModel:forRowAtIndexPath:)]) {
        [self ax_tableViewCell:cell willSetModel:model forRowAtIndexPath:indexPath];
    }
    // @xaoxuu: 设置模型
    if ([cell respondsToSelector:@selector(setModel:)]) {
        cell.model = model;
    }
    
    // @xaoxuu: 自定义icon
    if ([self respondsToSelector:@selector(ax_tableViewCellIcon:forRowAtIndexPath:)] && [cell respondsToSelector:@selector(icon)]) {
        [self ax_tableViewCellIcon:^(UIImage *icon) {
            [cell updateIcon:^(UIImageView *imageView) {
                imageView.image = icon;
            }];
        } forRowAtIndexPath:indexPath];
    }
    
    
    
    
    return cell;
}


#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    AXTableRowModelType *model = self.dataList.sections[section].rows[row];
    if (!model) {
        return;
    }
    // @xaoxuu: selection action
    if ([self respondsToSelector:@selector(ax_tableViewDidSelectedRowAtIndexPath:)]) {
        [self ax_tableViewDidSelectedRowAtIndexPath:indexPath];
        return;
    }
    
    // @xaoxuu: push action
    UIViewController *vc = [[[NSClassFromString(model.target) class] alloc] init];
    if (vc) {
        vc.title = NSLocalizedString(model.title, nil);
        [self _indexPath:indexPath tryPush:vc withModel:model];
    } else if ([model.target containsString:@"http"]) {
        if (@available(iOS 10.0, *)) {
            // on newer versions
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.target] options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.target]];
        }
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AXTableRowModelType *row = self.dataList.sections[indexPath.section].rows[indexPath.row];
    if ([row respondsToSelector:@selector(rowHeight)]) {
        return row.rowHeight;
    } else {
        return defaultRowHeight;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    AXTableSectionModelType *sec = self.dataList.sections[section];
    if ([sec respondsToSelector:@selector(headerTitle)]) {
        return sec.headerTitle;
    } else {
        return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    AXTableSectionModelType *sec = self.dataList.sections[section];
    if ([sec respondsToSelector:@selector(headerHeight)]) {
        return sec.headerHeight;
    } else {
        return defaultRowHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    AXTableSectionModelType *sec = self.dataList.sections[section];
    if ([sec respondsToSelector:@selector(headerHeight)]) {
        return sec.headerHeight;
    } else {
        return defaultRowHeight;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    AXTableSectionModelType *sec = self.dataList.sections[section];
    if ([sec respondsToSelector:@selector(footerTitle)]) {
        return sec.footerTitle;
    } else {
        return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    AXTableSectionModelType *sec = self.dataList.sections[section];
    if ([sec respondsToSelector:@selector(footerHeight)]) {
        return sec.footerHeight;
    } else {
        return 0;
    }
}

- (void)_indexPath:(NSIndexPath *)indexPath tryPush:(UIViewController *)targetVC withModel:(AXTableRowModelType *)model{
    void (^block_push)(void) = ^{
        if ([self respondsToSelector:@selector(ax_tableViewWillPushToViewController:fromRowAtIndexPath:)]) {
            [self ax_tableViewWillPushToViewController:targetVC fromRowAtIndexPath:indexPath];
        }
        [self.controller.navigationController pushViewController:targetVC animated:YES];
    };
    if ([self respondsToSelector:@selector(ax_tableViewShouldPushToViewController:fromRowAtIndexPath:)]) {
        if ([self ax_tableViewShouldPushToViewController:targetVC fromRowAtIndexPath:indexPath]) {
            block_push();
        }
    } else {
        block_push();
    }
}

#pragma mark - AXTableKit的协议

- (NSObject<AXTableModel> *)ax_tableViewPreloadDataSource{
    return [self loadDataSourceFromBundle];
}


#pragma mark - extension

- (UIViewController *)controller{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])){
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    }
    return nil;
}

@end

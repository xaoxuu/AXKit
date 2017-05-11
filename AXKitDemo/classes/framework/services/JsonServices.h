//
//  JsonServices.h
//  AXKit
//
//  Created by xaoxuu on 09/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseServices.h"
#import "BaseTableModel.h"
#import "ThemeColorModel.h"

@interface JsonServices : BaseServices



- (BaseTableModelListType (^)(NSString *json))modelList;



- (BaseTableModelListType)colors;


- (NSString *((^)(NSString *)))titleForVC;




@end

//
//  NetworkDataAccess.h
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseDataAccess.h"

@interface NetworkDataAccess : BaseDataAccess


// @xaoxuu: request url string
@property (copy, nonatomic) NSString *URLString;


- (void)getURLCompletion:(void (^)(id response))completion fail:(void (^)(NSError * error))fail;

@end

//
//  AppModel.h
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfoModel : NSObject

// @xaoxuu: homePage url
@property (copy, readonly, nonatomic) NSString *homePageURL;
// @xaoxuu: blog url
@property (copy, readonly, nonatomic) NSString *blogURL;
// @xaoxuu: feedback
@property (copy, readonly, nonatomic) NSString *feedbackURL;

// @xaoxuu: feedback email
@property (copy, readonly, nonatomic) NSString *feedbackEmail;

// @xaoxuu: update url
@property (copy, readonly, nonatomic) NSString *updateURL;

@property (copy, readonly, nonatomic) NSString *copyright;


@end

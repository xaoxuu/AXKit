//
//  BlogListModel.h
//  AXKit
//
//  Created by xaoxuu on 19/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogListModel : NSObject

// @xaoxuu: name
@property (copy, nonatomic) NSString *name;
// @xaoxuu: path
@property (copy, nonatomic) NSString *path;
// @xaoxuu: size
@property (copy, nonatomic) NSString *size;
// @xaoxuu: url
@property (copy, nonatomic) NSString *url;
// @xaoxuu: html_url
@property (copy, nonatomic) NSString *html_url;
// @xaoxuu: download_url
@property (copy, nonatomic) NSString *download_url;


@end

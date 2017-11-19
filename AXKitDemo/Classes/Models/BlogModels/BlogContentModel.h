//
//  BlogContentModel.h
//  AXKit
//
//  Created by xaoxuu on 19/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogContentModel : NSObject



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

// @xaoxuu: content
@property (copy, nonatomic) NSString *content;
// @xaoxuu: encoding
@property (copy, nonatomic) NSString *encoding;



@end

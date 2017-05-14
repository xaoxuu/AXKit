//
//  NetworkDataAccess.m
//  AXKit
//
//  Created by xaoxuu on 13/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NetworkDataAccess.h"

@implementation NetworkDataAccess


- (instancetype)init{
    if (self = [super init]) {
        
        
        
        
    }
    return self;
}



- (void)getURLCompletion:(void (^)(id response))completion fail:(void (^)(NSError * error))fail{
    [NSBlockOperation ax_delay:0 performInBackground:^{
        //1.确定请求路径
        //    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
        NSURL *url = [NSURL URLWithString:self.URLString];
        
        //2.创建请求对象
        //请求对象内部默认已经包含了请求头和请求方法（GET）
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        //3.获得会话对象
        NSURLSession *session = [NSURLSession sharedSession];
        
        //4.根据会话对象创建一个Task(发送请求）
        /*
         第一个参数：请求对象
         第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
         data：响应体信息（期望的数据）
         response：响应头信息，主要是对服务器端的描述
         error：错误信息，如果请求失败，则error有值
         */
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                AXLogError(error);
                if (fail) {
                    fail(error);
                }
            } else {
                if (completion) {
                    id ret = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                    completion(ret);
                }
            }
        }];
        
        //5.执行任务
        [dataTask resume];

    }];
}


@end

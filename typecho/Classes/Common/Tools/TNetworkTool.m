//
//  TNetworkTool.m
//  typecho
//
//  Created by hext on 2017/7/18.
//  Copyright © 2017年 hext. All rights reserved.
//

#import "TNetworkTool.h"
#import <AFNetworking/AFNetworking.h>

@implementation TNetworkTool

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                        method:(NSString *)method
                    parameters:(NSArray *)parameters
                    completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion
{
    
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"plain-text" forHTTPHeaderField:@"User-Agent"];
    
    WPXMLRPCEncoder *encoder = [[WPXMLRPCEncoder alloc] initWithMethod:method andParameters:parameters];
    [request setHTTPBody:[encoder dataEncodedWithError:nil]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *sessionDataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completion(response,responseObject,error);
        } else {
            WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:responseObject];
            if ([decoder object]) {
                NSLog(@"XML-RPC response: %@", [decoder object]);
                completion(response,decoder,error);
            } else {
                NSLog(@"%@ %@", response, [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                completion(response,responseObject,[NSError errorWithDomain:@"com.wskfz.typecho.parse.failure" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"xmlrpc返回解析失败!"}]);
            }
        }
    }];
    [sessionDataTask resume];
    
    return sessionDataTask;
}
@end

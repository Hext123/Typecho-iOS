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
    
    WPXMLRPCEncoder *encoder = [[WPXMLRPCEncoder alloc] initWithMethod:method andParameters:parameters];
    [request setHTTPBody:[encoder dataEncodedWithError:nil]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *sessionDataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completion(response,responseObject,error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:responseObject];
            completion(response,decoder,error);
        }
    }];
    [sessionDataTask resume];
    
    return sessionDataTask;
}
@end

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

+ (NSURLSessionDataTask *)POST:(NSString *)URLString method:(NSString *)method parameters:(NSArray *)parameters completion:(void (^)(NSURLResponse *, id, NSError *))completion{
    return [self POST:URLString method:method parameters:parameters verifyType:nil completion:completion];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString method:(NSString *)method parameters:(NSArray *)parameters verifyType:(Class)verifyType completion:(void (^)(NSURLResponse *, id, NSError *))completion{
    return [self POST:URLString method:method verifyMethod:NO parameters:parameters verifyType:verifyType completion:completion];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                        method:(NSString *)method
                  verifyMethod:(BOOL)verifyMethod
                    parameters:(NSArray *)parameters
                    verifyType:(Class)verifyType
                    completion:(void (^)(NSURLResponse *, id, NSError *))completion
{
    if (verifyMethod && ![TWebsiteInfo.currentWebsiteInfo.methods containsObject:method]) {
        
        completion(nil,nil,[NSError errorWithDomain:@"com.wskfz.typecho.parse.failure" code:-3 userInfo:@{NSLocalizedDescriptionKey:@"您的站点不支持此功能"}]);
        return nil;
    }
    
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    [request setHTTPMethod:@"POST"];
//    [request addValue:@"plain-text" forHTTPHeaderField:@"User-Agent"];
    
    WPXMLRPCEncoder *encoder = [[WPXMLRPCEncoder alloc] initWithMethod:method andParameters:parameters];
    [request setHTTPBody:[encoder dataEncodedWithError:nil]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *sessionDataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completion(response,nil,error);
        } else {
            WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:responseObject];
            if ([decoder object]) {
                if ([decoder isFault]) {
                    NSLog(@"XML-RPC error %ld: %@", (long)[decoder faultCode], [decoder faultString]);
                    completion(response,nil,[NSError errorWithDomain:@"com.wskfz.typecho.parse.failure" code:[decoder faultCode] userInfo:@{NSLocalizedDescriptionKey:[decoder faultString]}]);
                } else {
                    NSLog(@"XML-RPC response: %@", [decoder object]);
                    if (verifyType == nil || [[decoder object] isKindOfClass:verifyType]) {
                        completion(response,[decoder object],nil);
                    } else {
                        completion(response,nil,[NSError errorWithDomain:@"com.wskfz.typecho.parse.failure" code:-2 userInfo:@{NSLocalizedDescriptionKey:@"解析失败! 收到的数据格式不正确."}]);
                    }
                }
            } else {
                NSLog(@"%@ %@", response, [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                completion(response,nil,[NSError errorWithDomain:@"com.wskfz.typecho.parse.failure" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"xmlrpc返回解析失败!"}]);
            }
        }
    }];
    [sessionDataTask resume];
    
    return sessionDataTask;
}
@end

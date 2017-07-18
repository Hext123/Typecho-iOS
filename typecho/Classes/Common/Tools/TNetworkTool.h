//
//  TNetworkTool.h
//  typecho
//
//  Created by hext on 2017/7/18.
//  Copyright © 2017年 hext. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <wpxmlrpc/WPXMLRPC.h>

@interface TNetworkTool : NSObject
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                        method:(NSString *)method
                    parameters:(NSArray *)parameters
                    completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion;
@end

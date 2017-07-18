//
//  TWebsiteInfo.h
//  typecho
//
//  Created by hext on 2017/7/18.
//  Copyright © 2017年 hext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWebsiteInfo : NSObject
+ (instancetype)currentWebsiteInfo;

@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSArray<NSString *> *methods;
@end

//
//  TWebsiteInfo.m
//  typecho
//
//  Created by hext on 2017/7/18.
//  Copyright © 2017年 hext. All rights reserved.
//

#import "TWebsiteInfo.h"

@implementation TWebsiteInfo
+ (instancetype)currentWebsiteInfo{
    static id instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [self new];
    });
    return instance;
}
@end

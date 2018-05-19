//
//  TWebsiteInfo.m
//  typecho
//
//  Created by hext on 2017/7/18.
//  Copyright © 2017年 hext. All rights reserved.
//

#import "TWebsiteInfo.h"
#import <MJExtension/MJExtension.h>

// 网站信息的存储路径
#define DJAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation TWebsiteInfo

MJCodingImplementation

static id instance = nil;
+ (instancetype)currentWebsiteInfo{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [self new];
    });
    return instance;
}

///读取本地网站信息
+ (instancetype)read{
    // 从本地加载模型
    instance = [NSKeyedUnarchiver unarchiveObjectWithFile:DJAccountPath];
    return instance;
}

/**
 *  存储网站信息
 */
+ (void)save{
    // 自定义对象的存储必须用NSKeyedArchiver
    [NSKeyedArchiver archiveRootObject:instance toFile:DJAccountPath];
}

/**
 *  删除网站信息
 */
+ (void)remove{
    instance = nil;
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:DJAccountPath]) {
        NSError *error ;
        [manager removeItemAtPath:DJAccountPath error:&error];
        if (error) {
            NSLog(@"删除账号失败 - %@",error);
        }
    }
}

@end

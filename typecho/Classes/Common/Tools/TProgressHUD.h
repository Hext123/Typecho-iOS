//
//  TProgressHUD.h
//  typecho
//
//  Created by hext on 2017/7/25.
//  Copyright © 2017年 hext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TProgressHUD : NSObject

/**
 显示错误提示

 @param error 错误提示
 */
+ (void)showError:(NSString *)error;
@end

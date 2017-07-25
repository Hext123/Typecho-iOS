//
//  TProgressHUD.m
//  typecho
//
//  Created by hext on 2017/7/25.
//  Copyright © 2017年 hext. All rights reserved.
//

#import "TProgressHUD.h"

@implementation TProgressHUD
+ (void)showError:(NSString *)error{
    [[[UIAlertView alloc]initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
}
@end

//
//  TTabBarPlusButton.m
//  typecho
//
//  Created by hext on 2017/7/20.
//  Copyright © 2017年 hext. All rights reserved.
//

#import "TTabBarPlusButton.h"
#import "TNavigationController.h"
#import "TEditViewController.h"

@implementation TTabBarPlusButton

+ (id)plusButton{
    TTabBarPlusButton *btn = [[TTabBarPlusButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn setImage:R.image.tabbarAdd forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight{
    return 0.0;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight{
    return 22.0;
}

+ (void)plusButtonClick{
    TEditViewController *vc = [TEditViewController new];
    TNavigationController *nc = [[TNavigationController alloc] initWithRootViewController:vc];
    [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:nc animated:YES completion:nil];
}

@end

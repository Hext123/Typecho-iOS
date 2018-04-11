//
//  TTabBarPlusButton.m
//  typecho
//
//  Created by hext on 2017/7/20.
//  Copyright © 2017年 hext. All rights reserved.
//

#import "TTabBarPlusButton.h"

@implementation TTabBarPlusButton

+ (id)plusButton{
    TTabBarPlusButton *btn = [[TTabBarPlusButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn setImage:R.image.tabbarAdd forState:UIControlStateNormal];
    return btn;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight{
    return 0.0;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight{
    return 22.0;
}

@end

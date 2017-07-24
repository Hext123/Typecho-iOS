//
//  TTabBarController.m
//  typecho
//
//  Created by hext on 2017/7/18.
//  Copyright © 2017年 hext. All rights reserved.
//

#import "TTabBarController.h"
#import "TNavigationController.h"

@interface TTabBarController ()

@end

@implementation TTabBarController

+ (instancetype)newTabBarController{
    TTabBarController *tabBarController = [[TTabBarController alloc] init];
    [tabBarController setupViewControllers];
    return tabBarController;
}
- (void)setupViewControllers {
    
    UIViewController *firstViewController = R.storyboard.main.tMyTableViewController;
    TNavigationController *firstNavigationController = [[TNavigationController alloc] initWithRootViewController:firstViewController];
    firstNavigationController.tabBarItem.image = R.image.tabbarMy;
    
    UIViewController *secondViewController = [UIViewController new];
    TNavigationController *secondNavigationController = [[TNavigationController alloc] initWithRootViewController:secondViewController];
    secondNavigationController.tabBarItem.image = R.image.tabbarSetting;
    
    [self customizeTabBar];
    
    [self setViewControllers:@[
                               firstNavigationController,
                               secondNavigationController,
                               ]];
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBar{
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"我的",
                            //                            CYLTabBarItemImage : @"tabbar_my",
                            //                            CYLTabBarItemSelectedImage : @"tabbar_my_highlight",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"设置",
                            //                            CYLTabBarItemImage : @"tabbar_setting",
                            //                            CYLTabBarItemSelectedImage : @"tabbar_setting_highlight",
                            };
    
    NSArray *tabBarItemsAttributes = @[ dict1, dict2 ];
    self.tabBarItemsAttributes = tabBarItemsAttributes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end

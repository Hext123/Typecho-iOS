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
    
    UIViewController *firstViewController = R.storyboard.main.tMyTableViewController;
    TNavigationController *firstNavigationController = [[TNavigationController alloc] initWithRootViewController:firstViewController];
    firstNavigationController.tabBarItem.image = R.image.tabbarMy;
    
    UIViewController *secondViewController = [UIViewController new];
    TNavigationController *secondNavigationController = [[TNavigationController alloc] initWithRootViewController:secondViewController];
    secondNavigationController.tabBarItem.image = R.image.tabbarSetting;
    
    NSDictionary *dict1 = @{CYLTabBarItemTitle : @"我的"};
    NSDictionary *dict2 = @{CYLTabBarItemTitle : @"设置"};
    
    TTabBarController *tabBarController = [[TTabBarController alloc] initWithViewControllers:@[firstNavigationController,secondNavigationController] tabBarItemsAttributes:@[dict1,dict2]];
    
    return tabBarController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end

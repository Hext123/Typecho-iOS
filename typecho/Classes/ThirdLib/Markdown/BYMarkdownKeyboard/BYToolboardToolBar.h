//
//  BYToolboardToolBar.h
//  Markdown
//
//  Created by 白云杰 on 16/12/28.
//  Copyright © 2016年 白云杰. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void (^eventHandlerBlock)();

@interface BYToolboardToolBar : UIButton

+ (instancetype)buttonWithImage:(NSString *)imageName;

+ (instancetype)buttonWithTitle:(NSString *)title;

- (void)addEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent;

@end

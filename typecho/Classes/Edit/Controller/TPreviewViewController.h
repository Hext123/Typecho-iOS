//
//  TPreviewViewController.h
//  typecho
//
//  Created by hext on 2018/5/16.
//  Copyright © 2018年 hext. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPreviewViewController : UIViewController

/** 主题 */
@property (nonatomic, assign) NSInteger style;
/** 内容 */
@property (nonatomic, copy) NSString *content;

@end

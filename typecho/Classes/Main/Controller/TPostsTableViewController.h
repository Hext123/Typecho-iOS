//
//  TPostsTableViewController.h
//  typecho
//
//  Created by hext on 2017/7/18.
//  Copyright © 2017年 hext. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPostsTableViewController : UITableViewController
+(instancetype)newViewController;
@end

@interface TPostsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *excerptLab;
@end

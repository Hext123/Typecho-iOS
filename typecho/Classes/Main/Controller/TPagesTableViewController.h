//
//  TPagesTableViewController.h
//  typecho
//
//  Created by hext on 2017/7/28.
//  Copyright © 2017年 hext. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPagesTableViewController : UITableViewController
+(instancetype)newViewController;
@end

@interface TPagesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *excerptLab;
@end

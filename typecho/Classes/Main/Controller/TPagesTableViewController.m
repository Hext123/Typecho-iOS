//
//  TPagesTableViewController.m
//  typecho
//
//  Created by hext on 2017/7/28.
//  Copyright © 2017年 hext. All rights reserved.
//

#import "TPagesTableViewController.h"
#import <SafariServices/SafariServices.h>

typedef NS_ENUM(NSInteger, TTableFooterViewType) {
    TTableFooterViewTypeNone        = 0,
    TTableFooterViewTypeLoading     = 1,
    TTableFooterViewTypeLoadFail    = 2,
};

@interface TPagesTableViewController ()
@property(copy, nonatomic)NSArray *data;
@end

@implementation TPagesTableViewController

+(instancetype)newViewController{
    return R.storyboard.main.tPagesTableViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    
    [self setTableFooterViewType:TTableFooterViewTypeLoading];
    
    [self getData];
}

- (void)setTableFooterViewType:(TTableFooterViewType)type{
    switch (type) {
        case TTableFooterViewTypeNone:
            self.tableView.tableFooterView = [UIView new];
            break;
        case TTableFooterViewTypeLoading:
            self.tableView.tableFooterView = ({
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
                lab.text = @"加载中...";
                lab.textAlignment = NSTextAlignmentCenter;
                lab;
            });
            break;
        case TTableFooterViewTypeLoadFail:
            self.tableView.tableFooterView = ({
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
                [btn setTitle:@"加载失败! 点击重新加载" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
                btn;
            });
            break;
        default:
            self.tableView.tableFooterView = nil;
            break;
    }
}

- (void)getData{
    
    TWebsiteInfo *info = [TWebsiteInfo currentWebsiteInfo];
    
    NSString *urlString = info.url;
    NSString *methodName = @"wp.getPages";
    NSArray *parameters = @[@0, info.username, info.password];
    
    [TNetworkTool POST:urlString method:methodName parameters:parameters verifyType:NSArray.class completion:^(NSURLResponse *response, NSArray *responseObject, NSError *error) {
        
        [self setTableFooterViewType:TTableFooterViewTypeNone];
        
        if (error) {
            [TProgressHUD showError:error.localizedDescription];
        } else {
            
            self.data = responseObject;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.titleLab.text = self.data[indexPath.row][@"title"];
    cell.excerptLab.text = self.data[indexPath.row][@"excerpt"];
    NSDate *dateCreated = self.data[indexPath.row][@"date_created_gmt"];
    if ([dateCreated isKindOfClass:[NSDate class]]) {
        NSDateFormatter *df = [NSDateFormatter new];
        df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        cell.timeLab.text = [df stringFromDate:dateCreated];
    } else {
        cell.timeLab.text = @"";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *url = self.data[indexPath.row][@"link"];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 && url.length > 0) {
        SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        [self presentViewController:svc animated:YES completion:nil];
    }
}

@end

@implementation TPagesTableViewCell

@end

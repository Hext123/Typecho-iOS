//
//  TPostsTableViewController.m
//  typecho
//
//  Created by hext on 2017/7/18.
//  Copyright © 2017年 hext. All rights reserved.
//

#import "TPostsTableViewController.h"
#import <SafariServices/SafariServices.h>
#import "TNetworkTool.h"
#import "TWebsiteInfo.h"

@interface TPostsTableViewController ()

@property(copy, nonatomic)NSArray *data;
@end

@implementation TPostsTableViewController

+(instancetype)newViewController{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TPostsTableViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    
    [self getData];
}

- (void)getData{
    
    TWebsiteInfo *info = [TWebsiteInfo currentWebsiteInfo];
    
    NSString *urlString = info.url;
    NSString *methodName = @"metaWeblog.getRecentPosts";
    
    if (![info.methods containsObject:methodName]) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的站点不支持此功能" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
        return;
    }
    
    NSArray *parameters = @[@0, info.username, info.password, @20];
    
    [TNetworkTool POST:urlString method:methodName parameters:parameters completion:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"连接失败, 请检查网络!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
        } else {
            WPXMLRPCDecoder *decoder = responseObject;
            if ([decoder isFault]) {
                NSLog(@"XML-RPC error %ld: %@", (long)[decoder faultCode], [decoder faultString]);
                [[[UIAlertView alloc]initWithTitle:@"提示" message:[decoder faultString] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
            } else {
                NSLog(@"XML-RPC response: %@", [decoder object]);
                if ([[decoder object] isKindOfClass:[NSArray class]]) {
                    
                    self.data = [decoder object];
                    [self.tableView reloadData];
                }
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.titleLab.text = self.data[indexPath.row][@"title"];
    cell.excerptLab.text = self.data[indexPath.row][@"mt_excerpt"];
    NSDate *dateCreated = self.data[indexPath.row][@"dateCreated"];
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
        SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url] entersReaderIfAvailable:YES];
        [self presentViewController:svc animated:YES completion:nil];
    }
}

@end

@implementation TPostsTableViewCell

@end

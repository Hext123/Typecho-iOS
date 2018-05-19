//
//  TAddWebsiteTableViewController.m
//  typecho
//
//  Created by hext on 2017/7/18.
//  Copyright © 2017年 hext. All rights reserved.
//

#import "TAddWebsiteTableViewController.h"
#import "TTabBarController.h"

@interface TAddWebsiteTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *websiteTF;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)addWebsite:(UIButton *)sender;

@end

@implementation TAddWebsiteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TWebsiteInfo *info = [TWebsiteInfo read];
    self.websiteTF.text = info.url;
    self.usernameTF.text = info.username;
    self.passwordTF.text = info.password;
}

- (IBAction)addWebsite:(UIButton *)sender {
    sender.enabled = NO;
    [sender setTitle:@"正在验证..." forState:UIControlStateNormal];
    
    [self listMethods:sender];
}

- (void)listMethods:(UIButton *)sender {
    
    NSString *urlString = self.websiteTF.text;
    NSString *methodName = @"system.listMethods";
    
    [TNetworkTool POST:urlString method:methodName parameters:nil verifyType:NSArray.class completion:^(NSURLResponse *response, NSArray *responseObject, NSError *error) {
        
        if (error) {
            
            sender.enabled = YES;
            [sender setTitle:@"添加站点" forState:UIControlStateNormal];
            [TProgressHUD showError:error.localizedDescription];
        } else {
            
            [self getOptions:sender methods:responseObject];
        }
    }];
}

- (void)getOptions:(UIButton *)sender methods:(NSArray*)methods{
    
    NSString *urlString = self.websiteTF.text;
    NSString *methodName = @"wp.getOptions";
    NSArray *parameters = @[@0, self.usernameTF.text, self.passwordTF.text];
    
    [TNetworkTool POST:urlString method:methodName parameters:parameters verifyType:NSDictionary.class completion:^(NSURLResponse *response, NSDictionary *responseObject, NSError *error) {
        
        sender.enabled = YES;
        [sender setTitle:@"添加站点" forState:UIControlStateNormal];
        
        if (error) {
            [TProgressHUD showError:error.localizedDescription];
        } else {
            TWebsiteInfo *info = [TWebsiteInfo currentWebsiteInfo];
            info.url = self.websiteTF.text;
            info.username = self.usernameTF.text;
            info.password = self.passwordTF.text;
            info.methods = methods;
            [TWebsiteInfo save];
            
            [UIApplication sharedApplication].delegate.window.rootViewController = [TTabBarController newTabBarController];
        }
    }];
}

@end

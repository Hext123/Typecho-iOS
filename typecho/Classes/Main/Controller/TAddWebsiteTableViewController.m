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
    
    [TNetworkTool POST:urlString method:methodName parameters:nil completion:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        WPXMLRPCDecoder *decoder = responseObject;
        if (error || ![decoder object]) {
            
            sender.enabled = YES;
            [sender setTitle:@"添加站点" forState:UIControlStateNormal];
            
            [TProgressHUD showError:@"验证失败！请检查您的网络和URL输入是否正确。"];
        } else {
            if ([decoder isFault]) {
                
                sender.enabled = YES;
                [sender setTitle:@"添加站点" forState:UIControlStateNormal];
                
                [TProgressHUD showError:[decoder faultString]];
                
                NSLog(@"XML-RPC error %ld: %@", (long)[decoder faultCode], [decoder faultString]);
               
            } else {
                NSLog(@"XML-RPC response: %@", [decoder object]);
                if ([[decoder object] isKindOfClass:[NSArray class]]) {
                    [self getOptions:sender methods:[decoder object]];
                }else{
                    
                    [TProgressHUD showError:@"解析失败! 收到的数据格式不正确."];
                    
                    sender.enabled = YES;
                    [sender setTitle:@"添加站点" forState:UIControlStateNormal];
                }
            }
        }
    }];
}

- (void)getOptions:(UIButton *)sender methods:(NSArray*)methods{
    
    NSString *urlString = self.websiteTF.text;
    NSString *methodName = @"wp.getOptions";
    NSArray *parameters = @[@0, self.usernameTF.text, self.passwordTF.text];
    
    [TNetworkTool POST:urlString method:methodName parameters:parameters completion:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        sender.enabled = YES;
        [sender setTitle:@"添加站点" forState:UIControlStateNormal];
        
        WPXMLRPCDecoder *decoder = responseObject;
        if (error || ![decoder object]) {
            [TProgressHUD showError:@"验证失败！请检查您的网络和URL输入是否正确。"];
        } else {
            if ([decoder isFault]) {
                
                [TProgressHUD showError: [decoder faultString]];
                NSLog(@"XML-RPC error %ld: %@", (long)[decoder faultCode], [decoder faultString]);
               
            } else {
                NSLog(@"XML-RPC response: %@", [decoder object]);
                if ([[decoder object] isKindOfClass:[NSDictionary class]]) {
                    
                    TWebsiteInfo *info = [TWebsiteInfo currentWebsiteInfo];
                    info.url = self.websiteTF.text;
                    info.username = self.usernameTF.text;
                    info.password = self.passwordTF.text;
                    info.methods = methods;
                    [TWebsiteInfo save];
                    
                    [UIApplication sharedApplication].delegate.window.rootViewController = [TTabBarController newTabBarController];
                }else{
                    
                    [TProgressHUD showError:@"解析失败! 收到的数据格式不正确."];
                }
            }
        }
    }];
}

@end

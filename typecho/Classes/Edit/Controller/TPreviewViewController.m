//
//  TPreviewViewController.m
//  typecho
//
//  Created by hext on 2018/5/16.
//  Copyright © 2018年 hext. All rights reserved.
//

#import "TPreviewViewController.h"

NSString  * const defaultStyle = @"<link href='markdown.css' rel='stylesheet'></link>";
NSString  * const whiteStyle = @"<link href='markdown-white.css' rel='stylesheet'></link>";
NSString  * const blackStyle = @"<link href='markdown-black.css' rel='stylesheet'></link>";
NSString  * const oldStyle = @"<link href='markdown-old.css' rel='stylesheet'></link>";

typedef NS_ENUM(NSInteger, CSSStyle) {
    
    CSSStyleDefault = 1,
    
    CSSStyleWhite = 2,
    
    CSSStyleBlack = 3,
    
    CSSStyleOld = 4,
};

@interface TPreviewViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation TPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *cssString;
    
    if (_style == 2) {
        cssString = whiteStyle;
    } else if (_style == 3) {
        cssString = blackStyle;
    } else if (_style == 4) {
        cssString = oldStyle;
    } else {
        cssString = defaultStyle;
    }
    
    // 这个拼接是把主题拼接在html的前面，然后用webview去在家html
    NSString *value = [cssString stringByAppendingString:_content];
    [self.webView loadHTMLString:value baseURL:[[NSBundle mainBundle] bundleURL]];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.backgroundColor = [UIColor clearColor];
        [_webView setOpaque:NO];
        [self.view addSubview:_webView];
    }
    return _webView;
}

@end

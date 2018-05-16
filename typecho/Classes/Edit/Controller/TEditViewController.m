//
//  TEditViewController.m
//  typecho
//
//  Created by hext on 2018/5/16.
//  Copyright © 2018年 hext. All rights reserved.
//

#import "TEditViewController.h"
#import "TPreviewViewController.h"

@interface TEditViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) NSInteger style;

@end

@implementation TEditViewController

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.style = 2;
    [self createTextView];
    [self addKeyboardNotification];
    
    self.title = @"编辑";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(close)];
}

- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 创建textView
- (void)createTextView {
    
    //markdown输入框
    self.textView = [[UITextView alloc] init];
    self.textView.textColor = RGB(72, 82, 87, 1);
    self.textView.font = [UIFont fontWithName:YouYouNormalFont size:17];
    self.textView.frame = self.view.frame;
    [self.view addSubview:self.textView];
    
    __weak typeof(self) weakSelf = self;
    self.textView.inputAccessoryView = [BYMarkdownKeyboard toolbarViewWithTextView:_textView keybordBlock:^(NSInteger index) {
        
        switch (index) {
            case 1:
                [weakSelf.textView resignFirstResponder];
                break;
            case 2:
                [weakSelf helpAction];
                break;
            case 3:
                weakSelf.textView.text = nil;
                break;
            case 4:
                [weakSelf.textView resignFirstResponder];
                [weakSelf changeStyle];
                break;
            case 5:
                [weakSelf previewAction];
                break;
        }
    }];
    
    [self.textView becomeFirstResponder];
}

#pragma mark - 预览
- (void)previewAction {
    
    TPreviewViewController *preview = [[TPreviewViewController alloc] init];
    preview.style = _style;

    // 把markdown语法转成html
    preview.content = [MMMarkdown HTMLStringWithMarkdown:self.textView.text extensions:MMMarkdownExtensionsGitHubFlavored error:NULL];

    [self.navigationController pushViewController:preview animated:YES];
}

#pragma mark - markdown语法
- (void)helpAction {
    
//    HelpViewController *helpView = [[HelpViewController alloc] init];
//    [self.navigationController pushViewController:helpView animated:YES];
}

#pragma mark - 选择主题
- (void)changeStyle {
    
//    ThemeMenu *theme = [[ThemeMenu alloc] init];
//    theme.delegate = self;
//    [theme show];
}

#pragma mark - 代理
- (void)btnClickWithIndex:(NSInteger)index {
    
    if (index == 1) {
        self.style = 1;
    } else if (index == 2) {
        self.style = 2;
    } else if (index == 3) {
        self.style = 3;
    } else {
        self.style = 4;
    }
    
    [self.textView becomeFirstResponder];
}

#pragma mark - 键盘的处理
- (void)addKeyboardNotification {
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 键盘弹起
- (void)keyBoardWillShow:(NSNotification *)noti
{
    CGFloat keyboardH = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    // 获取键盘出现的时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.textView.contentInset = UIEdgeInsetsMake(0, 0, keyboardH, 0);
    }];
}

#pragma mark - 键盘收回
- (void)keyBoardWillHidden:(NSNotification *)noti{
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
}

@end

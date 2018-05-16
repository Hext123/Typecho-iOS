//
//  BYMarkdownKeyboard.m
//  Markdown
//
//  Created by 白云杰 on 16/12/28.
//  Copyright © 2016年 白云杰. All rights reserved.
//

#import "BYMarkdownKeyboard.h"
#import "BYToolboardToolBar.h"


@interface BYMarkdownKeyboard ()


@property(nonatomic, strong) UIView *toolbarView;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) CALayer *topBorder;
@property(nonatomic, strong) NSArray *buttonsToAdd;
@property(nonatomic, copy) keybordBlock block;

@end

@implementation BYMarkdownKeyboard

+ (instancetype)toolbarViewWithTextView:(UITextView *)textView keybordBlock:(keybordBlock )block {
    return [[BYMarkdownKeyboard alloc] initWithTextView:textView keybordBlock:block];
}

- (id)initWithTextView:(UITextView *)textView keybordBlock:(keybordBlock )block{
    self.block = block;
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, 51)];
    self.backgroundColor = [UIColor colorWithRed:220 / 255.0f
                                           green:222 / 255.0f
                                            blue:226 / 255.0f
                                           alpha:1.0f];
    
    if (self) {
        _buttonsToAdd = [self buttonsForTextView:textView];
        self.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:[self inputAccessoryView]];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect frame = _toolbarView.bounds;
    frame.size.height = 0.5f;
    _topBorder.frame = frame;
}

- (UIView *)inputAccessoryView {
    _toolbarView = [[UIView alloc]
                    initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 51)];
    _toolbarView.backgroundColor = [UIColor colorWithRed:209 / 255.0f
                                                   green:213 / 255.0f
                                                    blue:219 / 255.0f
                                                   alpha:1.0f];
    _toolbarView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _topBorder = [CALayer layer];
    _topBorder.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, 0.5f);
    //_topBorder.backgroundColor = [UIColor colorWithWhite:0.678
    // alpha:1.0].CGColor;
    
    [_toolbarView.layer addSublayer:_topBorder];
    [_toolbarView addSubview:[self fakeToolbar]];
    
    return _toolbarView;
}

- (UIScrollView *)fakeToolbar {
    _scrollView = [[UIScrollView alloc]
                   initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 51)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentInset = UIEdgeInsetsMake(6.0f, 0.0f, 6.0f, 6.0f);
    
    NSUInteger index = 0;
    NSUInteger originX = 8;
    
    CGRect originFrame;
    
    for (BYToolboardToolBar *eachButton in _buttonsToAdd) {
        originFrame = CGRectMake(originX, 0, eachButton.frame.size.width, eachButton.frame.size.height);
        
        eachButton.frame = originFrame;
        
        [_scrollView addSubview:eachButton];
        
        originX = originX + eachButton.bounds.size.width + 8;
        index++;
    }
    
    CGSize contentSize = _scrollView.contentSize;
    contentSize.width = originX - 8;
    _scrollView.contentSize = contentSize;
    
    return _scrollView;
}

- (NSArray *)buttonsForTextView:(UITextView *)textView {
    return @[
             [self createButtonWithImage:@"icon-keyboard"
                         andEventHandler:^{
                             self.block(1);
                         }],
             [self createButtonWithImage:@"icon-help"
                         andEventHandler:^{
                             self.block(2);
                         }],
             [self createButtonWithTitle:@"清空"
                         andEventHandler:^{
                             self.block(3);
                         }],
             [self createButtonWithTitle:@"主题"
                         andEventHandler:^{
                             self.block(4);
                         }],
             [self createButtonWithTitle:@"预览"
                         andEventHandler:^{
                             self.block(5);
                         }],
             
             [self createButtonWithImage:@"bold.png"
                         andEventHandler:^{
                             NSRange selectionRange = textView.selectedRange;
                             selectionRange.location += 2;
                             selectionRange.length = 6;
                             [textView insertText:@"**Strong**"];
                             textView.selectedRange = selectionRange;
                         }],
             
             [self createButtonWithImage:@"italic.png"
                         andEventHandler:^{
                             NSRange selectionRange = textView.selectedRange;
                             selectionRange.location += 1;
                             selectionRange.length = 11;
                             [textView insertText:@"*Italic text*"];
                             textView.selectedRange = selectionRange;
                             
                         }],
             
             [self createButtonWithImage:@"link.png"
                         andEventHandler:^{
                             NSRange selectionRange = textView.selectedRange;
                             selectionRange.location += 5;
                             selectionRange.length = 14;
                             [textView insertText:@"[链接](http://example)"];
                             textView.selectedRange = selectionRange;
                             
                         }],
             
             [self createButtonWithImage:@"quote.png"
                         andEventHandler:^{
                             NSRange selectionRange = textView.selectedRange;
                             selectionRange.location += 3;
                             if (textView.text.length == 0) {
                                 [textView insertText:@"> "];
                             } else {
                                 [textView insertText:@"\n> "];
                             }
                             textView.selectedRange = selectionRange;
                         }],
             
             [self createButtonWithImage:@"code.png"
                         andEventHandler:^{
                             NSRange selectionRange = textView.selectedRange;
                             if (textView.text.length == 0) {
                                 selectionRange.location += 4;
                                 [textView insertText:@"```\n\n```"];
                             } else {
                                 selectionRange.location += 5;
                                 [textView insertText:@"\n```\n\n```"];
                             }
                             textView.selectedRange = selectionRange;
                         }],
             
             [self createButtonWithImage:@"img.png"
                         andEventHandler:^{
                             NSRange selectionRange = textView.selectedRange;
                             selectionRange.location += 9;
                             selectionRange.length = 15;
                             [textView insertText:@"![Image](http://resource)"];
                             textView.selectedRange = selectionRange;
                         }],
             
             [self createButtonWithImage:@"ol.png"
                         andEventHandler:^{
                             NSRange selectionRange = textView.selectedRange;
                             if (textView.text.length == 0) {
                                 selectionRange.location += 2;
                                 selectionRange.length = 9;
                                 [textView insertText:@"- List Item"];
                             } else {
                                 selectionRange.location += 3;
                                 selectionRange.length = 9;
                                 [textView insertText:@"\n- List Item"];
                             }
                             textView.selectedRange = selectionRange;
                         }],
             
             [self createButtonWithImage:@"title.png"
                         andEventHandler:^{
                             NSRange selectionRange = textView.selectedRange;
                             selectionRange.location += 2;
                             selectionRange.length = 4;
                             [textView insertText:@"# head"];
                             textView.selectedRange = selectionRange;
                             
                         }],
             
             [self createButtonWithImage:@"hr.png"
                         andEventHandler:^{
                             NSRange selectionRange = textView.selectedRange;
                             if (textView.text.length == 0) {
                                 selectionRange.location += 4;
                                 [textView insertText:@"---\n"];
                             } else {
                                 selectionRange.location += 5;
                                 [textView insertText:@"\n---\n"];
                             }
                             textView.selectedRange = selectionRange;
                         }]
             ];
}

- (BYToolboardToolBar *)createButtonWithImage:(NSString *)imageName
                           andEventHandler:(void (^)())handler {
    BYToolboardToolBar *button = [BYToolboardToolBar buttonWithImage:imageName];
    [button addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (BYToolboardToolBar *)createButtonWithTitle:(NSString *)title
                           andEventHandler:(void (^)())handler {
    BYToolboardToolBar *button = [BYToolboardToolBar buttonWithTitle:title];
    [button addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end

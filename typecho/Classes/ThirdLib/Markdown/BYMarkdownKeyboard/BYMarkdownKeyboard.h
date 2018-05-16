//
//  BYMarkdownKeyboard.h
//  Markdown
//
//  Created by 白云杰 on 16/12/28.
//  Copyright © 2016年 白云杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol keyboardDelegate <NSObject>

- (void)keyboardPopup;

@end

typedef void(^keybordBlock)(NSInteger index);

@interface BYMarkdownKeyboard : UIView

+ (instancetype)toolbarViewWithTextView:(UITextView *)textView keybordBlock:(keybordBlock )block;

/** 代理 */
@property (nonatomic, assign) id<keyboardDelegate> delegate;

@end

//
//  ALTextFiled.m
//  ArcBaiSi
//
//  Created by Arclin on 16/4/14.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALTextFiled.h"

static NSString * const ALPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation ALTextFiled

- (void)awakeFromNib
{
    // 设置光标颜色跟文字颜色一样
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 *  当前文本聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:ALPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 *  当前文本框失去焦点时会调用
 */
- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:ALPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}

/**
 *  运行时（Runtime）
 *  苹果官方一套C语言库  能做很多底层操作(比如访问隐藏的一些成员变量\成员方法....)
 */


@end

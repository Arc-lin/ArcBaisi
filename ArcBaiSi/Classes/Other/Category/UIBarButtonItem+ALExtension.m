//
//  UIBarButtonItem+ALExtension.m
//  ArcBaiSi
//
//  Created by Arclin on 16/2/28.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "UIBarButtonItem+ALExtension.h"

@implementation UIBarButtonItem (ALExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

@end

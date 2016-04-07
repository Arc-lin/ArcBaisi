//
//  ALTabBar.m
//  ArcBaiSi
//
//  Created by Arclin on 16/2/26.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALTabBar.h"
@interface ALTabBar()

@property (nonatomic,weak) UIButton *publicButton;

@end
@implementation ALTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        // 设置tabBar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        // 添加发布按钮
        UIButton *publicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publicButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publicButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publicButton];
        self.publicButton = publicButton;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的frame
    self.publicButton.width = self.publicButton.currentBackgroundImage.size.width;
    self.publicButton.height = self.publicButton.currentBackgroundImage.size.height;
    self.publicButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        // 计算按钮的X值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //增加索引
        index++;
    }
}

@end

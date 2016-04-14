//
//  ALVerticalButton.m
//  ArcBaiSi
//
//  Created by Arclin on 16/4/13.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALVerticalButton.h"

@implementation ALVerticalButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

/**
 *  通过代码创建控件
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 *  通过xib创建控件
 */
- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片控件
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end

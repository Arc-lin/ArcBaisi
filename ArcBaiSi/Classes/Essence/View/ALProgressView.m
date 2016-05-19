//
//  ALProgressView.m
//  ArcBaiSi
//
//  Created by Arclin on 16/5/18.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALProgressView.h"

@implementation ALProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end

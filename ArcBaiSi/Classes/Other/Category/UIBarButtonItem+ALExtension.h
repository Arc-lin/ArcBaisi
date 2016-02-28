//
//  UIBarButtonItem+ALExtension.h
//  ArcBaiSi
//
//  Created by Arclin on 16/2/28.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ALExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end

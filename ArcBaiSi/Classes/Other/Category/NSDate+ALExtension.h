//
//  NSDate+ALExtension.h
//  ArcBaiSi
//
//  Created by Arclin on 16/5/13.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ALExtension)

/**
 *  比较form和self的时间差值
 */
- (NSDateComponents *)deltaForm:(NSDate *)from;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

@end

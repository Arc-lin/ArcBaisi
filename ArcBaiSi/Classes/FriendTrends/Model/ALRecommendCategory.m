//
//  ALRecommendCategory.m
//  ArcBaiSi
//
//  Created by Arclin on 16/4/7.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALRecommendCategory.h"

@implementation ALRecommendCategory

/**
 *  懒加载
 */
- (NSMutableArray *) users
{
    if(!_users){
        _users = [NSMutableArray array];
    }
    return _users;
}

@end

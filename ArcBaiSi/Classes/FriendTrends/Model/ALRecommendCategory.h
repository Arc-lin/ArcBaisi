//
//  ALRecommendCategory.h
//  ArcBaiSi
//
//  Created by Arclin on 16/4/7.
//  Copyright © 2016年 sziit. All rights reserved.
//  推荐关注 左边的模型

#import <Foundation/Foundation.h>

@interface ALRecommendCategory : NSObject

/**
 * id
 */
@property (nonatomic,assign) NSInteger ID;

/**
 * 总数
 */
@property (nonatomic,assign) NSInteger count;

/**
 *  名字
 */
@property (nonatomic,copy) NSString *name;

/**
 * 这个类别对应的用户数据
 */
@property (nonatomic,strong) NSMutableArray *users;

/**
 *  总数
 */
@property (nonatomic,assign) NSInteger total;

/**
 * 页码
 */
@property (nonatomic,assign) NSInteger currentPage;



@end

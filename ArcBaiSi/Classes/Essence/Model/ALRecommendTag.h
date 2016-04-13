//
//  ALRecommendTag.h
//  ArcBaiSi
//
//  Created by Arclin on 16/4/13.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALRecommendTag : NSObject

/**
 *  图片
 */
@property (nonatomic,copy) NSString *image_list;

/**
 *  名字
 */
@property (nonatomic,copy) NSString *theme_name;

/**
 * 订阅数
 */
@property (nonatomic,assign) NSInteger sub_number;


@end

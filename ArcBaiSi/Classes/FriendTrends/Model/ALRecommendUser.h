//
//  ALRecommendUser.h
//  ArcBaiSi
//
//  Created by Arclin on 16/4/8.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALRecommendUser : NSObject
/**
 *  头像
 */
@property (nonatomic,copy) NSString *header;

/**
 * 粉丝数(有多少人关注这个用户)
 */
@property (nonatomic,assign) NSInteger fans_count;

/**
 *  昵称
 */
@property (nonatomic,copy) NSString *screen_name;


@end

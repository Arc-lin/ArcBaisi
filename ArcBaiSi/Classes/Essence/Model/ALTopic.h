//
//  ALTopic.h
//  ArcBaiSi
//
//  Created by Arclin on 16/5/7.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALTopic : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

/**
 * 是否为新浪加V用户
 */
@property (nonatomic,assign,getter=isSina_v) BOOL sina_V;


@end
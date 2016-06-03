//
//  ALComment.h
//  ArcBaiSi
//
//  Created by Arclin on 16/5/25.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALUser;

@interface ALComment : NSObject

/** 音频文件的时长 */
@property (nonatomic,assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic,copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic,assign) NSInteger like_count;
/** 用户 */
@property (nonatomic,strong) ALUser *user;

@end

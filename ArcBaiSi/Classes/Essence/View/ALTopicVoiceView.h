//
//  ALTopicVoiceView.h
//  ArcBaiSi
//
//  Created by Arclin on 16/5/25.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALTopic;

@interface ALTopicVoiceView : UIView

+ (instancetype)voiceView;

/** 帖子数据 */
@property (nonatomic,strong) ALTopic *topic;

@end

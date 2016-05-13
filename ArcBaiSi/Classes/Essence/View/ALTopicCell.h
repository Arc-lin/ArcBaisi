//
//  ALTopicCell.h
//  ArcBaiSi
//
//  Created by Arclin on 16/5/13.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALTopic;

@interface ALTopicCell : UITableViewCell

/**
 * 帖子数据
 */
@property (nonatomic,strong) ALTopic *topic;

@end

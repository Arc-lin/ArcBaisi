//
//  ALCommentViewController.h
//  ArcBaiSi
//
//  Created by Arclin on 16/6/1.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALTopic;

@interface ALCommentViewController : UIViewController

/** 帖子模型 */
@property (nonatomic,strong) ALTopic *topic;

@end

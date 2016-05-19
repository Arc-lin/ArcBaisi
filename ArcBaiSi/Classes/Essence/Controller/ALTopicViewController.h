//
//  ALTopicViewController.h
//  ArcBaiSi
//
//  Created by Arclin on 16/5/13.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALTopicViewController : UITableViewController

/**
 * 帖子类型（交给子类去实现）
 */
@property (nonatomic,assign) ALTopicType type;


@end

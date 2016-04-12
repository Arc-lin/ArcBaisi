//
//  ALRecommendUserCell.h
//  ArcBaiSi
//
//  Created by Arclin on 16/4/8.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALRecommendUser;

@interface ALRecommendUserCell : UITableViewCell

/**
 * 用户模型
 */
@property (nonatomic,strong) ALRecommendUser *user;

@end

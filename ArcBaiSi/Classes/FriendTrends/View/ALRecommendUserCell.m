//
//  ALRecommendUserCell.m
//  ArcBaiSi
//
//  Created by Arclin on 16/4/8.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALRecommendUserCell.h"
#import "ALRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface ALRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanscountLabel;


@end

@implementation ALRecommendUserCell

- (void)setUser:(ALRecommendUser *)user
{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    self.fanscountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end

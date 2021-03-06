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
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end

@implementation ALRecommendUserCell

- (void)setUser:(ALRecommendUser *)user
{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    } else { // 大于等于10000
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end

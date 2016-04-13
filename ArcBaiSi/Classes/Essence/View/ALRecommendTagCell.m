//
//  ALRecommendTagCell.m
//  ArcBaiSi
//
//  Created by Arclin on 16/4/13.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALRecommendTagCell.h"
#import "ALRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface ALRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation ALRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setRecommendTag:(ALRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{ // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end

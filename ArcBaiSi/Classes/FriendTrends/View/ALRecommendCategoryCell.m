//
//  ALRecommendCategoryCell.m
//  ArcBaiSi
//
//  Created by Arclin on 16/4/7.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALRecommendCategoryCell.h"
#import "ALRecommendCategory.h"

@interface ALRecommendCategoryCell()

/**
 *   选中时显示的指示器控件
 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation ALRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = ALRGBColor(244,244,244);
    self.selectedIndicator.backgroundColor = ALRGBColor(219, 21, 26);
    // 当cell的selection为None时, cell被选中时, 内部的子控件就不会进入高亮状态

}

- (void)setCategory:(ALRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;

    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : ALRGBColor(78, 78, 78);
}

@end

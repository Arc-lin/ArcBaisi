//
//  ALTopic.m
//  ArcBaiSi
//
//  Created by Arclin on 16/5/7.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALTopic.h"
#import "ALComment.h"
#import "ALUser.h"

@implementation ALTopic
{
    CGFloat _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image": @"image2",
             @"ID":@"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt":@"ALComment"};
}

- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaForm:create];
            
            if (cmps.hour >= 1) { //    时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        }else if(create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }else { // 非今年
        return _create_time;
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * ALTopicCellMargin, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // cell的高度
        // 文字部分的高度
        _cellHeight = ALTopicCellTextY + textH + ALTopicCellMargin;
        
        // 根据段子类型来计算cell的高度
        if(self.type == ALTopicTypePicture){ // 图片帖子
            // 图片显示出来的高度
            CGFloat pictureW = maxSize.width;
            // 显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
            if (pictureH >= ALTopicCellPictureMaxH){ // 图片高度过长
                pictureH = ALTopicCellPictureBreakH;
                self.bigPicture = YES; // 大图
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = ALTopicCellMargin;
            CGFloat pictureY = ALTopicCellTextY + textH + ALTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + ALTopicCellMargin;
            
        } else if(self.type == ALTopicTypeVoice){ // 声音帖子
            CGFloat voiceX = ALTopicCellMargin;
            CGFloat voiceY = ALTopicCellTextY + textH + ALTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + ALTopicCellMargin;
        }else if(self.type == ALTopicTypeVideo){ // 视频帖子
            CGFloat videoX= ALTopicCellMargin;
            CGFloat videoY = ALTopicCellTextY + textH + ALTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + ALTopicCellMargin;
        }
        
        // 如果有最热评论
        ALComment *cmt = [self.top_cmt firstObject];
        if(cmt){
            NSString *content = [NSString stringWithFormat:@"%@ : %@",cmt.user.username,cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            
            _cellHeight += ALTopicCellTopCmtTitleH + contentH + ALTopicCellMargin * 2;
        }
        
        // 底部工具条的高度
        _cellHeight += ALTopicCellBottomBarH + ALTopicCellMargin;
    }
    
    return _cellHeight;
}

@end

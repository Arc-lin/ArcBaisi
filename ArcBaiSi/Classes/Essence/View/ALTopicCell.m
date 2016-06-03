//
//  ALTopicCell.m
//  ArcBaiSi
//
//  Created by Arclin on 16/5/13.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALTopicCell.h"
#import "ALTopic.h"
#import "ALTopicPictureView.h"
#import "ALTopicVideoView.h"
#import "ALTopicVoiceView.h"
#import "ALComment.h"
#import "ALUser.h"

@interface ALTopicCell()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */ 
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property (nonatomic,weak) ALTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property (nonatomic,weak) ALTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property (nonatomic,weak) ALTopicVideoView *videoView;
/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation ALTopicCell

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (ALTopicPictureView *)pictureView
{
    if (!_pictureView) {
        ALTopicPictureView *pictureView = [ALTopicPictureView  pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (ALTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        ALTopicVoiceView *voiceView = [ALTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (ALTopicVideoView *)videoView
{
    if (!_videoView) {
        ALTopicVideoView *videoView = [ALTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    // 添加cell的阴影
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(ALTopic *)topic
{
    _topic = topic;
    
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

    // 设置名字
    self.nameLabel.text = topic.name;
    
    // 设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholdr:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholdr:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholdr:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholdr:@"评论"];
    
    // 设置帖子的文字内容
    self.text_label.text = topic.text;
    
    // 根据模型类型（帖子类型）添加对应的内容到cell的中间
    if (topic.type == ALTopicTypePicture) { // 图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if(topic.type == ALTopicTypeVoice){ // 声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if(topic.type == ALTopicTypeVideo){ // 视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else{ // 段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    // 处理最热评论
    ALComment *cmt = [topic.top_cmt firstObject];
    if (cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
}

/** 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholdr:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if(count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}


- (void)setFrame:(CGRect)frame
{
    frame.origin.x = ALTopicCellMargin;
    frame.size.width -= 2 * ALTopicCellMargin;
    frame.size.height = self.topic.cellHeight - ALTopicCellMargin;
    frame.origin.y += ALTopicCellMargin;
    
    [super setFrame:frame];
}

- (IBAction)more:(id)sender {
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:nil]];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self.window];
    
}

@end

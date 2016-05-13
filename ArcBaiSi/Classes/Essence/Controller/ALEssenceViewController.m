//
//  ALEssenceViewController.m
//  ArcBaiSi
//
//  Created by Arclin on 16/2/24.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALEssenceViewController.h"
#import "ALRecommendTagsViewController.h"
#import "ALTopicViewController.h"

@interface ALEssenceViewController ()<UIScrollViewDelegate>

/**
 *  当前选中的按钮
 */
@property (nonatomic,weak) UIButton *selectButton;

/**
 *  标签栏底部的红色指示器
 */
@property (nonatomic,weak) UIView *indicatorView;

/**
 *  顶部的所有标签
 */
@property (nonatomic,weak) UIView *titlesView;

/**
 *  底部的所有内容
 */
@property (nonatomic,weak) UIScrollView *contentView;


@end

@implementation ALEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildVcs];
    
    // 设置顶部的标签栏
    [self setupTitlesView];

    // 设置底部的scrollerView
    [self setupContentView];
}

/**
 *  初始化子控制器
 */
- (void)setupChildVcs
{
    ALTopicViewController *all = [[ALTopicViewController alloc] init];
    all.title = @"全部";
    all.type = ALTopicTypeAll;
    [self addChildViewController:all];
    
    ALTopicViewController *video = [[ALTopicViewController alloc] init];
    video.title = @"视频";
    video.type = ALTopicTypeVideo;
    [self addChildViewController:video];
    
    ALTopicViewController *voice = [[ALTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = ALTopicTypeVoice;
    [self addChildViewController:voice];
    
    ALTopicViewController *picture = [[ALTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = ALTopicTypePicture;
    [self addChildViewController:picture];
    
    ALTopicViewController *word = [[ALTopicViewController alloc] init];
    word.title = @"段子";
    word.type = ALTopicTypeWord;
    [self addChildViewController:word];
}

/**
 *  设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height =  height;
        button.width = width;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
//            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}].width;
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectButton.enabled = YES;
    button.enabled = NO;
    self.selectButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX  = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 *  底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0]; // 图层位置调整
    
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添第一个控制器的View
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 *  设置导航栏
 */
- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagButtonClick)];

    // 设置背景色
    self.view.backgroundColor = ALGlobalBg;
}

- (void)tagButtonClick
{
    ALRecommendTagsViewController *tags = [[ALRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器的View的y值为0 （默认是20）
    vc.view.height = scrollView.height;//设置控制器view的height的值为整个屏幕的高度（默认比屏幕高度少20px）
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end

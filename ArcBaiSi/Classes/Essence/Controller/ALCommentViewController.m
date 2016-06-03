//
//  ALCommentViewController.m
//  ArcBaiSi
//
//  Created by Arclin on 16/6/1.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALCommentViewController.h"
#import "UIBarButtonItem+ALExtension.h"
#import "ALTopicCell.h"
#import "ALComment.h"
#import "ALTopic.h"

@interface ALCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 工具条底部间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic,strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic,strong) NSMutableArray *lastestComments;

@end

@implementation ALCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewComments
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        // 最热评论
        self.hotComments = [ALComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.lastestComments = [ALComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setupHeader
{
    // header
    UIView *header = [[UIView alloc] init];

    // 添加cell
    ALTopicCell *cell = [ALTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(ALScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    // header的高度
    header.height = self.topic.cellHeight + ALTopicCellMargin;
    
    // 设置header
    self.tableView.tableHeaderView = header;
}

- (void)setupBasic
{
    self.title = @"评论";

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.backgroundColor = ALGlobalBg;
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘显示 \ 隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomSpace.constant = ALScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画 及时刷新
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.lastestComments;
    }
    return self.lastestComments;
}

- (ALComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDataSorce>
-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastCount = self.lastestComments.count;
    
    if (hotCount) return 2; // 有“最热评论” + “最新评论” 2组
    if (lastCount) return 1; // 有"最新评论" 1组
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastestCount = self.lastestComments.count;
    if (section == 0) {
        return hotCount ? hotCount : lastestCount;
    }
    
    // 非第0组
    return lastestCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        return hotCount ? @"最热评论" : @"最新评论";
    }
    return @"最新评论";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    
    ALComment *comment = [self commentInIndexPath:indexPath];
    cell.textLabel.text = comment.content;
    
    return cell;
}

@end





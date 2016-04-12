//
//  ALRecommendViewController.m
//  ArcBaiSi
//
//  Created by Arclin on 16/4/6.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALRecommendViewController.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>

#import "ALRecommendCategoryCell.h"
#import "ALRecommendCategory.h"

#import "ALRecommendUserCell.h"
#import "ALRecommendUser.h"

#define ALSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface ALRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 * 左边的类别数据
 */
@property (nonatomic,strong) NSArray *categories;
/**
 *  左边的类别表格
 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/**
 *  右边的用户表格
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/**
 * 请求参数
 */
@property (nonatomic,strong) NSMutableDictionary *params;

/**
 * AFN请求管理者
 */
@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation ALRecommendViewController

static NSString * const ALCategoryCellId = @"category";
static NSString * const ALUserCellId = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];

//     控件的初始化
    [self setUpTableView];
    
    // 添加刷新控件
    [self setupRefesh];
    
    // 加载左侧的类别数据
    [self loadCategories];
    
}

/**
 *  控件的初始化
 */
- (void)setUpTableView
{
    [self.categoryTableView registerNib:[UINib nibWithNibName:@"ALRecommendCategoryCell" bundle:nil] forCellReuseIdentifier:ALCategoryCellId];
    
    [self.userTableView registerNib:[UINib nibWithNibName:@"ALRecommendUserCell" bundle:nil] forCellReuseIdentifier:ALUserCellId];
    
    // 设置inset
    self.userTableView.rowHeight = 70;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = ALGlobalBg;
}

#pragma mark - 加载左侧的类别数据
- (void)loadCategories
{
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的json数据
        self.categories = [ALRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}


/**
 *  添加刷新控件
 */
- (void)setupRefesh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];

    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;
}

#pragma mark - 加载用户数据
- (void)loadNewUsers
{
    ALRecommendCategory  *rc = ALSelectedCategory;
    
    // 设置当前页码为1
    rc.currentPage = 1;
    
    // 请求参数
    // 发送请求给服务器
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        // 字典数组 -> 模型数组
        NSArray *users = [ALRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除所有旧数据
        [rc.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        // 保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
        
    }];

}

- (void)loadMoreUsers
{
    ALRecommendCategory  *rc = ALSelectedCategory;
    
    // 请求参数
    // 发送请求给服务器
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(++rc.currentPage);
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典数组 -> 模型数组
        NSArray *users = [ALRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        // 保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
        
    }];
    
}

/**
 *  时刻监测footer的状态
 */
- (void)checkFooterState
{
    ALRecommendCategory *rc = ALSelectedCategory;

    // 每次刷新右边的数据的时候
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) { // 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        return self.categories.count;
    }else{ // 右边的用户表格
        ALRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        return c.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
    
        ALRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ALCategoryCellId];
        
        cell.category = self.categories[indexPath.row]; 
        
        return cell;
    }else{  // 右边的用户表格
        
        ALRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ALUserCellId];
        
        ALRecommendCategory *c = ALSelectedCategory;
        
        cell.user = c.users[indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    if (tableView == self.categoryTableView) {
    
        ALRecommendCategory *c = self.categories[indexPath.row];
        
        if (c.users.count) {
            // 显示曾经的数据
            [self.userTableView reloadData];
        }else{
            
            // 赶紧刷新表格，目的是：马上显示当前category的用户数据，不让用户看见上一个category的残留数据
            [self.userTableView reloadData];
            
            // 进入下拉刷新状态
            [self.userTableView.mj_header beginRefreshing];
        }
    
    }
}

- (void)dealloc
{
    // 停止所有的操作
    [self.manager.operationQueue cancelAllOperations];
}

@end

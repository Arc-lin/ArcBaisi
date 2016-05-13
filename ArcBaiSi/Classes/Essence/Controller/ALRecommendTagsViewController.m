//
//  ALRecommendTagsViewController.m
//  ArcBaiSi
//
//  Created by Arclin on 16/4/12.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALRecommendTagsViewController.h"
#import "ALRecommendTag.h"
#import "ALRecommendTagCell.h"

@interface ALRecommendTagsViewController ()

/**
 * 标签数据
 */
@property (nonatomic,strong) NSArray *tags;

@end

@implementation ALRecommendTagsViewController

static NSString *ALTagsCellID = @"cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpaTableView];
  
    [self loadTags];
}

- (void)setUpaTableView
{
    
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ALRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:ALTagsCellID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = ALGlobalBg;
}

- (void)loadTags
{
    // 发送请求
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];

    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.tags = [ALRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ALTagsCellID];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end

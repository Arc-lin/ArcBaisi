//
//  ALFriendTrendsViewController.m
//  ArcBaiSi
//
//  Created by Arclin on 16/2/24.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALFriendTrendsViewController.h"
#import "ALRecommendViewController.h"
#import "ALLoginRegisterViewController.h"

@interface ALFriendTrendsViewController ()

@end

@implementation ALFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];

}
- (void)friendsClick
{
    ALRecommendViewController *vc = [[ALRecommendViewController  alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginRegisterBtnClick:(id)sender {
    // 会自动注册对应的xib
    ALLoginRegisterViewController *vc = [[ALLoginRegisterViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

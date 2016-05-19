//
//  ALTabBarController.m
//  ArcBaiSi
//
//  Created by Arclin on 16/2/24.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALTabBarController.h"
#import "ALEssenceViewController.h"
#import "ALNewViewController.h"
#import "ALFriendTrendsViewController.h"
#import "ALMeViewController.h"
#import "ALNavigationController.h"
#import "ALTabBar.h"

@interface ALTabBarController ()

@end

@implementation ALTabBarController

+ (void)initialize
{
    // 通过appearance 统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance统一设置属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加子控制器
    [self setUpChildVc:[[ALEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setUpChildVc:[[ALNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setUpChildVc:[[ALFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setUpChildVc:[[ALMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 更改类
    [self setValue:[[ALTabBar alloc] init] forKeyPath:@"tabBar"];

}

#pragma mark 初始化子控制器
- (void)setUpChildVc:(UIViewController  *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //  包装一个导航控制器，添加导航控制器为tabBarController的子控制器
    ALNavigationController *nav = [[ALNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

@end

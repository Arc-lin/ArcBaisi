//
//  ALLoginRegisterViewController.m
//  ArcBaiSi
//
//  Created by Arclin on 16/4/13.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALLoginRegisterViewController.h"

@interface ALLoginRegisterViewController ()

/**
 *  登录框和父视图的左边约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation ALLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 *  让当前控制对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)showLoginOrRegister:(UIButton *)button
{
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { // 显示注册页面
       
        self.loginViewLeftMargin.constant = -self.view.width;
        button.selected = YES;
        
    }else{ // 显示登录页面
        
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

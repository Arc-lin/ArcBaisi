//
//  ALMeViewController.m
//  ArcBaiSi
//
//  Created by Arclin on 16/2/24.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALMeViewController.h"

@interface ALMeViewController ()

@end

@implementation ALMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *nightModeItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeButton)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightModeItem];

}

- (void)settingClick
{
    ALLog(@"");
}

- (void)nightModeButton
{
    ALLog(@"");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

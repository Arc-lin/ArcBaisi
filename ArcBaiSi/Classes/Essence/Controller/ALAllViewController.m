//
//  ALAllViewController.m
//  ArcBaiSi
//
//  Created by Arclin on 16/4/18.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALAllViewController.h"

@interface ALAllViewController ()

@end

@implementation ALAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd", [self class], indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALLog(@"%@", NSStringFromUIEdgeInsets(tableView.contentInset));
    ALLog(@"%@", NSStringFromCGRect(tableView.frame));
}



@end

//
//  ZZFeedbackVC.m
//  TalentService
//
//  Created by charles on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZFeedbackVC.h"
#import "ZZIQKeyBoardTool.h"
@interface ZZFeedbackVC ()

@end

@implementation ZZFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ZZKeyBoardTool(close);
    
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

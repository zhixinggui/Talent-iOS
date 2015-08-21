//
//  ZZNextForgetVC.m
//  TalentService
//
//  Created by charles on 15/8/20.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZNextForgetVC.h"
#import "ZZTextField.h"
@interface ZZNextForgetVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *PassWordTF;
@property (strong, nonatomic) IBOutlet ZZTextField *againSecrectTF;

@end

@implementation ZZNextForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    [self.PassWordTF addLeftViewImageString:@"T3"];
    [self.againSecrectTF addLeftViewImageString:@"T3"];
    
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

//
//  ZZForgetVC.m
//  TalentService
//
//  Created by charles on 15/8/20.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZForgetVC.h"
#import "ZZTextField.h"
#import "ZZNextForgetVC.h"
@interface ZZForgetVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *phoneTF;
@property (strong, nonatomic) IBOutlet ZZTextField *messageTF;

@end

@implementation ZZForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    [self.phoneTF addLeftViewImageString:@"T3"];
    [self.messageTF addLeftViewImageString:@"T3"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextSecrectView:(UIButton *)sender {
    ZZNextForgetVC *nextForVc = [[ZZNextForgetVC alloc]initWithNibName:@"ZZNextForgetVC" bundle:nil];
    [self.navigationController pushViewController:nextForVc animated:YES];
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

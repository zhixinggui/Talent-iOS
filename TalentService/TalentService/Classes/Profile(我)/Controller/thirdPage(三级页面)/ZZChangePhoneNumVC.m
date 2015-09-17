//
//  ZZChangePhoneNumVC.m
//  TalentService
//
//  Created by charles on 15/9/16.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZChangePhoneNumVC.h"

@interface ZZChangePhoneNumVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@end

@implementation ZZChangePhoneNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机号";
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.phoneTF setLeftView:whiteView];
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
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

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
#import "ZZLayerButton.h"
@interface ZZForgetVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *phoneTF;
@property (strong, nonatomic) IBOutlet ZZTextField *messageTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *nextButton;
@property (weak, nonatomic) IBOutlet ZZSecurityButton *securityButton;

@end

@implementation ZZForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    //调整xib中的控件属性
    [self  setUppropertys];
 
}

- (void)setUppropertys{
    [self.phoneTF addLeftViewImageString:@"phone_30x30"];
    [self.messageTF addLeftViewImageString:@"message_30x30"];
    /**
     *  设置button颜色
     */
    self.nextButton.backgroundColor = LoginButtonColor;
    [ self.securityButton  setCornerRadius:10 borderColor:ZZNatiBarColor];
    [self.securityButton  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
}

- (IBAction)nextSecrectView:(UIButton *)sender {
    ZZNextForgetVC *nextForVc = [[ZZNextForgetVC alloc]initWithNibName:@"ZZNextForgetVC" bundle:nil];
    [self.navigationController pushViewController:nextForVc animated:YES];
}
- (IBAction)securityButtonAction:(ZZSecurityButton *)sender {
    [sender  startWithSecond:ZZSecerityTime];
}
-(void)dealloc{
    [self.securityButton clearButton];
}

@end

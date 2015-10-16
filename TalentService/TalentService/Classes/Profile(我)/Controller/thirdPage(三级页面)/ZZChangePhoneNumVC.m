//
//  ZZChangePhoneNumVC.m
//  TalentService
//
//  Created by charles on 15/9/16.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZChangePhoneNumVC.h"
#import "ZZLoginUserTool.h"
#import "ZZMyInfoHttpTool.h"
#import "ZZSecurityButton.h"
#import "ZZLoadHttpTool.h"
@interface ZZChangePhoneNumVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *securtyTF;

@end

@implementation ZZChangePhoneNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机号";
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.phoneTF setLeftView:whiteView];
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    UIView *whiteView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    whiteView1.backgroundColor = [UIColor whiteColor];
    [self.securtyTF setLeftView:whiteView1];
    self.securtyTF.leftViewMode = UITextFieldViewModeAlways;
    [self setNavRightItemWithName:@"保存" target:self action:@selector(changePhoneAction:)];
    
    self.phoneTF.text = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.userPhone;
    [self.securtyTF setEnabled:NO];
    
}


/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}


-(void)changePhoneAction:(UIButton*)button{
    if ([self.phoneTF.text  isCorrectPhoneNumber] == NO) {
        [self.phoneTF  shakeAnimation];
        return;
    }
    if ([self.securtyTF.text  isPassWordWithMin:ZZMiMaMinLenth max:ZZMiMaMaxLenth]== NO) {
        [self.securtyTF shakeAnimation];
        return;
    }
    //上传修改信息
        ZZChangeInfoParam *infoParam = [[ZZChangeInfoParam alloc]init];
        infoParam.userPhone = self.phoneTF.text;
        infoParam.securityCode = self.securtyTF.text;
        [MBProgressHUD showMessage:@"正在保存中..."];
        [ZZMyInfoHttpTool changeInfoWithChangeInfoParam:infoParam success:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
            [MBProgressHUD  hideHUD];
            [MBProgressHUD  showSuccess:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *error, ZZNetDataType datatype) {
            [MBProgressHUD  hideHUD];
            [MBProgressHUD  showError:error];
        }];
    
}

- (IBAction)didClickOnSecurty:(ZZSecurityButton *)sender {
    if ([self.phoneTF.text  isCorrectPhoneNumber] == NO) {
        [self.phoneTF  shakeAnimation];
        return;
    }
     [sender  startWithSecond:ZZSecerityTime];
    [MBProgressHUD showMessage:@"正在发送..."];
    [ZZLoadHttpTool loadGetCode:self.phoneTF.text success:^(id json, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showSuccess:@"获取验证码成功"];
        
        [self.securtyTF setEnabled:YES];
        [self.securtyTF  becomeFirstResponder];
    } failure:^(NSString *error, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showError:error];
    }];

    
}

@end

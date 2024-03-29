//
//  ZZRegistVC.m
//  TalentService
//
//  Created by charles on 15/8/19.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZRegistVC.h"
#import "ZZTextField.h"
#import "ZZNextRegistVC.h"
#import "ZZLayerButton.h"
#import "ZZSecurityButton.h"
#import "ZZLoadHttpTool.h"
@interface ZZRegistVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *phoneTF;
@property (strong, nonatomic) IBOutlet ZZTextField *messageTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *nextButton;
@property (weak, nonatomic) IBOutlet ZZSecurityButton *securityButton;
@property (nonatomic, copy)NSString *phone;
@end

@implementation ZZRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"注册"];
    //调整xib中的控件属性
    [self  setUppropertys];
  
}
- (void)setUppropertys{
    [self.phoneTF addLeftViewImageString:@"phone_30x30"];
    [self.messageTF addLeftViewImageString:@"key_30x30"];
    /**
     *  设置button颜色
     */
    self.messageTF.enabled = NO;
    [self.nextButton  setBackgroundColor:ZZNatiBarColor];
    [ self.securityButton  setCornerRadius:10 borderColor:ZZNatiBarColor];
    [self.securityButton  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
}
- (IBAction)gotoNextRegist:(UIButton *)sender {
    [self.view  endEditing:YES];
    if ([self.phoneTF.text  isEqualToString:self.phone]) {
        if ([self.messageTF.text  isSecutityNumber]) {
    
             [MBProgressHUD showMessage:@"验证中..."];
            [ZZLoadHttpTool  loadVerifyCode:self.phoneTF.text code:self.messageTF.text success:^(id json , ZZNetDataType dataType) {//请求
    
                [MBProgressHUD  hideHUD];
                 [MBProgressHUD  showSuccess:@"验证成功"];
                ZZNextRegistVC *nextRegistVc = [[ZZNextRegistVC alloc]initWithNibName:@"ZZNextRegistVC" bundle:nil];
                nextRegistVc.phone = self.phone;
                [self.navigationController pushViewController:nextRegistVc animated:YES];
            } failure:^(NSString *error, ZZNetDataType dataType) {

                [MBProgressHUD  hideHUD];
                [MBProgressHUD  showError:error];
            }];
            
        }else{
            [self.messageTF  shakeAnimation];
        }
    }else{
         [self.phoneTF  shakeAnimation];
    }

}
- (IBAction)securityButtonAction:(ZZSecurityButton *)sender {
    
    if ([self.phoneTF.text  isCorrectPhoneNumber]) {
        
       [sender  startWithSecond:ZZSecerityTime];
        self.phone = self.phoneTF.text;
        
          [MBProgressHUD showMessage:@"获取验证码中..."];
        [ZZLoadHttpTool  loadGetResignCode:self.phone success:^(id json, ZZNetDataType dataType) {
            
            [MBProgressHUD  hideHUD];
              self.messageTF.enabled = YES;
            [self.messageTF  becomeFirstResponder];
            [MBProgressHUD  showSuccess:@"获取验证码成功"];
        } failure:^(NSString *error, ZZNetDataType dataType) {
            
            [MBProgressHUD  hideHUD];
            [MBProgressHUD  showError:error];
        }];
      
    }else{
        [self.phoneTF  shakeAnimation];
    }

}



-(void)dealloc{
    [self.securityButton clearButton];
}

@end

//
//  ZZNextForgetVC.m
//  TalentService
//
//  Created by charles on 15/8/20.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZNextForgetVC.h"
#import "ZZTextField.h"
#import "ZZLayerButton.h"
#import "ZZLoadHttpTool.h"
#import "ZZLoginUserTool.h"
@interface ZZNextForgetVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *PassWordTF;
@property (strong, nonatomic) IBOutlet ZZTextField *againSecrectTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *finishButton;

@end

@implementation ZZNextForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    //调整xib中的控件属性
    [self  setUppropertys];
   
}
- (void)setUppropertys{
    [self.PassWordTF addLeftViewImageString:@"key_30x30"];
    [self.againSecrectTF addLeftViewImageString:@"key_30x30"];
    /**
     *  设置button颜色
     */
    self.finishButton.backgroundColor = LoginButtonColor;
}
- (IBAction)doneButtonAction:(UIButton *)sender {
    if ([self.PassWordTF.text  isPassWordWithMin:ZZMiMaMinLenth max:ZZMiMaMaxLenth] == NO) {
        [self.PassWordTF  shakeAnimation];
        return;
    }
    
    if ([self.againSecrectTF.text isPassWordWithMin:ZZMiMaMinLenth max:ZZMiMaMaxLenth] == NO || [self.againSecrectTF.text  isEqualToString:self.PassWordTF.text]==NO) {
        [self.againSecrectTF shakeAnimation];
        return;
    }
    
    [MBProgressHUD showMessage:@"服务器连接中"];
   [ZZLoadHttpTool loadForgetPWD:self.phone word:self.PassWordTF.text success:^(ZZLoginUser *loginUser, ZZNetDataType netDataType) {
       
       [[ZZLoginUserTool  sharedZZLoginUserTool] save:loginUser];
       [MBProgressHUD  hideHUD];
       [MBProgressHUD  showSuccess:@"密码重置成功"];
       [self  swithWindowRootControllerToHome];
   } failure:^(NSString *error, ZZNetDataType dataType) {
       
       [MBProgressHUD  hideHUD];
       [MBProgressHUD  showError:error];
   }];
}


@end

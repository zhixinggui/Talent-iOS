//
//  ZZFirstLoginVC.m
//  TalentService
//
//  Created by charles on 15/8/18.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZFirstLoginVC.h"
#import "ZZTextField.h"
#import "ZZForgetVC.h"
#import "ZZLayerButton.h"
#import "ZZThirdVC.h"
#import "ZZUMTool.h"
#import "ZZHttpTool.h"
#import "ZZCityTool.h"
#import "ZZLoadHttpTool.h"
#import "ZZLoginUserTool.h"
#import "ZZUMMessageTool.h"

#define  ButtonHeight   360
@interface ZZFirstLoginVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *phoneNumTF;
@property (strong, nonatomic) IBOutlet ZZTextField *secrectTF;

@property (strong, nonatomic) IBOutlet ZZLayerButton *loginButton;
@end

@implementation ZZFirstLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  给textfield的leftview设置图片
     */
    self.title = @"登录";
    [self  setUpPropertys];
    [self  setUpThirdLogin];
    
}

//设置输入框的左边距
- (void)setUpPropertys{
    [self.phoneNumTF addLeftViewImageString:@"phone_30x30"];
    [self.secrectTF addLeftViewImageString:@"key_30x30"];
    /**
     *  设置右button
     */
    [self setNavRightItemWithName:@"忘记密码" target:self action:@selector(didClickOnTestSelect:)];
    /**
     *  设置button颜色
     */
    self.loginButton.backgroundColor = LoginButtonColor;
}
//创建三方登陆
- (void)setUpThirdLogin{
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray*  array = [ZZUMTool  sharedUMTool].loginModels;
        CGFloat  leftMargin = 20;
        CGFloat   benWidth = 60;
        CGFloat  left = (ScreenWidth - 2*leftMargin - array.count*benWidth)/(array.count + 1) ;
            dispatch_async(dispatch_get_main_queue(), ^{
                for (int  i = 0; i < array.count; i++) {
                    ZZUMLoginModel *loginModel = array[i];
                    UIButton* loginButton = [[UIButton alloc]initWithFrame:CGRectMake(i*benWidth+left*i+leftMargin, ButtonHeight, 60, 60)];
                    loginButton.exclusiveTouch = YES;
                    [loginButton setBackgroundImage:[UIImage imageNamed:loginModel.imageName] forState:UIControlStateNormal];
                    [loginButton  addTarget:self action:@selector(thirdLoginButtonAction:) forControlEvents: UIControlEventTouchUpInside];
                    loginButton.tag = i;
                    
                    [self.view addSubview:loginButton];
                }
            });
    });
}
/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;

}
#pragma mark - 响应事件

- (IBAction)loginButtonAction:(UIButton *)sender {
    if ([self.phoneNumTF.text  isCorrectPhoneNumber] == NO) {
        [self.phoneNumTF  shakeAnimation];
        return;
    }
    if ([self.secrectTF.text  isPassWordWithMin:ZZMiMaMinLenth max:ZZMiMaMaxLenth]== NO) {
        [self.secrectTF shakeAnimation];
        return;
    }
    
    ZZLoginParam *param = [[ZZLoginParam alloc]init];
    param.loginAccount = self.phoneNumTF.text;
    param.loginPassword = self.secrectTF.text;
    param.thirdType = @(ZZLoginTypeSmart);
    [MBProgressHUD  showMessage:@"登录中..."];
    
    [ZZLoadHttpTool  loadLogin:param success:^(ZZLoginUser * loginUser, ZZNetDataType dataType) {
        
        [[ZZLoginUserTool  sharedZZLoginUserTool] save:loginUser];
        [MBProgressHUD hideHUD];
        [MBProgressHUD  showSuccess:@"登录成功"];
       
        [ZZUMMessageTool  umMessageAddAlias];
        
        [self  swithWindowRootControllerToHome];
    } failure:^(NSString *error, ZZNetDataType dataType) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD  showError:error];
    }];
    
}


/**
 *  三方登录
 *
 *  @param sender <#sender description#>
 */

- (void)thirdLoginButtonAction:(UIButton *)btn{
    
    ZZUMLoginModel *loginModel = [ZZUMTool  sharedUMTool].loginModels[btn.tag];
  
   [ [ZZUMTool  sharedUMTool]umThirdLoginWithController:self andUmloginModel:loginModel andSuccBack:^(NSString *usid, NSString *nick ,ZZLoginType loginType) {
       
       [MBProgressHUD showSuccess:@"授权成功"];
       ZZLoginParam *param = [[ZZLoginParam  alloc]init];
       param.thirdType = @(loginType);
       param.openId = usid;
       param.userNike = nick;
        [MBProgressHUD  showMessage:@"登录中..."];
       
       [ZZLoadHttpTool loadLogin:param success:^(ZZLoginUser * loginUser, ZZNetDataType dataType) {
           
           [[ZZLoginUserTool  sharedZZLoginUserTool] save:loginUser];
            [MBProgressHUD hideHUD];
           [MBProgressHUD  showSuccess:@"登陆成功"];
           [ZZUMMessageTool  umMessageAddAlias];
           [self  swithWindowRootControllerToHome];
       } failure:^(NSString *error, ZZNetDataType dataType) {
           
            [MBProgressHUD hideHUD];
           [MBProgressHUD showError:error];
       }];
   } andFailBack:^(NSString *reason) {
       
        [MBProgressHUD showError:reason];
   
    }];
    
   
}

/**
 *  跳转忘记密码界面
 */
- (void)didClickOnTestSelect:(UIButton *)sender {
    ZZLog(@"忘记密码");
    ZZForgetVC *forgetVc = [[ZZForgetVC alloc]initWithNibName:@"ZZForgetVC" bundle:nil];
    [self.navigationController pushViewController:forgetVc animated:YES];
}




@end

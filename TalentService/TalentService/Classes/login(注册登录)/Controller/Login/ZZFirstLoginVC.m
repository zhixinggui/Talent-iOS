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
    NSArray*  array = [ZZUMTool  sharedUMTool].loginModels;
    CGFloat   benWidth = 90;
    CGFloat  left = (ScreenWidth - array.count*benWidth)/2+20;
    
    for (int  i = 0; i<array.count; i++) {
        ZZUMLoginModel *loginModel = array[i];
        UIButton* loginButton = [[UIButton alloc]initWithFrame:CGRectMake(i*benWidth+left, ButtonHeight, 60, 60)];
        loginButton.exclusiveTouch = YES;
        [loginButton setBackgroundImage:[UIImage imageNamed:loginModel.imageName] forState:UIControlStateNormal];
        [loginButton  addTarget:self action:@selector(thirdLoginButtonAction:) forControlEvents: UIControlEventTouchUpInside];
        loginButton.tag = i;
        
        [self.view addSubview:loginButton];
        
        
    }
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

  
    ZZLog(@",,%@,,,,,,",[ZZCityTool  sharedZZCityTool].provinceGroups);
//        NSData *jdata = [[NSData alloc]initWithContentsOfFile:[[NSBundle  mainBundle]pathForResource:@"address.json" ofType:nil]];
//    NSError *error;
//    id JsonObject=[NSJSONSerialization JSONObjectWithData:jdata
//                                                  options:NSJSONReadingAllowFragments
//                                                    error:&error] ; //nslog (@"%@",jsonobject);打印json字典
//    NSLog(@"%@",JsonObject);
    
//    NSDictionary *params = @{@"cmd":@"smart/register",@"parameters":@{@"loginAccount":@"15901718791"}};
//[ZZHttpTool  afPostByApiName:@"" Params:params success:^(id json) {
//    
//} failure:^(NSError *error) {
//    
//}];

}


/**
 *  三方登录
 *
 *  @param sender <#sender description#>
 */

- (void)thirdLoginButtonAction:(UIButton *)btn{
    
//   [ [ZZUMTool  sharedUMTool]umThirdLoginWithController:self andUmloginModel:[ZZUMTool  sharedUMTool].loginModels[btn.tag] andBack:^(id obj) {
//        
//    }];
    
   
    ZZThirdVC *thirdVc = [[ZZThirdVC alloc]initWithNibName:@"ZZThirdVC" bundle:nil];
    [self.navigationController pushViewController:thirdVc animated:YES];
}

/**
 *  跳转忘记密码界面
 */
- (void)didClickOnTestSelect:(id)sender {
    ZZLog(@"忘记密码");
    ZZForgetVC *forgetVc = [[ZZForgetVC alloc]initWithNibName:@"ZZForgetVC" bundle:nil];
    [self.navigationController pushViewController:forgetVc animated:YES];
}




@end

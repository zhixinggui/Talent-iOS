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
    [self setNavRightItemWithName:@"保存" target:self action:@selector(changePhoneAction:)];
    
    self.phoneTF.text = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.userPhone;
    
}


/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}


-(void)changePhoneAction:(UIButton*)button{
    //上传修改信息
    
    ZZChangeInfoParam *infoParam = [[ZZChangeInfoParam alloc]init];
    infoParam.userPhone = self.phoneTF.text;
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

//
//  ZZWriteDetailAddressVC.m
//  TalentService
//
//  Created by charles on 15/10/10.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZWriteDetailAddressVC.h"
#import "ZZLoginUserTool.h"
#import "ZZChangeInfoParam.h"
#import "ZZMyInfoHttpTool.h"

@interface ZZWriteDetailAddressVC ()
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTF;

@end

@implementation ZZWriteDetailAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细地址";
    
    [self setNavRightItemWithName:@"保存" target:self action:@selector(writeAddressAction:)];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.detailAddressTF setLeftView:whiteView];
    self.detailAddressTF.leftViewMode = UITextFieldViewModeAlways;
    self.detailAddressTF.text = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.userAddress;
}

/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

- (void)writeAddressAction:(UIButton *)button {
    
    //上传地址
    ZZChangeInfoParam *infoParam = [[ZZChangeInfoParam alloc]init];
    infoParam.userAddress = self.detailAddressTF.text;
    [MBProgressHUD showMessage:@"正在保存中..."];
    
    [ZZMyInfoHttpTool changeInfoWithChangeInfoParam:infoParam success:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showSuccess:@"保存成功" toView:self.view];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showError:error toView:self.view];
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

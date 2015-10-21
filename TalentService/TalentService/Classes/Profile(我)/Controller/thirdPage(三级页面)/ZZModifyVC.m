//
//  ZZModifyVC.m
//  TalentService
//
//  Created by charles on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZModifyVC.h"
#import "ZZLoginUserTool.h"
#import "ZZMyInfoHttpTool.h"
@interface ZZModifyVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@end

@implementation ZZModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"昵称";
    [self setNavRightItemWithName:@"保存" target:self action:@selector(exchageNameAction:)];
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.nameTF setLeftView:whiteView];
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    self.nameTF.text = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.userNike;
}

/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

-(void)exchageNameAction:(UIButton*)button{
    //上传修改信息
    
    ZZChangeInfoParam *infoParam = [[ZZChangeInfoParam alloc]init];
    infoParam.userNike = self.nameTF.text;
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

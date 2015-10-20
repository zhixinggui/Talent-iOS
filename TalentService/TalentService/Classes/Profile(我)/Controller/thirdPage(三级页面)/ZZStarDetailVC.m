//
//  ZZStarDetailVC.m
//  TalentService
//
//  Created by charles on 15/10/20.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZStarDetailVC.h"
#import "ZZTextView.h"
#import "ZZChangeInfoParam.h"
#import "ZZMyInfoHttpTool.h"
@interface ZZStarDetailVC ()
@property (weak, nonatomic) IBOutlet ZZTextView *detailTextView;

@end

@implementation ZZStarDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"达人描述";
    [self setNavRightItemWithName:@"保存" target:self action:@selector(writeDetailAction:)];
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.detailTextView.text = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.userPresentation;
    if (![ZZLoginUserTool sharedZZLoginUserTool].loginUser.userPresentation.length) {
        self.detailTextView.placeholder = @"达人描述,50~120字";
    }
    
}

- (void)writeDetailAction:(UIButton *)btn {
    ZZLog(@"保存");
    ZZChangeInfoParam *infoParam = [[ZZChangeInfoParam alloc]init];
    if (self.detailTextView.text.length) {
        infoParam.userPresentation = self.detailTextView.text;
    }else {
       infoParam.userPresentation = @"";
    }
    
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

/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
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

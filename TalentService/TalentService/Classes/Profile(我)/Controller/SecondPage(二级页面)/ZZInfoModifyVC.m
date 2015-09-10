//
//  ZZInfoModifyVC.m
//  TalentService
//
//  Created by charles on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZInfoModifyVC.h"
#import "UUPhotoActionSheet.h"
#import "ZZModifyVC.h"
@interface ZZInfoModifyVC ()<UUPhotoActionSheetDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
/** 选择图片*/
@property (nonatomic, strong) UUPhotoActionSheet *sheet;
@end

@implementation ZZInfoModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的";
}

#pragma mark - button的所有响应事件
- (IBAction)gotoModifyHeadIv:(UIButton *)sender {
    ZZLog(@"改头像");

    [self.sheet showAnimation];
}

- (IBAction)gotoModifyName:(UIButton *)sender {
    
    ZZLog(@"改名字");
    
    ZZModifyVC *modifyVc = [[ZZModifyVC alloc]initWithNib];
    [self.navigationController pushViewController:modifyVc animated:YES];
}

- (IBAction)gotoModifyPhoneNum:(UIButton *)sender {
    ZZLog(@"改手机号码");
}

- (IBAction)gotoModifyAddress:(UIButton *)sender {
    ZZLog(@"改地址");
    
}

- (IBAction)gotoModifySex:(UIButton *)sender {
    ZZLog(@"改性别");
}
#pragma mark -UUPhotoActionSheetDelegate
- (void)actionSheetDidFinished:(NSArray *)obj{
    ZZLog(@"11111%@",obj);
    self.headIV.image = obj[0];
}


#pragma mark - 布局相关统一代码规范

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    self.contentViewHeightConstraint.constant = 400;
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
#pragma mark -Setters and Getters
-(UUPhotoActionSheet *)sheet{
    if (_sheet == nil) {
        _sheet = [[UUPhotoActionSheet alloc] initWithWeakSuper:self];
        _sheet.delegate = self;
        _sheet.head = YES;
    }
    return _sheet;
}

@end

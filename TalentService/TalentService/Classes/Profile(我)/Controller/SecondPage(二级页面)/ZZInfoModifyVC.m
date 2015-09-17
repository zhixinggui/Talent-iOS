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

#import "ZZChangeInfoParam.h"
#import "ZZChangePhoneNumVC.h"
#import "ZZCitySelector.h"
#import "ZZCityTool.h"
#import "ZZSexSelector.h"
#import "ZZLoginUserTool.h"
#import "ZZMyInfoHttpTool.h"
@interface ZZInfoModifyVC ()<UUPhotoActionSheetDelegate,ZZCitySelectorDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
/** 选择图片*/
@property (nonatomic, strong) UUPhotoActionSheet *sheet;

@property (nonatomic, strong) ZZCity *selectedCity;
@property (nonatomic, strong) ZZProvince *selectedProvince;
@property (nonatomic, strong) ZZCounty *selectedCounty;
@end

@implementation ZZInfoModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的";
    /**
     *  个人信息
     */
    ZZLoginUserTool *loginUserTool = [ZZLoginUserTool sharedZZLoginUserTool];
    
    self.nameLabel.text = loginUserTool.loginUser.userNike;
    self.phoneLabel.text = loginUserTool.loginUser.userPhone;
    self.adressLabel.text = loginUserTool.loginUser.userAddress;
    if (loginUserTool.loginUser.userSex == 1) {
        self.sexLabel.text = @"男";
    }else if (loginUserTool.loginUser.userSex == 2){
        self.sexLabel.text = @"女";
    }else{
        self.sexLabel.text = @"男";
    }
    
    
    
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
    ZZChangePhoneNumVC *phoneNemVc = [[ZZChangePhoneNumVC alloc]initWithNib];
    [self.navigationController pushViewController:phoneNemVc animated:YES];
}

- (IBAction)gotoModifyAddress:(UIButton *)sender {
    ZZLog(@"改地址");
    ZZCitySelector *citySelector = [ZZCitySelector  citySelectorWithProvinceArray:[ZZCityTool  sharedZZCityTool].provinceGroups delegate:self];
    [citySelector  setSelectedProvince:self.selectedProvince city:self.selectedCity county:self.selectedCounty];
    [citySelector showAnimation];
}

#pragma mark -ZZCitySelectorDelegate

-(void)citySelectorSelect:(ZZCitySelector *)citySelector selectedProvince:(ZZProvince *)selectedProvince selectedCity:(ZZCity *)selectedCity selectedCounty:(ZZCounty *)selectedCounty{
    
    self.selectedProvince = selectedProvince;
    self.selectedCounty = selectedCounty;
    self.selectedCity = selectedCity;
    self.adressLabel.text = [NSString  stringWithFormat:@"%@%@%@",selectedProvince.name,selectedCity.name,selectedCounty.name];
}


- (IBAction)gotoModifySex:(UIButton *)sender {
    ZZLog(@"改性别");
    
}
#pragma mark -UUPhotoActionSheetDelegate
- (void)actionSheetDidFinished:(NSArray *)obj{
    ZZLog(@"11111%@",obj);
    self.headIV.image = obj[0];
    //上传修改信息
    ZZChangeInfoParam *infoParam = [[ZZChangeInfoParam alloc]init];
    
    [ZZMyInfoHttpTool changeInfoWithChangeInfoParam:infoParam success:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
        
    } failure:^(NSString *error, ZZNetDataType datatype) {
        
    }];
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

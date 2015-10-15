//
//  ZZNextRegistVC.m
//  TalentService
//
//  Created by charles on 15/8/19.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZNextRegistVC.h"
#import "ZZTextField.h"
#import "ZZLayerButton.h"
#import "ZZCityTool.h"
#import "ZZCitySelector.h"

#import "ZZLoadHttpTool.h"
#import "ZZLoginUserTool.h"
@interface ZZNextRegistVC ()<UITextFieldDelegate,ZZCitySelectorDelegate>
@property (strong, nonatomic) IBOutlet ZZTextField *nameTF;
@property (strong, nonatomic) IBOutlet ZZTextField *cityTF;
@property (strong, nonatomic) IBOutlet ZZTextField *secrectTF;
@property (strong, nonatomic) IBOutlet ZZTextField *againSecrectTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *finishButton;
@property (nonatomic, strong) ZZCity *selectedCity;
@property (nonatomic, strong) ZZProvince *selectedProvince;
@property (nonatomic, strong) ZZCounty *selectedCounty;
@end

@implementation ZZNextRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
  
    //调整xib中的控件属性
    [self  setUppropertys];
}

- (void)setUppropertys{
    [self.nameTF addLeftViewImageString:@"user_30x30"];
    [self.cityTF addLeftViewImageString:@"city_30x30"];
    [self.secrectTF addLeftViewImageString:@"key_30x30"];
    [self.againSecrectTF addLeftViewImageString:@"key_30x30"];
    
    /**
     *  设置button颜色
     */
    self.finishButton.backgroundColor = LoginButtonColor;
}
- (IBAction)sureButtonAction:(UIButton *)sender {
     [self.view  endEditing:YES];
    if ([self.nameTF.text  unicodeLength] <= 0|| [self.nameTF.text  unicodeLength] > ZZNickMaxLenth) {
        [self.nameTF  shakeAnimation];
        return;
    }
    if (self.cityTF.text.length <= 0) {
        [self.cityTF  shakeAnimation];
        return;
    }
    if ([self.secrectTF.text  isPassWordWithMin:ZZMiMaMinLenth max:ZZMiMaMaxLenth] == NO) {
        [self.secrectTF  shakeAnimation];
        return;
    }
    
    if ([self.againSecrectTF.text isPassWordWithMin:ZZMiMaMinLenth max:ZZMiMaMaxLenth] == NO || [self.againSecrectTF.text  isEqualToString:self.secrectTF.text]==NO) {
        [self.againSecrectTF shakeAnimation];
        return;
    }
    ZZResignParam *param = [[ZZResignParam  alloc]init];
    param.loginPassword = self.secrectTF.text;
    param.city = @(self.selectedCity.cityId);
    param.province = @(self.selectedProvince.provinceId);
    param.district = @(self.selectedCounty.countyId);
    param.userNike = self.nameTF.text;
    param.thirdType = @(0);
    param.loginAccount = self.phone;
    [MBProgressHUD  showMessage:@"注册中..."];
    [ZZLoadHttpTool  loadResign:param success:^(ZZLoginUser * loginUser , ZZNetDataType dataType) {
        
        [[ZZLoginUserTool  sharedZZLoginUserTool] save:loginUser];
        [MBProgressHUD  hideHUD];
          [MBProgressHUD  showSuccess:@"注册成功"];
          [self swithWindowRootControllerToHome];
    } failure:^(NSString *error, ZZNetDataType dataType) {
        
        [MBProgressHUD  hideHUD];
         [MBProgressHUD  showError:error];
    }];
    
 
}

#pragma mark -UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.cityTF) {
        ZZCitySelector *citySelector = [ZZCitySelector  citySelectorWithProvinceArray:[ZZCityTool  sharedZZCityTool].provinceGroups delegate:self];
        [citySelector  setSelectedProvince:self.selectedProvince city:self.selectedCity county:self.selectedCounty];
        [citySelector showAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [textField resignFirstResponder];
        });
        
    }
}
#pragma mark -ZZCitySelectorDelegate

-(void)citySelectorSelect:(ZZCitySelector *)citySelector selectedProvince:(ZZProvince *)selectedProvince selectedCity:(ZZCity *)selectedCity selectedCounty:(ZZCounty *)selectedCounty{
    self.selectedProvince = selectedProvince;
    self.selectedCounty = selectedCounty;
    self.selectedCity = selectedCity;
    self.cityTF.text = [NSString  stringWithFormat:@"%@ %@ %@",selectedProvince.name,selectedCity.name,selectedCounty.name];
}
@end

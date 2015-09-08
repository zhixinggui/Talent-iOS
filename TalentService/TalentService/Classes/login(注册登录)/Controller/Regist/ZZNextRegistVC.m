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
@interface ZZNextRegistVC ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet ZZTextField *nameTF;
@property (strong, nonatomic) IBOutlet ZZTextField *cityTF;
@property (strong, nonatomic) IBOutlet ZZTextField *secrectTF;
@property (strong, nonatomic) IBOutlet ZZTextField *againSecrectTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *finishButton;

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
    [self.navigationController  popToRootViewControllerAnimated:YES];
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.cityTF) {
        [[ZZCitySelector  citySelectorWithProvinceArray:[ZZCityTool  sharedZZCityTool].provinceGroups delegate:self] showAnimation];
        return NO;
    }else{
        return YES;
    }
}
@end

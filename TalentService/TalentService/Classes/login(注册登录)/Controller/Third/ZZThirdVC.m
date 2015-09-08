//
//  ZZThirdVC.m
//  TalentService
//
//  Created by charles on 15/8/21.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZThirdVC.h"
#import "ZZTextField.h"
#import "ZZSecurityButton.h"
#import "ZZLayerButton.h"
@interface ZZThirdVC ()
@property (strong, nonatomic) IBOutlet UIImageView *headIV;
@property (strong, nonatomic) IBOutlet ZZTextField *phoneTF;
@property (strong, nonatomic) IBOutlet ZZTextField *messageTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *finishButton;
@property (weak, nonatomic) IBOutlet UILabel *thirdNIckLabel;
@property (weak, nonatomic) IBOutlet ZZSecurityButton *securityButton;

@end

@implementation ZZThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"三方绑定";
    //调整xib中的控件属性
    [self  setUppropertys];
}


- (void)setUppropertys{
    self.headIV.layer.cornerRadius = 40;
    self.headIV.layer.masksToBounds = YES;
    [self.phoneTF addLeftViewImageString:@"phone_30x30"];
    [self.messageTF addLeftViewImageString:@"message_30x30"];
    self.thirdNIckLabel.textColor = ZZLightGrayColor;
    /**
     *  设置button颜色
     */
    self.finishButton.backgroundColor = LoginButtonColor;
   [ self.securityButton  setCornerRadius:10 borderColor:ZZNatiBarColor];
    [self.securityButton  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
}
- (IBAction)securityButtonAction:(ZZSecurityButton *)sender {
    [sender  startWithSecond:ZZSecerityTime];
}

- (IBAction)sureButtonAction:(UIButton *)sender {
    [self.navigationController  popToRootViewControllerAnimated:YES];
}

- (void)dealloc{
    [self.securityButton clearButton];
    ZZLog( @",,,%@",[self  class]);
}
@end

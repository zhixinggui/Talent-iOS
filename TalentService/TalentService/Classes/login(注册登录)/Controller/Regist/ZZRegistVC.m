//
//  ZZRegistVC.m
//  TalentService
//
//  Created by charles on 15/8/19.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZRegistVC.h"
#import "ZZTextField.h"
#import "ZZNextRegistVC.h"
#import "ZZLayerButton.h"
#import "ZZSecurityButton.h"
@interface ZZRegistVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *phoneTF;
@property (strong, nonatomic) IBOutlet ZZTextField *messageTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *nextButton;
@property (weak, nonatomic) IBOutlet ZZSecurityButton *securityButton;

@end

@implementation ZZRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"注册"];
    //调整xib中的控件属性
    [self  setUppropertys];
  
}
- (void)setUppropertys{
    [self.phoneTF addLeftViewImageString:@"phone_30x30"];
    [self.messageTF addLeftViewImageString:@"key_30x30"];
    
    /**
     *  设置button颜色
     */
    self.nextButton.backgroundColor = LoginButtonColor;
    [ self.securityButton  setCornerRadius:10 borderColor:ZZNatiBarColor];
    [self.securityButton  setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
}
- (IBAction)gotoNextRegist:(UIButton *)sender {
    ZZNextRegistVC *nextRegistVc = [[ZZNextRegistVC alloc]initWithNibName:@"ZZNextRegistVC" bundle:nil];
    [self.navigationController pushViewController:nextRegistVc animated:YES];
}
- (IBAction)securityButtonAction:(ZZSecurityButton *)sender {
     [sender  startWithSecond:ZZSecerityTime];
    
}


-(void)dealloc{
    [self.securityButton clearButton];
}

@end

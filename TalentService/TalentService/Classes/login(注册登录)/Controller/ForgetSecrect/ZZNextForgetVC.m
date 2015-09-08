//
//  ZZNextForgetVC.m
//  TalentService
//
//  Created by charles on 15/8/20.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZNextForgetVC.h"
#import "ZZTextField.h"
#import "ZZLayerButton.h"
@interface ZZNextForgetVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *PassWordTF;
@property (strong, nonatomic) IBOutlet ZZTextField *againSecrectTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *finishButton;

@end

@implementation ZZNextForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    //调整xib中的控件属性
    [self  setUppropertys];
   
}
- (void)setUppropertys{
    [self.PassWordTF addLeftViewImageString:@"key_30x30"];
    [self.againSecrectTF addLeftViewImageString:@"key_30x30"];
    /**
     *  设置button颜色
     */
    self.finishButton.backgroundColor = LoginButtonColor;
}


@end

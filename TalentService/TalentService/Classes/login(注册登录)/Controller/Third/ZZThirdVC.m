//
//  ZZThirdVC.m
//  TalentService
//
//  Created by charles on 15/8/21.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZThirdVC.h"
#import "ZZTextField.h"
#import "ZZLayerButton.h"
@interface ZZThirdVC ()
@property (strong, nonatomic) IBOutlet UIImageView *headIV;
@property (strong, nonatomic) IBOutlet ZZTextField *phoneTF;
@property (strong, nonatomic) IBOutlet ZZTextField *messageTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *finishButton;

@end

@implementation ZZThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.headIV.layer.cornerRadius = 40;
    self.headIV.layer.masksToBounds = YES;
    [self.phoneTF addLeftViewImageString:@"T2"];
    [self.messageTF addLeftViewImageString:@"T2"];
    
    /**
     *  设置button颜色
     */
    self.finishButton.backgroundColor = LoginButtonColor;
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

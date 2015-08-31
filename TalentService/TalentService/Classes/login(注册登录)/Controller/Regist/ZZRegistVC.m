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
@interface ZZRegistVC ()
@property (strong, nonatomic) IBOutlet ZZTextField *phoneTF;
@property (strong, nonatomic) IBOutlet ZZTextField *messageTF;
@property (strong, nonatomic) IBOutlet ZZLayerButton *nextButton;

@end

@implementation ZZRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"注册"];
    [self.phoneTF addLeftViewImageString:@"T2"];
    [self.messageTF addLeftViewImageString:@"T2"];
    
    /**
     *  设置button颜色
     */
    self.nextButton.backgroundColor = LoginButtonColor;
}
- (IBAction)gotoNextRegist:(UIButton *)sender {
    ZZNextRegistVC *nextRegistVc = [[ZZNextRegistVC alloc]initWithNibName:@"ZZNextRegistVC" bundle:nil];
    [self.navigationController pushViewController:nextRegistVc animated:YES];
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

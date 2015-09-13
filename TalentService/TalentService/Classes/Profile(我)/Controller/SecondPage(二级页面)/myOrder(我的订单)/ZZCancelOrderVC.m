//
//  ZZCancelOrderVC.m
//  TalentService
//
//  Created by charles on 15/9/11.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZCancelOrderVC.h"

@interface ZZCancelOrderVC ()
@property (weak, nonatomic) IBOutlet UIButton *reasonBT1;
@property (weak, nonatomic) IBOutlet UIButton *reasonBT2;
@property (weak, nonatomic) IBOutlet UIButton *reasonBT3;
@property (weak, nonatomic) IBOutlet UIButton *otherReasonBT;
@property (nonatomic ,strong)UIButton *selectedButton;
@end

@implementation ZZCancelOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"取消订单";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)exchangeBT:(UIButton *)sender {
    self.selectedButton.selected = NO;
    sender.selected = YES;
    ZZLog(@"%ld",sender.tag);
    self.selectedButton = sender;
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

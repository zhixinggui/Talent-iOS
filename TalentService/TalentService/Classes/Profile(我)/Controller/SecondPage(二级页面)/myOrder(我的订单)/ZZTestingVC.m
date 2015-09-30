//
//  ZZTestingVC.m
//  TalentService
//
//  Created by charles on 15/9/14.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZTestingVC.h"
#import "ZZMyInfoHttpTool.h"

#import "ZZHudView.h"

#import "ZZTestOrderParam.h"
@interface ZZTestingVC ()
@property (weak, nonatomic) IBOutlet UITextField *orderNumTF;

@end

@implementation ZZTestingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证";
}

- (IBAction)didClickOnTestOrder:(UIButton *)sender {
    ZZTestOrderParam *testOrderParam = [[ZZTestOrderParam alloc]init];
    testOrderParam.ordercode = self.orderNumTF.text;
    testOrderParam.serviceId = @(self.serviceId);
    [ZZMyInfoHttpTool testOrderWithTestOrderParam:testOrderParam success:^(id json, ZZNetDataType dataType) {
        [ZZHudView  showMessage:@"订单验证成功！" time:3 toView:self.view];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [ZZHudView  showMessage:@"订单已经验证！" time:3 toView:self.view];
    }];
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

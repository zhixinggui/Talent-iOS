//
//  ZZMyJoinOrderVC.m
//  TalentService
//
//  Created by charles on 15/9/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZMyJoinOrderVC.h"
#import "ZZSlideDemo.h"
#import "ZZJoinOrderTVC.h"
#import "ZZTestingVC.h"
@interface ZZMyJoinOrderVC ()

@end

@implementation ZZMyJoinOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的接单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZZSlideDemo *selidemo = [[ZZSlideDemo alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    NSMutableArray *array = [NSMutableArray  array];
    for (int i = 0; i<2; i++) {
        ZZJoinOrderTVC *Tvc = [[ZZJoinOrderTVC alloc]initWithNib];
        Tvc.myJoinOrderVcDelegate = self;
        switch (i) {
            case 0:
                Tvc.title = @"已验证";
                Tvc.orderType = ZZOrderTypeDidTest;
                Tvc.serviceId = self.serviceId;
                break;
                
            case 1:
                Tvc.title = @"未验证";
                Tvc.orderType = ZZOrderTypeNoTest;
                Tvc.serviceId = self.serviceId;
                break;
        }
        [array addObject:Tvc];
    }
    selidemo.conViews = array;
    [self.view addSubview:selidemo];
    
    [self setNavRightItemWithName:@"验证" target:self action:@selector(testingAction:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}


/**
 *  跳转验证
 */
- (void)testingAction:(UIButton *)sender {
    ZZLog(@"验证");
    ZZTestingVC *testingVc = [[ZZTestingVC alloc]initWithNib];
    testingVc.serviceId = self.serviceId;
    [self.navigationController pushViewController:testingVc animated:YES];
}

@end

//
//  ZZOrderResult.m
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZOrderResultVC.h"
#import "ZZSeeOrderVC.h"
@interface ZZOrderResultVC ()

@end

@implementation ZZOrderResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付结果";
    [self  setUpChilds];
}

- (void)setUpChilds{
    UIImageView *resultIV = [[UIImageView  alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, 200)];
    resultIV.backgroundColor = [UIColor  orangeColor];
    resultIV.contentMode = UIViewContentModeCenter;
    [self.view  addSubview:resultIV];
    
    if (1) {
        CGFloat btnw = 200;
        CGFloat btnh = 40;
        CGFloat btnx = (ScreenWidth - btnw)/2;
         CGFloat btny = CGRectGetMaxY(resultIV.frame)+30;
        
        UIButton *reasonBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnx, btny, btnw, btnh)];
        reasonBtn.backgroundColor = ZZNatiBarColor;
        [reasonBtn setTitle:@"查看原因" forState:UIControlStateNormal];
        [reasonBtn  addTarget:self action:@selector(reasonBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view  addSubview:reasonBtn];
    }
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"查看" style:UIBarButtonItemStyleDone target:self action:@selector(seeOrder)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}


- (void)reasonBtnAction{
    ZZLog(@"没钱所以失败了");
}

- (void)seeOrder{
    pushVC(ZZSeeOrderVC);
//    ZZSeeOrderVC *seeOrderVC= [[ZZSeeOrderVC alloc]init];
//    [self.navigationController  pushViewController:seeOrderVC animated:YES];
}
@end

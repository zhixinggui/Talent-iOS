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
    self.title = @"订单状态";
    self.view.backgroundColor = ZZViewBackColor;
    [self  setUpChilds];
}

- (void)setUpChilds{
    NSString *imageName ;
    if (self.result) {
        imageName = @"order_succ";
    }else{
        imageName = @"order_fail";
    }
  
    UIImage *image = [UIImage  imageNamed:imageName];
    CGFloat  wid = image.size.width/2;
    CGFloat  height = image.size.height /2;
    CGFloat  x = (ScreenWidth -wid)/2;
    UIImageView *resultIV = [[UIImageView  alloc]initWithFrame:CGRectMake(x, 74, wid, height)];
    resultIV.image = image;
    resultIV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view  addSubview:resultIV];
    
//    if (self.result == NO) {
//        CGFloat btnw = 200;
//        CGFloat btnh = 40;
//        CGFloat btnx = (ScreenWidth - btnw)/2;
//         CGFloat btny = CGRectGetMaxY(resultIV.frame)+30;
//        
//        UIButton *reasonBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnx, btny, btnw, btnh)];
//        reasonBtn.backgroundColor = ZZNatiBarColor;
//        [reasonBtn setTitle:@"查看原因" forState:UIControlStateNormal];
//        [reasonBtn  addTarget:self action:@selector(reasonBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.view  addSubview:reasonBtn];
//    }
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"查看" style:UIBarButtonItemStyleDone target:self action:@selector(seeOrder)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}


- (void)reasonBtnAction{
    ZZLog(@"没钱所以失败了");
}

- (void)seeOrder{
//    pushVC(ZZSeeOrderVC);
    ZZSeeOrderVC *seeOrderVC= [[ZZSeeOrderVC alloc]init];
    seeOrderVC.orderCode = self.orderCode;
    [self.navigationController  pushViewController:seeOrderVC animated:YES];
}
@end

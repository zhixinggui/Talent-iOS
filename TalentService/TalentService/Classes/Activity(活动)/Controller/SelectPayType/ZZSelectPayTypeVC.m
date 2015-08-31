//
//  ZZSelectPayTypeVC.m
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSelectPayTypeVC.h"
#import "ZZPayTypeShowView.h"
#import "ZZPayType.h"
#import "ZZOrderResultVC.h"
@interface ZZSelectPayTypeVC ()
@property (nonatomic)CGFloat  currentChildHeight ;

@property (nonatomic, strong)ZZPayTypeShowView *selectShowView;
@end

@implementation ZZSelectPayTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择支付方式";
    self.view.backgroundColor = ZZViewBackColor;
    [self  setUpNaviRightItem];
    [self  setUpPayTypes];
    // Do any additional setup after loading the view.
}

- (void)setUpNaviRightItem{
    UIBarButtonItem *barItem = [[UIBarButtonItem  alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sureAction)];
    
    self.navigationItem.rightBarButtonItem = barItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setUpPayTypes{
    self.currentChildHeight = 64+30;
    [self getPayTypeShowViewWithPayType:nil];
}

- (ZZPayTypeShowView *)getPayTypeShowViewWithPayType:(ZZPayType *)payType{
    ZZPayTypeShowView *showView = [[[NSBundle  mainBundle]loadNibNamed:@"ZZPayTypeShowView" owner:self options:nil]lastObject];
    showView.payType = payType;
    showView.y= self.currentChildHeight;
    showView.height = 50;
    [showView  addTarget:self action:@selector(selectPayType:)];
    self.currentChildHeight+=showView.height;
    
    [self.view addSubview:showView];
    
    return showView;
}

#pragma mark -event response
- (void)selectPayType:(ZZPayTypeShowView *)showView{
    
    self.selectShowView.selected = NO;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    showView.selected = YES;
    self.selectShowView = showView;
}
- (void)sureAction{
    ZZLog(@"确定");
    ZZOrderResultVC *orderResult = [[ZZOrderResultVC alloc]init];
    [self.navigationController  pushViewController:orderResult animated:YES];
}
@end

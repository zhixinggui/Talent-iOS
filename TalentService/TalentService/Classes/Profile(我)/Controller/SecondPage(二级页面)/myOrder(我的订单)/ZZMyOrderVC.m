//
//  ZZMyOrderVC.m
//  TalentService
//
//  Created by charles on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMyOrderVC.h"
#import "ZZSegmentedControl.h"
#import "ZZMyOrderTVC.h"
#import "ZZJoinOrderTVC.h"
@interface ZZMyOrderVC ()<ZZSegmentedControlDelegate>
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property(nonatomic,strong)ZZSegmentedControl *orderSegmentControl;
/**
 *  订单页面
 */
@property(nonatomic,strong)ZZMyOrderTVC *myorderTvc;
/**
 *  接单页面
 */
@property(nonatomic,strong)ZZJoinOrderTVC *joinorderTvc;
@end

@implementation ZZMyOrderVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    /**
     *  加载segment视图
     */
    [self.segmentView addSubview:self.orderSegmentControl];
    /**
     *  两个页面加载到主页面里
     */
    [self addChildViewController:self.myorderTvc];
    [self addChildViewController:self.joinorderTvc];
    [self.contentView addSubview:self.myorderTvc.view];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark  event delegate
-(void)segmentControl:(ZZSegmentedControl *)segment andIndex:(NSUInteger)index{
    ZZLog(@"切换%ld",index);
    switch (index) {
        case 0:
        {
            [self.contentView removeAllSubviews];
            self.myorderTvc.view.frame = self.contentView.bounds;
            [self.contentView addSubview:self.myorderTvc.view];
            
        }
            break;
            
        case 1:
        {
            
            [self.contentView removeAllSubviews];
            self.joinorderTvc.view.frame = self.contentView.bounds;
            [self.contentView addSubview:self.joinorderTvc.view];
            
        }
            break;
    }
    
}

#pragma mark setter andGetter
-(ZZSegmentedControl *)orderSegmentControl{
    if (!_orderSegmentControl) {
        _orderSegmentControl = [[ZZSegmentedControl alloc]initWithItems:@[@"订单",@"接单"]];
        _orderSegmentControl.delegate = self;
        _orderSegmentControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
    }
    return _orderSegmentControl;
}

-(ZZMyOrderTVC *)myorderTvc{
    if (!_myorderTvc) {
        _myorderTvc = [[ZZMyOrderTVC alloc]init];
        _myorderTvc.view.frame = self.contentView.bounds;
    }
    return _myorderTvc;
}

-(ZZJoinOrderTVC *)joinorderTvc{
    if (!_joinorderTvc) {
        _joinorderTvc = [[ZZJoinOrderTVC alloc]init];
        _joinorderTvc.view.frame = self.contentView.bounds;
    }
    return _joinorderTvc;
}

@end

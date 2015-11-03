//
//  ZZMyCollectVC.m
//  TalentService
//
//  Created by charles on 15/9/14.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMyCollectVC.h"
#import "ZZSegmentedControl.h"
#import "ZZCollectActivityTVC.h"
#import "ZZCollectCommunityTVC.h"
#import "ZZHudView.h"

@interface ZZMyCollectVC ()<ZZSegmentedControlDelegate>
/**
 *  收藏服务页面
 */
@property(nonatomic,strong)ZZCollectActivityTVC *collectActivityTvc;
/**
 *  收藏社区页面
 */
@property(nonatomic,strong)ZZCollectCommunityTVC *collectCommunityTvc;
@property(nonatomic,strong)ZZSegmentedControl *collectSegmentControl;
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ZZMyCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    /**
     *  加载segment视图
     */
    [self.segmentView addSubview:self.collectSegmentControl];
    /**
     *  两个页面加载到主页面里
     */
    [self addChildViewController:self.collectActivityTvc];
    [self addChildViewController:self.collectCommunityTvc];
    [self.contentView addSubview:self.collectActivityTvc.view];
}

#pragma mark  event delegate
-(void)segmentControl:(ZZSegmentedControl *)segment andIndex:(NSUInteger)index{
    ZZLog(@"切换%ld",index);
    switch (index) {
        case 0:
        {
            [self.contentView removeAllSubviews];
            self.collectActivityTvc.view.frame = self.contentView.bounds;
            [self.contentView addSubview:self.collectActivityTvc.view];
            
        }
            break;
            
        case 1:
        {
            //[ZZHudView showMessage:@"敬请等待..." time:1 toView:self.view];
            [self.contentView removeAllSubviews];
            self.collectCommunityTvc.view.frame = self.contentView.bounds;
            [self.contentView addSubview:self.collectCommunityTvc.view];
            
        }
            break;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark setter andGetter
-(ZZSegmentedControl *)collectSegmentControl{
    if (!_collectSegmentControl) {
        _collectSegmentControl = [[ZZSegmentedControl alloc]initWithItems:@[@"服务",@"社区"]];
        _collectSegmentControl.delegate = self;
        _collectSegmentControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
    }
    return _collectSegmentControl;
}

-(ZZCollectActivityTVC *)collectActivityTvc{
    if (!_collectActivityTvc) {
        _collectActivityTvc = [[ZZCollectActivityTVC alloc]init];
        _collectActivityTvc.view.frame = self.contentView.bounds;
    }
    return _collectActivityTvc;
}

-(ZZCollectCommunityTVC *)collectCommunityTvc{
    if (!_collectCommunityTvc) {
        _collectCommunityTvc = [[ZZCollectCommunityTVC alloc]init];
        _collectCommunityTvc.view.frame = self.contentView.bounds;
    }
    return _collectCommunityTvc;
}

@end

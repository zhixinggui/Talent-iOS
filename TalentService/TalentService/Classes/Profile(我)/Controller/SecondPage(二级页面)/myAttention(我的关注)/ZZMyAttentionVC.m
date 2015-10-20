//
//  ZZMyAttentionVC.m
//  TalentService
//
//  Created by charles on 15/10/19.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZMyAttentionVC.h"
#import "ZZAttentionVC.h"
#import "ZZSegmentedControl.h"
@interface ZZMyAttentionVC ()<ZZSegmentedControlDelegate>
@property (nonatomic, strong)ZZAttentionVC *myFriendVc;
@property (nonatomic, strong)ZZAttentionVC *mySuperStarVc;
@property(nonatomic,strong)ZZSegmentedControl *collectSegmentControl;
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ZZMyAttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    /**
     *  加载segment视图
     */
    [self.segmentView addSubview:self.collectSegmentControl];
    [self addChildViewController:self.myFriendVc];
    [self addChildViewController:self.mySuperStarVc];
    [self.contentView addSubview:self.myFriendVc.view];
}

#pragma mark  event delegate
-(void)segmentControl:(ZZSegmentedControl *)segment andIndex:(NSUInteger)index{
    ZZLog(@"切换%ld",index);
    switch (index) {
        case 0:
        {
            [self.contentView removeAllSubviews];
            self.myFriendVc.view.frame = self.contentView.bounds;

            [self.contentView addSubview:self.myFriendVc.view];
        }
            break;
            
        case 1:
        {
            [self.contentView removeAllSubviews];
            self.mySuperStarVc.view.frame = self.contentView.bounds;
     
            [self.contentView addSubview:self.mySuperStarVc.view];
        }
            break;
    }
    
}

#pragma mark setter andGetter
-(ZZSegmentedControl *)collectSegmentControl{
    if (!_collectSegmentControl) {
        _collectSegmentControl = [[ZZSegmentedControl alloc]initWithItems:@[@"朋友",@"达人"]];
        _collectSegmentControl.delegate = self;
        _collectSegmentControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
    }
    return _collectSegmentControl;
}

- (ZZAttentionVC *)myFriendVc {
    if (!_myFriendVc) {
        _myFriendVc = [[ZZAttentionVC alloc]init];
        _myFriendVc.segmentIndex = 0;
       // _myFriendVc.view.frame = self.contentView.bounds;
    }
    return _myFriendVc;
}

- (ZZAttentionVC *)mySuperStarVc {
    if (!_mySuperStarVc) {
        _mySuperStarVc = [[ZZAttentionVC alloc]init];
        _mySuperStarVc.segmentIndex = 1;
        //_mySuperStarVc.view.frame = self.contentView.bounds;
    }
    return _mySuperStarVc;
}

@end

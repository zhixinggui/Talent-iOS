//
//  ZZTopicSearchVC.m
//  TalentService
//
//  Created by zhizhen on 15/11/10.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicSearchVC.h"
#import "UIBarButtonItem+Extension.h"
@interface ZZTopicSearchVC ()

@end

@implementation ZZTopicSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.hidesBackButton = YES;
      [self  titleView];
   
}

- (void)titleView{
//    UIButton *cancellButton = [[UIButton  alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [cancellButton  addTarget:self action:@selector(cancell) forControlEvents:UIControlEventTouchUpInside];
//    cancellButton.title = @"取消";
//    UIBarButtonItem *cancellItem = [[UIBarButtonItem alloc]initWithCustomView:cancellButton];
//
//    self.navigationItem.rightBarButtonItems = @[cancellItem,[UIBarButtonItem  seperatorItem]];
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth- 20, 34)];
    backView.backgroundColor = [UIColor  whiteColor];
    self.navigationItem.titleView = backView;
    
    
//    UIButton *selectBuuton = [[UIButton  alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    selectBuuton.title = @"话题";
//    UIBarButtonItem *selectItem = [[UIBarButtonItem alloc]initWithCustomView:selectBuuton];
//   // self.navigationItem.leftBarButtonItem = selectItem;
//   self.navigationItem.leftBarButtonItems = @[[UIBarButtonItem  seperatorItem],selectItem];
}

- (void)cancell{
    [self.navigationController  popViewControllerAnimated:YES];
}
@end

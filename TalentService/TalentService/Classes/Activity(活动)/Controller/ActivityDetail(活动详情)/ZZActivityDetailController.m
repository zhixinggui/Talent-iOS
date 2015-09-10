//
//  ZZActivityDetailController.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityDetailController.h"
#import "ZZDetailImageView.h"
#import "ZZDetailRuleView.h"
#import "ZZDetailsView.h"
#import "ZZActivityBottomToolBar.h"
#import "ZZEnsureOrderController.h"
#import "ZZDetailFunctionView.h"
#import "ZZUMTool.h"
#import "ZZIQKeyBoardTool.h"
#import "ZZFuncitonModel.h"
@interface ZZActivityDetailController ()<ZZDetailImageViewDelegate,ZZDetailFunctionViewDelegate>
//当前功能按钮
@property (nonatomic, strong)NSArray *functions;

@property (nonatomic, strong)ZZFuncitonModel *starModel;

@property (nonatomic, strong)ZZDetailFunctionView *detailFV;
@end

@implementation ZZActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    self.view.backgroundColor = ZZViewBackColor;
    [self  setRightItem];
    [self  setUpChild];
    //关闭键盘向上
    ZZKeyBoardTool(close);
}
//more_close_30x30
- (void)setRightItem{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem  alloc]initWithImage:[UIImage  imageNamed:@"more_close_30x30"]   style:UIBarButtonItemStyleDone target:self action:@selector(moreFunction)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)setUpChild{
    CGFloat toolHeight = 49;
    CGFloat scrollWidth = self.view.bounds.size.width;
    CGFloat scrollHeight = self.view.bounds.size.height - toolHeight;
    UIScrollView *scrollView = [[UIScrollView  alloc]initWithFrame:CGRectMake(0, 0, scrollWidth, scrollHeight)];
    [self.view  addSubview:scrollView];
    //广告位滚动图片
    ZZDetailImageView *detailIV = [[ZZDetailImageView  alloc]init];
    detailIV.delegate = self;
    detailIV.frame = CGRectMake(0, 0, ScreenWidth, detailIV.totalHeight);
    [scrollView addSubview:detailIV];
    //细则
    ZZDetailRuleView *detailRuleV = [[ZZDetailRuleView  alloc]init];
    detailRuleV.frame = CGRectMake(0, CGRectGetMaxY(detailIV.frame), ScreenWidth, detailRuleV.totalHeight);
    [scrollView addSubview:detailRuleV];
    //详情
    ZZDetailsView *detailView = [[ZZDetailsView  alloc]init];
    detailView.frame = CGRectMake(0, CGRectGetMaxY(detailRuleV.frame), ScreenWidth, detailView.totalHeight);
    [scrollView addSubview:detailView];
    
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(detailView.frame));
    //工具栏
    ZZActivityBottomToolBar *actiBottomTool = [[ZZActivityBottomToolBar  alloc]initWithFrame:CGRectMake(0, scrollHeight, scrollWidth, toolHeight)];
    [self.view  addSubview:actiBottomTool];
}
-(void)viewWillAppear:(BOOL)animated{
    [super  viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}
#pragma mark -响应事件
- (void)moreFunction{
  
    [self.detailFV showAnimation];
  
}

#pragma mark -ZZDetailImageViewDelegate
- (void)detailImageViewBooking:(ZZDetailImageView *)detalImageViewDelegate{
    
    ZZEnsureOrderController *ensureOC = [[ZZEnsureOrderController  alloc]init];
    [self.navigationController  pushViewController:ensureOC animated:YES];
}

- (void)detailImageViewADCliceked:(ZZDetailImageView *)detalImageViewDelegate{
    
}

#pragma mark - ZZDetailFunctionViewDelegate
-(void)detailFunctionView:(ZZDetailFunctionView *)detaileFunctionView shares:(NSArray *)shares selectedAtIndex:(NSUInteger)index{
#warning 待完善
    [[ZZUMTool  sharedUMTool]umShareWithTitle:@"ddd" content:@"ddd" url:nil imageUrl:nil locialImageName:nil controller:self loginModel:shares[index]];
}
-(void)detailFunctionView:(ZZDetailFunctionView *)detaileFunctionView functions:(NSArray *)functions selectedAtIndex:(NSUInteger)index{
    ZZFuncitonModel *model = functions[index];
    switch (model.modelType) {
        case ZZFuncitonModelTypeReport:
            
            break;
        case ZZFuncitonModelTypeStar:
            
            break;
        case ZZFuncitonModelTypeBackHome:
            [self.navigationController  popToRootViewControllerAnimated:YES];
            break;
        
    }
    
}
-(void)dealloc{
    ZZLog(@"%@",[self  class]);
    //打开键盘向上
     ZZKeyBoardTool(open);
}

#pragma mark - lazy load
-(NSArray *)functions{
    if (_functions == nil) {
        NSMutableArray *array = [NSMutableArray  arrayWithCapacity:3];
        
        ZZFuncitonModel *report = [[ZZFuncitonModel  alloc]initWithImageName:@"report_60x60" name:@"举报" modelType:ZZFuncitonModelTypeReport ];
        [array  addObject:report];
        
        ZZFuncitonModel *star  = [[ZZFuncitonModel  alloc]initWithImageName:@"collected_60x60" name:@"收藏" modelType:ZZFuncitonModelTypeStar ];
        [array  addObject:star];
        self.starModel = star;
        
        ZZFuncitonModel *backHome  = [[ZZFuncitonModel  alloc]initWithImageName:@"home_60x60" name:@"返回主页" modelType:ZZFuncitonModelTypeBackHome ];
        [array addObject:backHome];
        
        _functions =array;
    }
    return _functions;
}

-(ZZDetailFunctionView *)detailFV{
    if (_detailFV == nil) {
        ZZDetailFunctionView *functionView =  [ZZDetailFunctionView  detailFunctionView];
        functionView.shares = [ZZUMTool  sharedUMTool].shareModels;
        functionView.functions = self.functions;
        functionView.delegate = self;
        _detailFV = functionView;
    }
    return _detailFV;
}
@end

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
#import "ZZActivityDetailParam.h"
#import "ZZActivityHttpTool.h"
#import "ZZActivity.h"
typedef enum {
    ZZActivityBottomToolBarTypeApply,//预定
    ZZActivityBottomToolBarTypeCollect//收藏
}ZZActivityBottomToolBarType;
@interface ZZActivityDetailController ()<ZZDetailFunctionViewDelegate>
//当前功能按钮
@property (nonatomic, strong)NSArray *functions;
/**收藏模型*/
@property (nonatomic, strong)ZZFuncitonModel *starModel;
/**更多功能*/
@property (nonatomic, strong)ZZDetailFunctionView *detailFV;

/**预约*/
@property (nonatomic, strong) UIButton *applyBtn;
/**收藏*/
@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, strong) ZZActivity *detailActivity;
@end

@implementation ZZActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    self.view.backgroundColor = ZZViewBackColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self   getDetailActivity];
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
    detailIV.delegateVC = self;
    detailIV.activity = self.detailActivity;
    detailIV.frame = CGRectMake(0, 64, ScreenWidth, detailIV.totalHeight);
    [scrollView addSubview:detailIV];
    //细则
    ZZDetailRuleView *detailRuleV = [[ZZDetailRuleView  alloc]init];
    detailRuleV.activity = self.detailActivity;
    detailRuleV.frame = CGRectMake(0, CGRectGetMaxY(detailIV.frame), ScreenWidth, detailRuleV.totalHeight);
    detailRuleV.delegateVC = self;
    
    [scrollView addSubview:detailRuleV];
//    //详情
    ZZDetailsView *detailView = [[ZZDetailsView  alloc]init];
    detailView.frame = CGRectMake(0, CGRectGetMaxY(detailRuleV.frame), ScreenWidth, detailView.totalHeight);
    [scrollView addSubview:detailView];
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(detailView.frame));
    //工具栏
    ZZActivityBottomToolBar *actiBottomTool = [[ZZActivityBottomToolBar  alloc]initWithFrame:CGRectMake(0, scrollHeight, scrollWidth, toolHeight)];
    actiBottomTool.btns = @[self.collectBtn,self.applyBtn];
    [self.view  addSubview:actiBottomTool];
}

#pragma mark -响应事件
//分享
- (void)moreFunction{
  
    [self.detailFV showAnimation];
  
}
- (void)btnAction:(UIButton *)btn{
    switch (btn.tag) {
        case ZZActivityBottomToolBarTypeApply:
            
            break;
        case ZZActivityBottomToolBarTypeCollect:
            btn.selected = YES;
        default:
            break;
    }
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

#pragma mark -net
- (void)getDetailActivity{
    [MBProgressHUD  showMessage:ZZNetLoading toView:self.view];
    
    [ZZActivityHttpTool  activityDetail:self.activityId success:^(ZZActivity *detailActivity, ZZNetDataType netSuccType) {
        self.detailActivity = detailActivity;
        [self  setRightItem];
        [self  setUpChild];
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
    } failure:^(NSString *error, ZZNetDataType netFialType) {
        
         [MBProgressHUD  hideHUDForView:self.view animated:YES];
    }];
}
-(void)dealloc{
    ZZLog(@"%@",[self  class]);
    //打开键盘向上
     ZZKeyBoardTool(open);
}
//创建button
- (UIButton *)setupBtnWithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon  title:(NSString *)title backColor:(UIColor *)backColor  tag:(ZZActivityBottomToolBarType)barType
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = barType;
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn  setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = ZZContentFont;
    btn.backgroundColor = backColor;
    btn.adjustsImageWhenHighlighted = NO;
    [btn  addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside ];
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    return btn;
}
#pragma mark - lazy load

-(UIButton *)applyBtn{
    if (_applyBtn == nil) {
        _applyBtn = [self setupBtnWithIcon:@"supported_20x20"  selectedIcon:@"" title:@"预定"  backColor:ZZGreenColor  tag:ZZActivityBottomToolBarTypeCollect];
    }
    return _applyBtn ;
}
-(UIButton *)collectBtn{
    if (_collectBtn == nil) {
        _collectBtn = [self setupBtnWithIcon:@"collect_60x60" selectedIcon:@"collected_60x60" title:@"收藏"  backColor:ZZBlueColor  tag:ZZActivityBottomToolBarTypeApply];
    }
    return  _collectBtn;
}
-(NSArray *)functions{
    if (_functions == nil) {
        NSMutableArray *array = [NSMutableArray  arrayWithCapacity:3];
        
        ZZFuncitonModel *report = [[ZZFuncitonModel  alloc]initWithImageName:@"report_60x60" name:@"举报" modelType:ZZFuncitonModelTypeReport ];
        [array  addObject:report];
        
        ZZFuncitonModel *star  = [[ZZFuncitonModel  alloc]initWithImageName:@"collected_60x60" name:@"收藏" modelType:ZZFuncitonModelTypeStar ];
        star.seletedName = @"collected_60x60";
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
    
        functionView.delegate = self;
        _detailFV = functionView;
    }
    return _detailFV;
}
@end

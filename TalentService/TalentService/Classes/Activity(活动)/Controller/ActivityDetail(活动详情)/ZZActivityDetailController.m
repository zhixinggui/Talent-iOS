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
#import "MWPhotoBrowser.h"
#import "ZZImageContent.h"
#import "ZZHudView.h"
#import "ZZEnsureOrderController.h"
typedef enum {
    ZZActivityBottomToolBarTypeApply,//预定
    ZZActivityBottomToolBarTypeCollect//收藏
}ZZActivityBottomToolBarType;
@interface ZZActivityDetailController ()<ZZDetailFunctionViewDelegate,MWPhotoBrowserDelegate,UIAlertViewDelegate,ZZUMToolSocialDelgate>
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

@property (nonatomic, strong)MWPhotoBrowser *photoBrowser;
@property(nonatomic,strong)NSMutableArray*  wBrowserPhotos;
@end

@implementation ZZActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务详情";
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
    detailView.activity = self.detailActivity;
    detailView.frame = CGRectMake(0, CGRectGetMaxY(detailRuleV.frame), ScreenWidth, detailView.totalHeight);
    detailView.delegateVC = self;
    [scrollView addSubview:detailView];
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(detailView.frame));
    //工具栏
    ZZActivityBottomToolBar *actiBottomTool = [[ZZActivityBottomToolBar  alloc]initWithFrame:CGRectMake(0, scrollHeight, scrollWidth, toolHeight)];
    actiBottomTool.btns = @[self.collectBtn,self.applyBtn];
    [self.view  addSubview:actiBottomTool];
}
-(void)viewWillAppear:(BOOL)animated{
    [super  viewWillAppear:animated];
    [self updateBookingButtonProterty];
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
    ZZActivity *activity = self.detailActivity;
    [[ZZUMTool  sharedUMTool]umShareWithTitle:activity.title content:activity.content url:@"http://mengbaopai.smart-kids.com/iosAndroid" imageUrl:activity.servicesImg locialImageName:nil controller:self loginModel:shares[index]];
}
#pragma mark - ZZUMToolSocialDelgate
-(void)didFinishGetUMSocialDataInViewController:(ZZUMToolResponse)umToolResponse result:(NSString *)result{
    [ZZHudView showMessage:result time:3 toView:self.view];
}

- (void)updateCollectButtonProterty{
    self.collectBtn.selected = self.detailActivity.isCollect;
}

- (void)updateBookingButtonProterty{
    self.applyBtn.enabled = !self.detailActivity.isReserve;

    if (self.applyBtn.enabled == NO) {
        self.applyBtn.alpha = 0.5;
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        [self  bookingActivity];
    }else {
        self.applyBtn.enabled = YES;
    }
}
#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.wBrowserPhotos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.wBrowserPhotos.count)
        return [self.wBrowserPhotos objectAtIndex:index];
    return nil;
}

#pragma mark  子view回调方法
- (void)showBigImage:(BOOL)isDetail  currentpage:(NSUInteger) currentpage{
    _photoBrowser = nil;
    NSInteger page = 0;
    if (isDetail) {
        page = currentpage+1;
    }
    [self.photoBrowser setCurrentPhotoIndex:page];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[UIApplication  sharedApplication].keyWindow.rootViewController presentViewController:nc animated:YES completion:nil];
}

#pragma mark -net
- (void)getDetailActivity{
    
    [MBProgressHUD  showMessage:ZZNetLoading toView:self.view];
    [ZZActivityHttpTool  activityDetail:self.activityId success:^(ZZActivity *detailActivity, ZZNetDataType netSuccType) {
        
        if(detailActivity.isDelete){//这个服务是否已经删除
            [MBProgressHUD  hideHUDForView:self.view animated:YES];
            [MBProgressHUD  showMessageClearBackView:@"此服务已删除" toView:self.view];
        }else{
            self.detailActivity = detailActivity;
            [self  setRightItem];
            [self  setUpChild];
            [MBProgressHUD  hideHUDForView:self.view animated:YES];
        }
        
        [self  updateBookingButtonProterty];
    } failure:^(NSString *error, ZZNetDataType netFialType) {
        
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        //提示加载失败并点击重新加载
        [MBProgressHUD showNetLoadFailWithText:@"加载失败，点击重新加载" view:self.view target:self action: @selector(getDetailActivity) isBack:NO];
    }];
}
//预定
- (void)booking:(UIButton *)btn{
    
  
    UIAlertView *alertView = [[UIAlertView  alloc]initWithTitle:nil message:@"你确定要报名吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}

- (void)bookingActivity{
    [MBProgressHUD  showMessage:ZZNetLoading ];
    [ZZActivityHttpTool  activityBook:self.activityId success:^(ZZOrder *order, ZZNetDataType netSuccType) {
        [MBProgressHUD  hideHUD];
    
        ZZEnsureOrderController *ensureVC = [[ZZEnsureOrderController  alloc]init];
        order.serviceInfo = self.detailActivity;
        ensureVC.order = order;
        
        [self.navigationController  pushViewController:ensureVC animated:YES];
      
    } failure:^(NSString *error, ZZNetDataType netFialType) {
        [MBProgressHUD  hideHUD];
        [ZZHudView  showMessage:error time:3 toView:self.view];
       
    }];
}
/**
 *  收藏
 *
 *  @param btn <#btn description#>
 */
- (void)collect:(UIButton *)btn{
    //btn.enabled = NO;
    
    [ZZActivityHttpTool  activityCollect:self.activityId collect:!self.detailActivity.isCollect success:^(id json, ZZNetDataType netSuccType) {
        self.detailActivity.isCollect = !self.detailActivity.isCollect;
        NSString *tips = self.detailActivity.isCollect ? @"收藏成功":@"取消收藏成功";
        [ZZHudView  showMessage:tips time:1 toView:self.view];
        btn.enabled = YES;
        [self  updateCollectButtonProterty];
        
        NSNotification * noti = [NSNotification  notificationWithName:ZZMyCollectionNoti object:nil];
        [[NSNotificationCenter  defaultCenter]postNotification:noti];
        
    } failure:^(NSString *error, ZZNetDataType netFialType) {
        btn.enabled = YES;
        [ZZHudView  showMessage:error time:2 toView:self.view];
    }];
}
-(void)dealloc{
    //打开键盘向上
     ZZKeyBoardTool(open);
}
//创建button
- (UIButton *)setupBtnWithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon  title:(NSString *)title selectedTitle:(NSString *)selectedTitle   tag:(ZZActivityBottomToolBarType)barType
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = barType;
   
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
   
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    if (barType == ZZActivityBottomToolBarTypeApply) {
        [btn  setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateDisabled];
        [btn  setTitle:selectedTitle forState:UIControlStateDisabled];
        [btn setTitleColor:ZZLightGrayColor forState:UIControlStateDisabled];
    }else{
         [btn  setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateSelected];
       [btn  setTitle:selectedTitle forState:UIControlStateSelected];
        [btn setTitleColor:ZZLightGrayColor forState:UIControlStateSelected];
    }
   
    btn.titleLabel.font = ZZContentFont;
 
    btn.adjustsImageWhenHighlighted = NO;

    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    return btn;
}
#pragma mark - lazy load
-(MWPhotoBrowser *)photoBrowser{
    if (_photoBrowser == nil){
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.displayActionButton = YES;//  展示操作按钮
        //        browser.displayNavArrows = NO;  　//底部显示左右按钮移动
        //        browser.displaySelectionButtons = NO;  //显示选择按钮
        //        browser.alwaysShowControls = NO; //一直显示返回导航栏
        browser.zoomPhotosToFill = YES; //是否可以缩放
        //        browser.enableGrid = NO; //是否可以显示网格状
        //        browser.startOnGrid = NO;  //以网格状开始
        //        browser.enableSwipeToDismiss = NO;//是否能滑动消失
        //        browser.autoPlayOnAppear = NO;   //出现的时候视频播放
        _photoBrowser = browser;
    }
    return _photoBrowser;
}

-(NSMutableArray *)wBrowserPhotos{
    if (_wBrowserPhotos ==nil) {
        _wBrowserPhotos = [NSMutableArray  array];
        [_wBrowserPhotos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:self.detailActivity.servicesBigImg]]];
        
        for (ZZImageContent *imageContent in self.detailActivity.serviceImgList) {
            [_wBrowserPhotos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:imageContent.imgBigPath]]];
        }
    }
    return _wBrowserPhotos;
}
-(UIButton *)applyBtn{
    if (_applyBtn == nil) {
        _applyBtn = [self setupBtnWithIcon:@"reserve_40x40"  selectedIcon:@"reserved_40x40" title:@"预定"  selectedTitle:@"已预定"    tag:ZZActivityBottomToolBarTypeApply];
        
        [self  updateBookingButtonProterty];

        _applyBtn.backgroundColor = ZZBlueColor;
        [_applyBtn  addTarget:self action:@selector(booking:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyBtn ;
}
-(UIButton *)collectBtn{
    if (_collectBtn == nil) {
        _collectBtn = [self setupBtnWithIcon:@"collect_40x40" selectedIcon:@"collected_40x40" title:@"收藏"  selectedTitle:@"已收藏"   tag:ZZActivityBottomToolBarTypeCollect];
        [_collectBtn addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    
        _collectBtn.backgroundColor = ZZGreenColor;
        [self  updateCollectButtonProterty];
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

//
//  ZZNaviController.m
//  TalentService
//
//  Created by zhizhen on 15/8/18.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZNaviController.h"
#import "UIBarButtonItem+Extension.h"
#import "AFNetworkReachabilityManager.h"

CGFloat const  duration = 0.75;
@interface ZZNaviController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;
@property (nonatomic, strong) UILabel *netStatusLabel;
@end

@implementation ZZNaviController


+ (void)initialize
{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setTintColor:[UIColor  whiteColor]];
    [appearance setBarTintColor:ZZNatiBarColor];
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = ZZNatiTitleColor;
    textAttrs[NSFontAttributeName] = ZZNaviTitleFont;
    [appearance setTitleTextAttributes:textAttrs];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    [[NSNotificationCenter  defaultCenter]addObserver:self selector:@selector(NetStatusChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    self.delegate = self;
}

- (void)NetStatusChange:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    NSInteger cck = [dic[AFNetworkingReachabilityNotificationStatusItem]integerValue];
    switch (cck) {
        case 0:
            [self netLabelShow];
            break;
        case 1:
         case 2:
            [self  netLabelDismiss];
            break;
        default:
            break;
    }
    

}

- (void)netLabelShow{
    self.netStatusLabel.text = @"没有网络，隔开了你我TA";
    [self.view  insertSubview:self.netStatusLabel belowSubview:self.navigationBar];
    [UIView  animateWithDuration:duration animations:^{
         self.netStatusLabel.transform = CGAffineTransformMakeTranslation(0, self.netStatusLabel.height);
    }];
}

- (void)netLabelDismiss{
    self.netStatusLabel.text = @"网络通了，有了整个世界";
    [UIView  animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.netStatusLabel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.netStatusLabel  removeFromSuperview];
    }];
  
}
/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        self.navigationBarHidden = NO;
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
       
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        UIBarButtonItem *back = [UIBarButtonItem  itemWithTarget:self action:@selector(back) image:@"return_30x30" highImage:nil];
        
        negativeSeperator.width = -16;//此处修改到边界的距离，请自行测试
        viewController.navigationItem.leftBarButtonItems = @[negativeSeperator,back];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
#warning 这里要用self，不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count == 0) { // 是根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }else{ // 非根控制器
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }
}

#pragma mark - set or get
- (UILabel *)netStatusLabel{
    if (_netStatusLabel == nil) {
        _netStatusLabel = [[UILabel  alloc]init];
        _netStatusLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
        _netStatusLabel.text = @"没有网络，隔开了你我TA";
        _netStatusLabel.textAlignment = NSTextAlignmentCenter;
        _netStatusLabel.textColor = [UIColor  whiteColor];
        _netStatusLabel.width = self.view.width;
        _netStatusLabel.height = 35;
        _netStatusLabel.x = 0;
        _netStatusLabel.y = 64 - _netStatusLabel.height;
    }
    return _netStatusLabel;
}
@end

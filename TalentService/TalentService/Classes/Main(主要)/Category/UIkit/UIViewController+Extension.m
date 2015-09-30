//
//  UIViewController+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/30.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "AppDelegate.h"
#import "ZZLoginVC.h"
#import "MobClick.h"
#define mengID (954281556)
@implementation UIViewController (Extension)
#pragma mark -黑魔法 Method swizzling - 友盟数据统计
+ (void)load {   static dispatch_once_t onceToken;  dispatch_once(&onceToken, ^{
    Class class = [self class];    // When swizzling a class method, use the following:
    // Class class = object_getClass((id)self);
//    swizzleMethod(class, @selector(viewDidLoad), @selector(aop_viewDidLoad));
//    swizzleMethod(class, @selector(viewDidAppear:), @selector(aop_viewDidAppear:));
    swizzleMethod(class, @selector(viewWillAppear:), @selector(aop_viewWillAppear:));
    swizzleMethod(class, @selector(viewWillDisappear:), @selector(aop_viewWillDisappear:));
});
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)   {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
//- (void)aop_viewDidAppear:(BOOL)animated {
//    [self aop_viewDidAppear:animated];
//    
//    
//}

-(void)aop_viewWillAppear:(BOOL)animated {
    [self aop_viewWillAppear:animated];
#ifndef DEBUG
    [MobClick beginLogPageView:NSStringFromClass([self class])];
#endif
}
-(void)aop_viewWillDisappear:(BOOL)animated {
    [self aop_viewWillDisappear:animated];
#ifndef DEBUG
    
    [MobClick endLogPageView:NSStringFromClass([self class])];
#endif
}
//- (void)aop_viewDidLoad {
//    [self aop_viewDidLoad];if ([self isKindOfClass:[UINavigationController class]]) {    UINavigationController *nav = (UINavigationController *)self;
//        nav.navigationBar.translucent = NO;
//        nav.navigationBar.barTintColor = GLOBAL_NAVIGATION_BAR_TIN_COLOR;
//        nav.navigationBar.tintColor = [UIColor whiteColor];    NSDictionary *titleAtt = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//        [[UINavigationBar appearance] setTitleTextAttributes:titleAtt];
//        [[UIBarButtonItem appearance]
//         setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//         forBarMetrics:UIBarMetricsDefault];
//    }//    self.view.backgroundColor = [UIColor whiteColor];self.navigationController.interactivePopGestureRecognizer.delegate = (id<uigesturerecognizerdelegate>)self;
//}
#pragma mark - Settings

- (NSString *)navTitleString {
    return self.navigationItem.title ? self.navigationItem.title : self.title;
}

- (void)setNavTitleString:(NSString *)titleString {
    if (self.navigationItem.titleView && [self.navigationItem.titleView  isKindOfClass:[UILabel  class]]) {
        UILabel *label = (UILabel *)self.navigationItem.titleView;
        label.text = self.title;
    }else{
        //自定义标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textColor = ZZNatiTitleColor;//设置文本颜色
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = titleString;
        [titleLabel  sizeToFit];
        self.navigationItem.titleView = titleLabel;
    }
    
}

- (UIView *)navTitleView {
    return self.navigationItem.titleView;
}

- (void)setNavTitleView:(UIView *)view {
    [self setNavigationBarTitle:view];
}

- (void)setNavigationBarTitle:(id)content {
    if (content) {
        if ([content isKindOfClass:[NSString class]]) {
            self.navigationItem.titleView = nil;
            self.navigationItem.title = content;
        }
        else if ([content isKindOfClass:[UIImage class]]) {
            UIImageView * imageView = [[UIImageView alloc] initWithImage:content];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            
            self.navigationItem.titleView = imageView;
        }
        else if ( [content isKindOfClass:[UIView class]] )
        {
            UIView *view = content;
            
            view.backgroundColor = [UIColor clearColor];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            view.autoresizesSubviews = YES;
            view.x = self.view.bounds.size.width/2;
            
            self.navigationItem.titleView = content;
        }
        else if ( [content isKindOfClass:[UIViewController class]] )
        {
            self.navigationItem.titleView = ((UIViewController *)content).view;
        }
    }
}
- (id)initWithNib {
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
}
-(void)jumpToAppStoreWithAppID:(long)appID{
    
    if(appID <= 0){
        appID = mengID;
    }
    NSString *string = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8",@(appID)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

- (void)swithWindowRootControllerToLogin{
    AppDelegate *app = (AppDelegate *)[UIApplication  sharedApplication].delegate;
    [app  swithWindowRootViewController:ZZRootViewControllerTypeLogin];
}

- (void)swithWindowRootControllerToHome{
    AppDelegate *app = (AppDelegate *)[UIApplication  sharedApplication].delegate;
    [app  swithWindowRootViewController:ZZRootViewControllerTypeHome];
}
@end

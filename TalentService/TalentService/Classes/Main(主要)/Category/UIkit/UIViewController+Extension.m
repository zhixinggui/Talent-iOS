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
#define mengID (954281556)
@implementation UIViewController (Extension)
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
    AppDelegate *app = [UIApplication  sharedApplication].delegate;
    [app  swithWindowRootViewController:ZZRootViewControllerTypeLogin];
}

- (void)swithWindowRootControllerToHome{
    AppDelegate *app = [UIApplication  sharedApplication].delegate;
    [app  swithWindowRootViewController:ZZRootViewControllerTypeHome];
}
@end

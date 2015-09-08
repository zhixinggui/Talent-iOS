//
//  UIViewController+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/30.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (Extension)

@property (nonatomic, strong) NSString *navTitleString;
@property (nonatomic, strong) UIView *navTitleView;

- (id)initWithNib;
/**
 *  跳转到AppStore
 *  params  appID 对应的app的id  ，默认为萌宝派的id
 */
-(void)jumpToAppStoreWithAppID:(long)appID;

- (void)swithWindowRootControllerToLogin;

- (void)swithWindowRootControllerToHome;
@end

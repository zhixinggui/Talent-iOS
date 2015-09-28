//
//  ZZOrderTopView.h
//  TalentService
//
//  Created by zhizhen on 15/9/28.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZActivity ;
@interface ZZOrderTopView : UIView
/**仅能通过xib调用*/
+ (instancetype)orderTopView;
@property (nonatomic , weak)ZZActivity *activity;
@property (nonatomic, weak)UIViewController *vcDelegate;
//是否跳转
@property (nonatomic) BOOL jump;
@end

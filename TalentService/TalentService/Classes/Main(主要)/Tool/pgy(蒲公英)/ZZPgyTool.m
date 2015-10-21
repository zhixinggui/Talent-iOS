//
//  ZZPgyTool.m
//  TalentService
//
//  Created by zhizhen on 15/10/21.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZPgyTool.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
/*boundle 为 mengbaopai*/
NSString * const MengBaoPGYAppID = @"75ecf01e09a903debd4801d01867b112";
/*boundle 为 bt.yun*/
//NSString * const MengBaoPGYAppID = @"752add9af11b111092e66b55e16af7eb";
@implementation ZZPgyTool

+ (void)load{
    
#pragma mark - crash收集
    /*
     自定义用户反馈激活方式(默认为摇一摇)：
     必须在调用 [[PgyManager sharedPgyManager] startManagerWithAppId:@"PGY_APP_ID"] 前设置。
     */
    // 设置用户反馈界面激活方式为三指拖动
  //  [[PgyManager sharedPgyManager] setFeedbackActiveType:kPGYFeedbackActiveTypeThreeFingersPan];
    // 设置用户反馈界面激活方式为摇一摇
    [[PgyManager sharedPgyManager] setFeedbackActiveType:kPGYFeedbackActiveTypeShake];
    
    //启动基本SDK
    [[PgyManager sharedPgyManager] startManagerWithAppId:MengBaoPGYAppID];
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:MengBaoPGYAppID];
    //关闭用户反馈功能(默认开启)：
    //[[PgyManager sharedPgyManager] setEnableFeedback:NO];
    
    
//    开发者可以通过设置用户反馈界面的颜色主题来改变界面风格，设置之后的颜色会影响到Title的背景颜色和录音按钮的边框颜色，默认为0x37C5A1(绿色)
    [[PgyManager sharedPgyManager] setThemeColor:[UIColor blackColor]];
//开发者可以自定义摇一摇的灵敏度，默认为2.3，数值越小灵敏度越高。
//    [[PgyManager sharedPgyManager] setShakingThreshold:3.0];
//    五、除了可以使用“摇一摇”和“三指拖动”来激活用户反馈，开发者还可以通过代码来直接激活用户反馈功能：
//    [[PgyManager sharedPgyManager] showFeedbackView];
    
#pragma mark - 版本更新
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:MengBaoPGYAppID];   // 请将 PGY_APP_ID 换成应用的 App ID
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
}
@end

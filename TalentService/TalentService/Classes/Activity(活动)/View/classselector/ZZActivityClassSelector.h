//
//  ZZActivityClassSelector.h
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFunctionShowRule.h"
@class ZZActivityClassSelector;

@protocol ZZActivityClassSelectorDelegate <NSObject>

- (void)activityClassSelector:(ZZActivityClassSelector *)activityClassSelector  selectNsobject:(id <ZZActivityClassSelectorShowDele>)object  title:(NSString *)title;

@end
@interface ZZActivityClassSelector : UIView
+(instancetype)activityClassSelectorWithDlegate:(UIViewController<ZZActivityClassSelectorDelegate>  *)delgate;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSArray *datas;

- (void)showAnimation;

- (void)dismissAnimation;
@end

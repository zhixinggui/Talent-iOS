//
//  ZZSexSelector.h
//  TalentService
//
//  Created by charles on 15/9/16.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZSexSelector;
@protocol ZZSexSelectorDelegate <NSObject>
//选择男 或 女
-(void)sexSelectordidSelected:(ZZSexSelector *)sexselctor selectedSex:(NSString *)sex;
//取消选择
-(void)sexSelectorCancelSelected:(ZZSexSelector *)sexselctor;

@end
@interface ZZSexSelector : UIView
@property (nonatomic, weak)id<ZZSexSelectorDelegate> delegate;

- (void)showAnimation;

- (void)dismissAnimation;
@end

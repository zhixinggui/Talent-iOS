//
//  ZZFailView.h
//  TalentService
//
//  Created by zhizhen on 15/9/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZFailView : UIView

+(instancetype)failViewReason:(NSString *)reason toView:(UIView *)toView;
@property (nonatomic)UIEdgeInsets contentInset;
- (void)addTarget:(id)target action:(SEL)action ;
@end

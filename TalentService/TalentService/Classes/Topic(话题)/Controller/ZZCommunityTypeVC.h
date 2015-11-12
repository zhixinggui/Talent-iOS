//
//  ZZCommunityTypeVC.h
//  TalentService
//
//  Created by charles on 15/11/3.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTopicType.h"
@protocol topicTypeDelegete <NSObject>

- (void) getTopicType: (ZZTopicType *)topicType;

@end


@interface ZZCommunityTypeVC : UIViewController
@property (nonatomic, weak)id<topicTypeDelegete> delegate;
@end

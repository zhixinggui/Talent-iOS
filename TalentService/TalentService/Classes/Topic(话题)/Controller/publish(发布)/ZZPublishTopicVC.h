//
//  ZZPublishTopicVC.h
//  TalentService
//
//  Created by zhizhen on 15/10/18.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZTopicImageCell;
@interface ZZPublishTopicVC : UIViewController
- (void)deleteImage:(ZZTopicImageCell *)cell;

- (void)amplificImage:(ZZTopicImageCell *)cell;
@end

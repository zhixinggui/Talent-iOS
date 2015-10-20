//
//  ZZTopicImageCell.h
//  TalentService
//
//  Created by zhizhen on 15/10/19.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZPublishTopicVC;
@interface ZZTopicImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *arrowIV;

@property (weak, nonatomic) IBOutlet UIImageView *showIV;

@property (weak, nonatomic) ZZPublishTopicVC *delegate;
@end

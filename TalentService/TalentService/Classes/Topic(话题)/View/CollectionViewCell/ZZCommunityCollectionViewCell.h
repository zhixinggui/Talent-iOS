//
//  ZZCommunityCollectionViewCell.h
//  TalentService
//
//  Created by charles on 15/11/4.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZTopicType.h"

#define communityCollectionViewCellCelldentifier @"communityCollectionViewCellCelldentifier"
@interface ZZCommunityCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) ZZTopicType *topicType;
@end

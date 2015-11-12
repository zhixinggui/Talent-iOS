//
//  ZZCommunityCollectionViewCell.m
//  TalentService
//
//  Created by charles on 15/11/4.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZCommunityCollectionViewCell.h"

@interface ZZCommunityCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@end

@implementation ZZCommunityCollectionViewCell

- (void)awakeFromNib {

}

- (void)setTopicType:(ZZTopicType *)topicType {
    _topicType = topicType;
    self.topicLabel.text = topicType.name;
}
@end

//
//  ZZTopicAddImageCell.m
//  TalentService
//
//  Created by zhizhen on 15/10/19.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicAddImageCell.h"

@interface ZZTopicAddImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *addIV;

@end
@implementation ZZTopicAddImageCell

- (void)awakeFromNib {
    self.addIV.contentMode = UIViewContentModeScaleAspectFill;
    self.addIV.clipsToBounds = YES;
}

@end

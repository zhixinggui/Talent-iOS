//
//  ZZTopicImageCell.m
//  TalentService
//
//  Created by zhizhen on 15/10/19.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicImageCell.h"
#import "ZZPublishTopicVC.h"
@interface ZZTopicImageCell ()

@end
@implementation ZZTopicImageCell

- (void)awakeFromNib {
    UIImageView* iV = [[UIImageView  alloc]init];
    iV.image = [UIImage  imageNamed:@"arrow_30X30"];
    iV.contentMode = UIViewContentModeScaleAspectFill;
    iV.clipsToBounds = YES;
    self.selectedBackgroundView = iV;
}

- (IBAction)deleteImage:(UIButton *)sender {
    [self.delegate  deleteImage:self];
}

//放大
- (IBAction)amplificImage:(UIButton *)sender {
    [self.delegate  amplificImage:self];
}

@end

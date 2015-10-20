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

    self.arrowIV.hidden = YES;

}

- (IBAction)deleteImage:(UIButton *)sender {
    [self.delegate  deleteImage:self];
}

//放大
- (IBAction)amplificImage:(UIButton *)sender {
    [self.delegate  amplificImage:self];
}

@end

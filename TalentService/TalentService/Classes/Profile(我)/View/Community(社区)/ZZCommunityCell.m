//
//  ZZCommunityCell.m
//  TalentService
//
//  Created by charles on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZCommunityCell.h"
#import "ZZHeadImageView.h"
#import "ZZTopicImage.h"
#define labelHeight 43
#define imageHeight (ScreenWidth - 50)/3
@interface ZZCommunityCell()
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstIV;
@property (weak, nonatomic) IBOutlet UIImageView *secondIV;
@property (weak, nonatomic) IBOutlet UIImageView *thirdIV;
@property (weak, nonatomic) IBOutlet UIButton *secondBT;
@property (weak, nonatomic) IBOutlet UIButton *thirdBT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageConstraint;
@end
@implementation ZZCommunityCell
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {

    }
    return self;
}
- (void)awakeFromNib {
    self.width = ScreenWidth;
    ZZLog(@"ScreenWidth:%lf",self.width);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    
//    [[UIImage imageNamed:@"border_34x34"]drawInRect:CGRectMake(rect.origin.x +5, rect.origin.y+5, rect.size.width - 8, rect.size.height-5)];
//
//}

#pragma mark - Setters and Getters
- (void)setTopic:(ZZTopic *)topic {
    self.imageConstraint.constant = 53;
    self.backgroundConstraint.constant = 57 + imageHeight + 30;
    self.contentLabel.hidden = NO;
    self.firstIV.hidden = NO;
    self.secondIV.hidden = NO;
    self.thirdIV.hidden = NO;
    _topic = topic;
    self.titleLabel.text = topic.title;
    if (topic.contents) {
        //有内容
        self.contentLabel.text = topic.contents;
        //图片判断
        if (topic.topicImgList.count) {
            for (int i = 0; i<topic.topicImgList.count; i++) {
                ZZTopicImage *topicimage = topic.topicImgList[i];
                switch (i) {
                    case 0:
                        
                        [self.firstIV setPictureImageWithURL:topicimage.imgPath];
                        break;
                        
                    case 1:
                        
                        [self.secondIV setPictureImageWithURL:topicimage.imgPath];
                        break;
                        
                    case 2:
                        
                        [self.thirdIV setPictureImageWithURL:topicimage.imgPath];
                        break;
                        
                    default:
                        break;
                }
            }
        } else {
            self.firstIV.hidden = YES;
            self.secondIV.hidden = YES;
            self.thirdIV.hidden = YES;
            ZZLog(@"imageHeight:%lf",imageHeight);
            self.backgroundConstraint.constant = 176 - 90;
        }
    } else {
        //没内容
            for (int i = 0; i<topic.topicImgList.count; i++) {
                ZZTopicImage *topicimage = topic.topicImgList[i];
                switch (i) {
                    case 0:
                        
                        [self.firstIV setPictureImageWithURL:topicimage.imgPath];
                        break;
                        
                    case 1:
                        
                        [self.secondIV setPictureImageWithURL:topicimage.imgPath];
                        break;
                        
                    case 2:
                        
                        [self.thirdIV setPictureImageWithURL:topicimage.imgPath];
                        break;
                        
                    default:
                        break;
                }
            }
        self.contentLabel.hidden = YES;
        self.backgroundConstraint.constant = 57 + imageHeight + 30 - labelHeight;
        self.imageConstraint.constant = 53 - labelHeight;
    }
    
}

- (void)imageOrNoimage {
    
}
@end

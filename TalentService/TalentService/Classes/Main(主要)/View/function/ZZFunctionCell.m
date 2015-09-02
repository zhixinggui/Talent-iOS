//
//  ZZFunctionCell.m
//  TalentService
//
//  Created by zhizhen on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZFunctionCell.h"

@interface ZZFunctionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation ZZFunctionCell

- (void)awakeFromNib {
    self.iconIV.contentMode = UIViewContentModeScaleAspectFill;
    self.iconIV.clipsToBounds = YES;
    self.nameLabel.textColor = ZZLightGrayColor;
}

-(void)setShowRule:(id<ZZFunctionShowRuleDelegate>)showRule{
    _showRule = showRule;
    self.nameLabel.text = [showRule  name];
    self.iconIV.image = [UIImage  imageNamed:[showRule  imageName]];
}



+ (NSString *)functionCellIdentifier{
    
    return @"FunctionCell";
}
@end

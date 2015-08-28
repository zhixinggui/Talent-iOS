//
//  ZZPayTypeShowView.m
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZPayTypeShowView.h"

@interface ZZPayTypeShowView ()
@property (weak, nonatomic) IBOutlet UIButton *clickButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;

@end
@implementation ZZPayTypeShowView
+ (instancetype)payTypeShowView{
    return [[[NSBundle  mainBundle]loadNibNamed:@"ZZPayTypeShowView" owner:nil options:nil]lastObject];
}
-(void)awakeFromNib{
   
    self.width = ScreenWidth;
}
-(void)setPayType:(ZZPayType *)payType{
    _payType = payType;
    self.iconIV.image = [UIImage  imageNamed:payType.iconName];
}
-(void)setSelected:(BOOL)selected{
    _selected = selected;
    self.clickButton.selected = selected;
}
-(void)addTarget:(id)target action:(SEL)action{
    [self.clickButton  addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end

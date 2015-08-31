//
//  ZZHeadView.m
//  TalentService
//
//  Created by zhizhen on 15/8/25.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZHeadView.h"

@interface ZZHeadView ()
@property (weak, nonatomic) IBOutlet UIButton *showButton;

@end
@implementation ZZHeadView
-(void)awakeFromNib{
    
    self.showButton.layer.shadowColor = ZZLightGrayColor.CGColor;//shadowColor阴影颜色
    self.showButton.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.showButton.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.showButton.layer.shadowRadius = 2;//阴影半径，默认3
}
@end

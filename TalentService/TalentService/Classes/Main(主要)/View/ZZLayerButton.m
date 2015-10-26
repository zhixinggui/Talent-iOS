//
//  ZZLayerButton.m
//  TalentService
//
//  Created by charles on 15/8/18.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZLayerButton.h"

@implementation ZZLayerButton


-(void)awakeFromNib{
    self.exclusiveTouch = YES;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.backgroundColor = ZZNatiBarColor;
    if (self.height == 24) {
        self.layer.borderColor = [UIColor redColor].CGColor;
    }else{
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}
@end

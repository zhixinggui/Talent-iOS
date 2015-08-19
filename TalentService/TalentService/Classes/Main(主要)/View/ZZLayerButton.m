//
//  ZZLayerButton.m
//  TalentService
//
//  Created by charles on 15/8/18.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZLayerButton.h"

@implementation ZZLayerButton

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.exclusiveTouch = YES;
        self.layer.cornerRadius = self.height/2;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return self;
}
@end

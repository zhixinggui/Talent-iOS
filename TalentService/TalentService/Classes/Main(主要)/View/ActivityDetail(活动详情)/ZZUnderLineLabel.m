//
//  ZZUnderLineLabel.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZUnderLineLabel.h"

@implementation ZZUnderLineLabel

-(void)setText:(NSString *)text{
    text = [NSString  stringWithFormat:@"      %@",text];
    [super setText:text];
}
-(void)drawRect:(CGRect)rect{
    ZZLog(@",,,%@",NSStringFromCGRect(rect));
    [super  drawRect:rect];
    
    [ZZSeparGrayColor  set];
    UIRectFill(CGRectMake(ZZEdgeMargin, rect.size.height +2*rect.origin.y - 3, rect.size.width - 2*ZZEdgeMargin, 1));
}

@end

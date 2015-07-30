//
//  UIButton+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UIButton+Extension.h"
#import "UIImage+Extension.h"
#import "UIButton+WebCache.h"
@implementation UIButton (Extension)

-(void)setN_BG:(NSString *)nbg H_BG:(NSString *)hbg{
    [self setBackgroundImage:[UIImage imageNamed:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateHighlighted];
}


-(void)setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg{
    [self setBackgroundImage:[UIImage stretchedImageWithName:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage stretchedImageWithName:hbg] forState:UIControlStateHighlighted];
}

- (void)setUrlImage:(NSString *)urlStr{
    [self  sd_setBackgroundImageWithURL:[NSURL  URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:nil];
}
@end

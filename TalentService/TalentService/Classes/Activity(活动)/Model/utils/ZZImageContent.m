//
//  ZZImageContent.m
//  TalentService
//
//  Created by zhizhen on 15/9/22.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZImageContent.h"

@implementation ZZImageContent
-(void)setImgPath:(NSString *)imgPath{
   
   _imgPath = [[imgPath  stringByAppendingString:ZZImageUrlAppend(ScreenWidth, YES)]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _imgBigPath = [[imgPath  stringByAppendingString:ZZImageUrlOrigin(YES)]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(CGFloat)imgWidth{
    if (_imgWidth == 0.0) {
        _imgWidth = 100;
    }
    return _imgWidth;
}
@end

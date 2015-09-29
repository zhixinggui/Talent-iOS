//
//  ZZUploadImageModel.m
//  TalentService
//
//  Created by zhizhen on 15/9/24.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZUploadImageModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation ZZUploadImageModel
-(NSData *)data{
    if (_data == nil) {
        if (self.asset&&self.origin) {//原图
            _data = UIImageJPEGRepresentation([UIImage imageWithCGImage:[self.asset.defaultRepresentation  fullScreenImage]], 1);
        }else{
            CGFloat scral = self.asset ? 1 : 0.8;
            _data = UIImageJPEGRepresentation(self.image, scral);
        }
        
    }
    return _data;
}


-(UIImage *)uploadFullScreenImage{

    return self.asset ? [UIImage imageWithCGImage:[self.asset.defaultRepresentation  fullScreenImage]]:self.image;

}
@end

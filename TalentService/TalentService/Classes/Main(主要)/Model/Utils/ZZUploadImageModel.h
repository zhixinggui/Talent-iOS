//
//  ZZUploadImageModel.h
//  TalentService
//
//  Created by zhizhen on 15/9/24.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UIImage,ALAsset;
@interface ZZUploadImageModel : NSObject
/**是否原图上传 yes  原图*/
@property (nonatomic) BOOL origin;
/**显示的图片，调用系统相册的也用这个来接*/
@property (nonatomic, strong)UIImage *image;
/**选择的图片 类型*/
@property (nonatomic, strong)ALAsset * asset;

#pragma mark -以上为图库返回的－－以下为上传所需
/**图片上传的数据*/
@property (nonatomic, strong) NSData *data;
/**图片上传的id*/
@property (nonatomic, copy) NSString *taskId;

/**图片上传成功后的路径 */
@property (nonatomic, copy)NSString *url;
/**图片是否上传成功*/
@property (nonatomic) BOOL succ;
/**上传图片宽度*/
@property (nonatomic, strong) NSNumber *width;
/**上传图片高度*/
@property (nonatomic, strong) NSNumber *height;
/**全屏图片*/
-(UIImage *)uploadFullScreenImage;
@end

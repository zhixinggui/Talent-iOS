//
//  ZZUploadImageTool.h
//  TalentService
//
//  Created by zhizhen on 15/9/24.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZUploadImageModel.h"
#define ZZ_UploadTool [ZZUploadImageTool sharedTool]
/**成功block*/
typedef void (^ZZUploadSuccess)( NSUInteger  succCount);
/**失败block*/
typedef void (^ZZUploadFailure)( NSUInteger  failCount);
@interface ZZUploadImageTool : NSObject
+(instancetype)sharedTool;

/**上传图片方法*/
- (void)upLoadImages:(NSArray *)images success:(ZZUploadSuccess)succ failure:(ZZUploadFailure)fail;
@end

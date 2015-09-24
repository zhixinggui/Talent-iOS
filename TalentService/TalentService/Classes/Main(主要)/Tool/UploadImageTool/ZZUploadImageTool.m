//
//  ZZUploadImageTool.m
//  TalentService
//
//  Created by zhizhen on 15/9/24.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZUploadImageTool.h"
#import <TAESDK/TaeSDK.h>
#import <ALBBMediaService/ALBBMediaService.h>
#define ZZ_ENGINE [ZZ_UploadTool taeFileEngine]
#define ZZ_UUID [ZZ_UploadTool uniqueString]
#define ZZ_NAMESPACE @"smart"                  //请及时替换成你自己的安全图片和namespace，测试地址会定时清理文件的
#define ZZ_DIR  @"/app/test/${year}-${month}-${day}"

static ZZUploadImageTool *_uploadTool;
static id <ALBBMediaServiceProtocol> staticTaeFileEngine;

@interface ZZUploadImageTool ()
@property(nonatomic, strong) id <ALBBMediaServiceProtocol> taeFileEngine;
@property (nonatomic, copy)ZZUploadSuccess  success;
@property (nonatomic, copy)ZZUploadFailure  failure;
@property (nonatomic, strong)NSMutableArray *successArray;
@property (nonatomic) NSUInteger imageCount;
@end
@implementation ZZUploadImageTool
#pragma mark - 单例
+(instancetype)sharedTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _uploadTool = [[self alloc]init];
    });
    return _uploadTool;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _uploadTool = [[self alloc]init];
    });
    return _uploadTool;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _uploadTool;
}
#pragma mark -init
/**初始化*/
+(void)initialize{
    [[TaeSDK sharedInstance] setDebugLogOpen:NO];
    [[TaeSDK sharedInstance] asyncInit];
}

- (id <ALBBMediaServiceProtocol>)taeFileEngine {
    if (!staticTaeFileEngine) {
        staticTaeFileEngine = [[TaeSDK sharedInstance] getService:@protocol(ALBBMediaServiceProtocol)];
        if (!staticTaeFileEngine) {
            [[TaeSDK sharedInstance] asyncInit];
        }
    }
    return staticTaeFileEngine;
}
/**上传图片*/
- (NSString *)uploadByData:(NSData *)data notification:(TFEUploadNotification *)notification {
    
    TFEUploadPolicy *policy = [TFEUploadPolicy policyWithANamespace:ZZ_NAMESPACE fileName:ZZ_UUID dir:ZZ_DIR];
    TFEUploadParameters *parms = [TFEUploadParameters paramsWithData:data policy:policy];
    parms.customPolicies =  @{@"returnBody":@{@"w":@"${width}",@"h":@"${height}"}};
    return [ZZ_ENGINE upload:parms notification:notification];
    
}
/**上传图片结果回调*/
- (TFEUploadNotification *)uploadNoti:(ZZUploadImageModel *)uploadModel{
    
    return  [TFEUploadNotification
             notificationWithProgress:^(TFEUploadSession *session, NSUInteger progress) {//进度
                 
             }
             success:^(TFEUploadSession *session, NSString *url) {//成功
                 NSData *jsonData = [session.responseBody dataUsingEncoding:NSUTF8StringEncoding];
                 NSError *err;
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&err];
                 
                 if ([dic isKindOfClass:[NSDictionary  class]]) {
                     NSNumberFormatter* numberFormatter = [[NSNumberFormatter  alloc] init];
                     uploadModel.width = [numberFormatter numberFromString:dic[@"w"]];
                     uploadModel.height = [numberFormatter  numberFromString:dic[@"h"]];
                 }
                 
                 uploadModel.url = url;
                 uploadModel.succ = YES;
      
                 [self  updateResult:uploadModel result:YES];
             }
             failed:^(TFEUploadSession *session, NSError *error) {//失败
                 uploadModel.succ = NO;
                 uploadModel.url = nil;
                 [self  updateResult:uploadModel result:NO];
             }
            ];
    
}

/**回调上传结果*/
- (void)updateResult:(ZZUploadImageModel *)imageData result:(BOOL) succ{
    if (succ ) {
        if (![self.successArray containsObject:imageData]&& self.success) {
            [self.successArray  addObject:imageData];
            if (self.imageCount == self.successArray.count) {
                self.success(self.successArray.count);
                [self  clearRecord];
            }

        }
        
    }else{
        if (self.failure) {
            self.failure(1);
            [self cancellAllUploads];
            [self  clearRecord];
        }
    }
}
//清除记录，避免循环引用
- (void)clearRecord{
    self.success = nil;
    self.failure = nil;
    self.successArray = nil;
    self.failure = nil;
}
/**取消所有上传*/
- (void)cancellAllUploads{
    [ZZ_ENGINE  cancelAllUploads];
}
/** 生成一个uuid*/
- (NSString *)uniqueString {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString *) CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

#pragma mark - 公用方法
/**上传图片方法*/
- (void)upLoadImages:(NSArray *)images success:(ZZUploadSuccess)succ failure:(ZZUploadFailure)fail{
    
    self.success = succ;
    self.failure = fail;
    NSUInteger count = images.count;
    self.imageCount = count;
    self.successArray = [NSMutableArray  arrayWithCapacity:count];
    for (ZZUploadImageModel *uploadModel in images) {
        uploadModel.taskId =    [self  uploadByData:uploadModel.data notification:[self  uploadNoti:uploadModel]];
    }
}
@end

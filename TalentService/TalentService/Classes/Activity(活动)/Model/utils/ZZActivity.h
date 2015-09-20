//
//  ZZActivity.h
//  TalentService
//
//  Created by zhizhen on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//   活动（又称服务）

#import <Foundation/Foundation.h>

@interface ZZActivity : NSObject
/** 活动id  */
@property (nonatomic) NSInteger activityId;
/** 标题  */
@property (nonatomic, copy)NSString *title;
/** 活动开始时间  */
@property (nonatomic, copy)NSDate *startTime;
/** 活动结束时间  */
@property (nonatomic, copy)NSDate *endTime;
/** 报名开始时间  */
@property (nonatomic, copy)NSDate *applyStartTime;
/** 报名结束时间  */
@property (nonatomic, copy)NSDate *applyEndTime;

/**  最多报名人数 */
@property (nonatomic) NSInteger peoples;
/**  已报名人数 */
@property (nonatomic) NSInteger realityPeoples;
/** 省份  */
@property (nonatomic) NSInteger province;
/** 城市  */
@property (nonatomic) NSInteger city;
/** 区  */
@property (nonatomic) NSInteger district;
/**  活动地址 */
@property (nonatomic, copy)NSString *address;
/**   */
@property (nonatomic, strong) NSNumber *price;
/** 活动价格  */
@property (nonatomic) NSInteger type;
/**  活动正文 */
@property (nonatomic, copy)NSString *content;
/** 服务电话  */
@property (nonatomic, copy)NSString *servicePhone;
/**  活动状态 */
@property (nonatomic) NSInteger status;
/**  是否推荐 */
@property (nonatomic) BOOL isRecommoned;
/**  服务图片 */
@property (nonatomic, copy)NSString *servicesImg;
/**  是否删除 */
@property (nonatomic) BOOL isDelete;

/**   */
@property (nonatomic, strong)NSArray *properties;

#pragma mark  - 客户端有的，为了显示效果
@property (nonatomic, copy)NSURL *imgUrl;
@end

//
//  ZZTopic.h
//  TalentService
//
//  Created by charles on 15/11/11.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZOtherUser.h"
@interface ZZTopic : NSObject
/** 话题id  */
@property (nonatomic) NSInteger topicId;
/** 浏览数  */
@property (nonatomic) NSInteger browseNumber;
/** 评论数  */
@property (nonatomic) NSInteger replys;
/** 帖子标题  */
@property (nonatomic, strong) NSString *title;
/** 帖子内容  */
@property (nonatomic, strong) NSString *contents;
/** 图文数组  */
@property (nonatomic, strong) NSArray *topicImgList;
/** 是否置顶  */
@property (nonatomic) BOOL isStick;
/** 是否精华帖 */
@property (nonatomic) BOOL isEnssence;
/** 帖子类型  */
@property (nonatomic, strong) NSString *topicType;
/** 发布日期  */
@property (nonatomic, strong) NSString *publishDate;
/** 发帖人信息 */
@property (nonatomic, strong) ZZOtherUser *userBasicInfo;
@end

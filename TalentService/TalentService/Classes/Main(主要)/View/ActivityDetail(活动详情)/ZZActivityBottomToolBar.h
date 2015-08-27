//
//  ZZActivityBottomToolBar.h
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
   ZZActivityBottomToolBarTypeSport,//点赞
    ZZActivityBottomToolBarTypeRoast//吐槽
}ZZActivityBottomToolBarType;
@class ZZActivityBottomToolBar;
@protocol ZZActivityBottomToolBarDelegate <NSObject>

- (void)bottomToolbar:(ZZActivityBottomToolBar *)bottomToolbar didSelectedButton:(ZZActivityBottomToolBarType)buttonType;

@end
@interface ZZActivityBottomToolBar : UIView

@property (nonatomic, weak) id<ZZActivityBottomToolBarDelegate> delegate;
@end

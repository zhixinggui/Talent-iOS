//
//  UIControl+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UIControl+Extension.h"
#import "ZZRunTime.h"

#ifndef uxy_cstr
// 宏定义字符串 to char, NSString
#define uxy_macro_cstr( A )                 __uxy_macro_cstr_( A )
#define __uxy_macro_cstr_( A )              #A

#define uxy_macro_string( A )               __uxy_macro_string_( A )
#define __uxy_macro_string_( A )            @#A

// 定义静态常量字符串
#define uxy_staticConstString(__string)               static const char * __string = #__string;

#endif

static NSDictionary *XY_DicControlEventString = nil;
static NSDictionary *XY_DicControlStringEvent = nil;

@implementation UIControl (Extension)
+ (void)load
{
    XY_DicControlEventString = @{@(UIControlEventTouchDown): @"UIControlEventTouchDown",
                                 @(UIControlEventTouchDownRepeat): @"UIControlEventTouchDownRepeat",
                                 @(UIControlEventTouchDragInside): @"UIControlEventTouchDragInside",
                                 @(UIControlEventTouchDragOutside): @"UIControlEventTouchDragOutside",
                                 @(UIControlEventTouchDragEnter): @"UIControlEventTouchDragEnter",
                                 @(UIControlEventTouchDragExit): @"UIControlEventTouchDragExit",
                                 @(UIControlEventTouchUpInside): @"UIControlEventTouchUpInside",
                                 @(UIControlEventTouchUpOutside): @"UIControlEventTouchUpOutside",
                                 @(UIControlEventTouchCancel): @"UIControlEventTouchCancel",
                                 @(UIControlEventValueChanged): @"UIControlEventValueChanged",
                                 @(UIControlEventEditingDidBegin): @"UIControlEventEditingDidBegin",
                                 @(UIControlEventEditingChanged): @"UIControlEventEditingChanged",
                                 @(UIControlEventEditingDidEnd): @"UIControlEventEditingDidEnd",
                                 @(UIControlEventEditingDidEndOnExit): @"UIControlEventEditingDidEndOnExit",
                                 @(UIControlEventAllTouchEvents): @"UIControlEventAllTouchEvents",
                                 @(UIControlEventAllEditingEvents): @"UIControlEventAllEditingEvents",
                                 @(UIControlEventApplicationReserved): @"UIControlEventApplicationReserved",
                                 @(UIControlEventSystemReserved): @"UIControlEventSystemReserved",
                                 @(UIControlEventAllEvents): @"UIControlEventAllEvents"
                                 };
    
    XY_DicControlStringEvent = @{@"UIControlEventTouchDown": @(UIControlEventTouchDown),
                                 @"UIControlEventTouchDownRepeat": @(UIControlEventTouchDownRepeat),
                                 @"UIControlEventTouchDragInside": @(UIControlEventTouchDragInside),
                                 @"UIControlEventTouchDragOutside": @(UIControlEventTouchDragOutside),
                                 @"UIControlEventTouchDragEnter": @(UIControlEventTouchDragEnter),
                                 @"UIControlEventTouchDragExit": @(UIControlEventTouchDragExit),
                                 @"UIControlEventTouchUpInside": @(UIControlEventTouchUpInside),
                                 @"UIControlEventTouchUpOutside": @(UIControlEventTouchUpOutside),
                                 @"UIControlEventTouchCancel": @(UIControlEventTouchCancel),
                                 @"UIControlEventValueChanged": @(UIControlEventValueChanged),
                                 @"UIControlEventEditingDidBegin": @(UIControlEventEditingDidBegin),
                                 @"UIControlEventEditingChanged": @(UIControlEventEditingChanged),
                                 @"UIControlEventEditingDidEnd": @(UIControlEventEditingDidEnd),
                                 @"UIControlEventEditingDidEndOnExit": @(UIControlEventEditingDidEndOnExit),
                                 @"UIControlEventAllTouchEvents": @(UIControlEventAllTouchEvents),
                                 @"UIControlEventAllEditingEvents": @(UIControlEventAllEditingEvents),
                                 @"UIControlEventApplicationReserved": @(UIControlEventApplicationReserved),
                                 @"UIControlEventSystemReserved": @(UIControlEventSystemReserved),
                                 @"UIControlEventAllEvents": @(UIControlEventAllEvents)
                                 };
    
    [ZZRunTime swizzleInstanceMethodWithClass:[UIControl class] originalSel:@selector(sendAction:to:forEvent:) replacementSel:@selector(__uxy_sendAction:to:forEvent:)];
}

uxy_staticConstString(UIControl_key_events)

- (void)dealloc
{
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, UIControl_key_events);
    if (opreations)
    {
        [opreations enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [self uxy_removeHandlerForEvent:[UIControl __uxy_eventWithName:key]];
        }];
        [self uxy_setAssignAssociatedObject:nil forKey:UIControl_key_events];
    }
}

- (void)uxy_handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block {
    
    NSString *methodName = [UIControl __uxy_eventName:event];
    
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, UIControl_key_events);
    
    if(opreations == nil)
    {
        opreations = [NSMutableDictionary dictionaryWithCapacity:2];
        [self uxy_setRetainAssociatedObject:opreations forKey:UIControl_key_events];
    }
    
    [opreations setObject:[block copy] forKey:methodName];
    [self addTarget:self action:NSSelectorFromString(methodName) forControlEvents:event];
}

- (void)uxy_removeHandlerForEvent:(UIControlEvents)event
{
    
    NSString *methodName = [UIControl __uxy_eventName:event];
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, UIControl_key_events);
    
    if(opreations == nil)
    {
        opreations = [NSMutableDictionary dictionaryWithCapacity:2];
        [self uxy_setRetainAssociatedObject:opreations forKey:UIControl_key_events];
    }
    
    [opreations removeObjectForKey:methodName];
    [self removeTarget:self action:NSSelectorFromString(methodName) forControlEvents:event];
}

uxy_staticConstString(UIControl_acceptEventInterval)

- (NSTimeInterval)uxy_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setUxy_acceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(uxy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - private
// todo 命名待重构
- (void)UIControlEventTouchDown{[self __uxy_callActionBlock:UIControlEventTouchDown];}
- (void)UIControlEventTouchDownRepeat{[self __uxy_callActionBlock:UIControlEventTouchDownRepeat];}
- (void)UIControlEventTouchDragInside{[self __uxy_callActionBlock:UIControlEventTouchDragInside];}
- (void)UIControlEventTouchDragOutside{[self __uxy_callActionBlock:UIControlEventTouchDragOutside];}
- (void)UIControlEventTouchDragEnter{[self __uxy_callActionBlock:UIControlEventTouchDragEnter];}
- (void)UIControlEventTouchDragExit{[self __uxy_callActionBlock:UIControlEventTouchDragExit];}
- (void)UIControlEventTouchUpInside{[self __uxy_callActionBlock:UIControlEventTouchUpInside];}
- (void)UIControlEventTouchUpOutside{[self __uxy_callActionBlock:UIControlEventTouchUpOutside];}
- (void)UIControlEventTouchCancel{[self __uxy_callActionBlock:UIControlEventTouchCancel];}
- (void)UIControlEventValueChanged{[self __uxy_callActionBlock:UIControlEventValueChanged];}
- (void)UIControlEventEditingDidBegin{[self __uxy_callActionBlock:UIControlEventEditingDidBegin];}
- (void)UIControlEventEditingChanged{[self __uxy_callActionBlock:UIControlEventEditingChanged];}
- (void)UIControlEventEditingDidEnd{[self __uxy_callActionBlock:UIControlEventEditingDidEnd];}
- (void)UIControlEventEditingDidEndOnExit{[self __uxy_callActionBlock:UIControlEventEditingDidEndOnExit];}
- (void)UIControlEventAllTouchEvents{[self __uxy_callActionBlock:UIControlEventAllTouchEvents];}
- (void)UIControlEventAllEditingEvents{[self __uxy_callActionBlock:UIControlEventAllEditingEvents];}
- (void)UIControlEventApplicationReserved{[self __uxy_callActionBlock:UIControlEventApplicationReserved];}
- (void)UIControlEventSystemReserved{[self __uxy_callActionBlock:UIControlEventSystemReserved];}
- (void)UIControlEventAllEvents{[self __uxy_callActionBlock:UIControlEventAllEvents];}


- (void)__uxy_callActionBlock:(UIControlEvents)event
{
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, UIControl_key_events);
    
    if(opreations == nil)
        return;
    
    void(^block)(id sender) = [opreations objectForKey:[UIControl __uxy_eventName:event]];
    
    if (block)
        block(self);
        
        }

+ (NSString *)__uxy_eventName:(UIControlEvents)event
{
    return [XY_DicControlEventString objectForKey:@(event)];
}

+ (UIControlEvents)__uxy_eventWithName:(NSString *)name
{
    return [[XY_DicControlStringEvent objectForKey:name] integerValue];
}

uxy_staticConstString(UIControl_acceptedEventTime)

- (NSTimeInterval)uxy_acceptedEventTime
{
    return [objc_getAssociatedObject(self, UIControl_acceptedEventTime) doubleValue];
}

- (void)setUxy_acceptedEventTime:(NSTimeInterval)uxy_acceptedEventTime
{
    objc_setAssociatedObject(self, UIControl_acceptedEventTime, @(uxy_acceptedEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)__uxy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (NSDate.date.timeIntervalSince1970 - self.uxy_acceptedEventTime < self.uxy_acceptEventInterval) return;
    
    if (self.uxy_acceptEventInterval > 0)
    {
        self.uxy_acceptedEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    [self __uxy_sendAction:action to:target forEvent:event];
}
@end

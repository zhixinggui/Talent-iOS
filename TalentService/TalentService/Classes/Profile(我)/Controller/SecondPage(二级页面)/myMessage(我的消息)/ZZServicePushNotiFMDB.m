//
//  ZZServicePushNotiFMDB.m
//  TalentService
//
//  Created by charles on 15/10/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZServicePushNotiFMDB.h"
#import "FMDB.h"
#import "ZZServiceNotiMessage.h"
static FMDatabase *_db;
@implementation ZZServicePushNotiFMDB
+ (void)initialize {
    //打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"NotificationFmdb.sqlite"];
    _db =[FMDatabase databaseWithPath:path];
    [_db open];
    
    //创建表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_NotificationFmdb (id INTEGER PRIMARY KEY , alert  TEXT, orderCode TEXT ,type INTEGER ,relationId INTEGER );"];
}

+(NSArray*)notificationWithType:(NSInteger)type {
    FMResultSet *set =  [_db executeQueryWithFormat:@"SELECT * FROM t_NotificationFmdb  WHERE type = %ld;",type];
    // 不断往下取数据
    NSMutableArray *notificationArr = [NSMutableArray array];
    while (set.next) {
        ZZServiceNotiMessage *serviceNoti = [[ZZServiceNotiMessage alloc]init];
        serviceNoti.relationId = [set longForColumn:@"relationId"];
        serviceNoti.alert = [set stringForColumn:@"alert"];
        serviceNoti.type = [set longForColumn:@"type"];
        serviceNoti.orderCode = [set stringForColumn:@"orderCode"];
        [notificationArr addObject:serviceNoti];
    }
    return notificationArr;
}

+(BOOL)deleteTable{
    return  [_db  executeUpdate:@"DROP TABLE IF  EXISTS t_NotificationFmdb"];
}

+ (void)uploadWithNotifation:(ZZServiceNotiMessage *)serviceNotiMessage {
    ZZServiceNotiMessage *serviceMessage = serviceNotiMessage;
    //if ([self selectDataWithNotifation:serviceMessage.orderCode]) {
       // [self updateNotificationMessage:serviceMessage];
    //}else {
        [self addNotificationMessage:serviceMessage];
   // }
}
//relationId来判断
+ (BOOL)selectDataWithNotifation:(NSString *)orderCode {
    return [_db boolForQuery:[NSString stringWithFormat:@"SELECT COUNT(*) FROM t_NotificationFmdb WHERE orderCode = '%@';",orderCode]];
}

+ (BOOL)addNotificationMessage:(ZZServiceNotiMessage *)serviceNotiMessage {
    return   [_db executeUpdateWithFormat:@"INSERT INTO t_NotificationFmdb(alert,orderCode,type,relationId) VALUES (%@,%@,%ld,%ld);",serviceNotiMessage.alert,serviceNotiMessage.orderCode,serviceNotiMessage.type,serviceNotiMessage.relationId];
}

+ (BOOL)updateNotificationMessage:(ZZServiceNotiMessage *)serviceNotiMessage {
    return   [_db executeUpdateWithFormat:@"UPDATE   t_NotificationFmdb  SET alert = %@,orderCode = %@,type = %ld WHERE relationId = %ld;",serviceNotiMessage.alert,serviceNotiMessage.orderCode, serviceNotiMessage.type,serviceNotiMessage.relationId];
}
@end

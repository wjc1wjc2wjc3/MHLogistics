//
//  FMDBManager.m
//  HZBitApp
//
//  Created by Apple on 9/5/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "FMDBManager.h"

NSString *const kFMDBDataBaseFileName = @"ZHBitUser.sqlite";
NSString *const kFMDBTableName = @"User";             //表名称
NSString *const kFMDBID = @"id";
NSString *const kFMDBName = @"name";                  //用户名
NSString *const kFMDBIdentity = @"identity";          //用户身份证
NSString *const kFMDBIssuance = @"issuance";          //签发时间
NSString *const kFMDBExpiration = @"expiration";      //有效期限
NSString *const kFMDBPhone = @"phone";                //电话号码
NSString *const kFMDBSid = @"sid";                    //用户sid
NSString *const kFMDBMid = @"mid";                    //用户mid

NSInteger const kMaxDataBaseCount = 100;  //数据库存储的个人信息最大数据数

@interface FMDBManager ()

@property (nonatomic, strong) NSString * dbPath;

@end



@implementation FMDBManager

+ (FMDBManager*)sharedInstance {
    static FMDBManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

+ (void)updateUID:(NSString *)userId uid:(NSString *)uid mid:(NSString *)mid {
    if (!userId || [@"" isEqualToString:userId]) {
        DLog(@"userId is invalid!");
        return;
    }
    
    FMDBManager *mgr = [FMDBManager sharedInstance];
    if (!mgr) {
        DLog(@"mgr is invalid!");
        return;
    }
    
    DLog(@"updateUID userId %@, %@, %@", userId, uid, mid);
    
    NSDictionary *dict = [mgr queryData:userId];
    if (!dict || [dict count] == 0) {
        [mgr insertData:userId identity:uid mid:mid];
        return;
    }

    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    if (uid && ![@"" isEqualToString:uid]) {
        [dictM setObject:uid forKey:kFMDBIdentity];
    }
    
    if (mid && ![@"" isEqualToString:mid]) {
        [dictM setObject:mid forKey:kFMDBMid];
    }

    if (dictM.count > 0) {
        [mgr update:userId dict:dictM];
    }

}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString * doc = PATH_OF_DOCUMENT;
        NSString * path = [doc stringByAppendingPathComponent:kFMDBDataBaseFileName];
        _dbPath = path;
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
            // create it
            FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
            if ([db open]) {
                NSString * sql = [NSString stringWithFormat:@"create table if not exists '%@' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text)", kFMDBTableName, kFMDBName, kFMDBIdentity, kFMDBIssuance, kFMDBExpiration, kFMDBPhone, kFMDBSid, kFMDBMid];
                BOOL res = [db executeUpdate:sql];
                if (!res) {
                    NSLog(@"error when creating db table");
                } else {
                    NSLog(@"succ to creating db table");
                }
  
            } else {
                NSLog(@"error when open db");
            }
            [db close];
        }
        else
        {
            [self deleteSuperfluous];
        }
    }
    return self;
}

- (void)deleteSuperfluous {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if (![db open]) {
        [db close];
        return;
    }
        
    NSString *sql = [NSString stringWithFormat:@"select COUNT(*) from %@;", kFMDBTableName];
    
    int count = [db intForQuery:sql];
    
    if (count <= kMaxDataBaseCount) {
        [db close];
        return;
    }
    
    NSString * sqlWhere = [NSString stringWithFormat:@"select * from %@", kFMDBTableName];
    FMResultSet *rs = [db executeQuery:sqlWhere];
    NSString *idx = nil;
    while ([rs next]) {
        idx = [rs stringForColumn:kFMDBID];
        break;
    }
    
    NSInteger startIdx = 0;
    if (idx != nil && [idx compare:@""] != NSOrderedSame) {
        startIdx = [idx integerValue];
    }
    
    
    NSString *sqls = [NSString stringWithFormat:@"delete from %@ where %@ <= %ld;", kFMDBTableName, kFMDBID, startIdx + (count - kMaxDataBaseCount)];
    BOOL bDelete = [db executeUpdate:sqls];
    if (bDelete) {
        DLog(@"fmdb delete success!");
    }

    [db close];
}

- (void)insertData:(NSString *)phone identity:(NSString *)uid mid:(NSString *)mid {
    if (!phone|| [@"" isEqualToString:phone]) {
        return;
    }
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    
    if (![db open]) {
        [db close];
        return;
    }
        
    BOOL bUid = uid && ![@"" isEqualToString:uid];
    BOOL bMid = mid && ![@"" isEqualToString:mid];
    NSString * sql = nil;
    BOOL res = NO;
    NSString *date = [self currentDate];
    if (bUid && bMid) {
        sql = [NSString stringWithFormat:@"insert into %@ (%@, %@, %@) values(?, ?, ?) ", kFMDBTableName, kFMDBPhone, kFMDBIdentity, kFMDBMid];
        res = [db executeUpdate:sql, phone, uid, mid, date];
    }else if (bUid) {
        sql = [NSString stringWithFormat:@"insert into %@ (%@, %@) values(?, ?) ", kFMDBTableName, kFMDBPhone, kFMDBIdentity];
        res = [db executeUpdate:sql, phone, uid, date];
    }else if (bMid) {
        sql = [NSString stringWithFormat:@"insert into %@ (%@, %@) values(?, ?) ", kFMDBTableName, kFMDBPhone, kFMDBMid];
        res = [db executeUpdate:sql, phone, mid];
    }
    
    if (!res) {
        NSLog(@"error to insert data");
    } else {
        NSLog(@"succ to insert data");
    }
    
    [db close];
    
}

- (NSString *)currentDate {
    NSTimeInterval currentDate = [[NSDate date] timeIntervalSince1970];
    currentDate = ceilf(currentDate);
    NSString *currentDateStr = [NSString stringWithFormat:@"%f", currentDate];
    return currentDateStr;
}

- (void)insertData:(NSString *)name identity:(NSString *)identity issuance:(NSString *)issuance expiration:(NSString *)expiration phone:(NSString *)phone sid:(NSString *)sid mid:(NSString *)mid {
    if (!phone|| [@"" isEqualToString:phone]) {
        return;
    }
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    
    if (![db open]) {
        [db close];
        return;
    }

    NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@, %@, %@, %@, %@, %@, %@) values(?, ?, ?, ?, ?, ?, ?) ", kFMDBTableName, kFMDBName, kFMDBIdentity, kFMDBIssuance, kFMDBExpiration, kFMDBPhone, kFMDBSid, kFMDBMid];
    BOOL res = [db executeUpdate:sql, name, identity, issuance, expiration, phone, sid, mid];
    if (!res) {
        NSLog(@"error to insert data");
    } else {
        NSLog(@"succ to insert data");
    }
    
    [db close];
}

- (void)update:(FMDatabase *)db phone:(NSString *)phone key:(NSString *)key value:(NSString *)value {
    if ([db columnExists:key inTableWithName:kFMDBTableName]) {
        NSString *update = [NSString stringWithFormat:@"update %@ set %@=? where %@ = ?",kFMDBTableName,key,kFMDBPhone];
        [db executeUpdate:update,value, phone];
    }else{
        
        NSString *sql = [NSString stringWithFormat:@"alter table %@ add %@ text", kFMDBTableName, key];
        [db executeUpdate:sql];
        
        NSString *update = [NSString stringWithFormat:@"update %@ set %@=? where %@ = ?",kFMDBTableName, key, kFMDBPhone];
        [db executeUpdate:update, value, phone];
    }
}

- (void)update:(NSString *)phone dict:(NSDictionary *)dictionary {
    if (!phone || [phone compare:@""] == NSOrderedSame) {
        return;
    }
    
    if (!dictionary || [dictionary count] == 0) {
        return;
    }
    
    FMDatabase * db = [FMDatabase databaseWithPath:_dbPath];
    if ([db open]) {
        ELockWeakSelf();
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [weakSelf update:db phone:phone key:key value:obj];
        }];
        [db close];
    }
}


- (void)update:(NSString *)phone key:(NSString *)key value:(NSString *)value  {
    if (!phone || [phone compare:@""] == NSOrderedSame) {
        return;
    }
    
    FMDatabase * db = [FMDatabase databaseWithPath:_dbPath];
    if ([db open]) {
        [self update:db phone:phone key:key value:value];
        [db close];
    }
}

- (NSString *)queryMid:(NSString *)phoneNumber {
    if (!phoneNumber || [@"" isEqualToString:phoneNumber]) {
        DLog(@"phoneNumber is invalid!");
        return @"";
    }
    
    NSMutableDictionary *result = [self queryData:kFMDBPhone value:phoneNumber];
    NSString *mid = [result objectForKey:kFMDBMid];
    if (mid) {
        DLog(@"queryMid %@", mid);
      return mid;
    }
    
    return @"";
}

- (NSDictionary *)queryData:(NSString *)phoneNumber {

    NSMutableDictionary *result = [self queryData:kFMDBPhone value:phoneNumber];
    return result;
}

- (NSMutableDictionary *)queryData:(NSString *)key value:(NSString *)value {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if (![db open]) {
        [db close];
        return nil;
    }
    
    NSString * sql = [NSString stringWithFormat:@"select * from %@", kFMDBTableName];
    sql = [sql stringByAppendingFormat:@" where %@='%@'", key, value];
    FMResultSet *rs = [db executeQuery:sql];

    //we read the the first record only if the db has one more record!
   NSMutableDictionary *resultDict = nil;
    while ([rs next]) {
        resultDict = (NSMutableDictionary *)[rs resultDictionary];
        break;
    }
    
    [db close];
    
    return resultDict;
}


- (void)deleteWidthAccount:(NSString *)account {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@ where %@ = %@",kFMDBTableName, kFMDBPhone, account];
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete db data");
        } else {
            NSLog(@"succ to delete db data");
        }
        [db close];
    }
}

- (void)clearAll {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@",kFMDBTableName];
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete db data");
        } else {
            NSLog(@"succ to delete db data");
        }
        [db close];
    }
}

@end

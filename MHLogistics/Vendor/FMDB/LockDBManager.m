//
//  LockDBManager.m
//  HZBitSmartLock
//
//  Created by Apple on 2018/6/25.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "LockDBManager.h"
#import "LockAddress.h"

NSString *const kLockDBFileName = @"AddLock.sqlite";
NSString *const kLockAddressTable = @"LockAddressTable";        //表名称，添加锁
NSString *const kLockID = @"id";
NSString *const kLockMac = @"LockMac";              //所mac
NSString *const kLockName = @"LockName";              //所名称
NSString *const kLockProvince = @"LockProvince";            //省
NSString *const kLockCity = @"LockCity";                    //市
NSString *const kLockDistrict = @"LockDistrict";            //区
NSString *const kLockCommunity = @"LockCommunity";          //社区
NSString *const kLockStreet = @"LockStreet";                //街道
NSString *const kThoroughfare = @"thoroughfare";            //巷
NSString *const kCommunityCode = @"CommunityCode";            //社区编码

NSInteger maxLockDBCount = 10;  //数据库存储的个人信息最大数据数
NSInteger showMaxLockDBCount = 5;  //数据库显示的最大个人数据信息
@interface LockDBManager ()

@property (nonatomic, strong) NSString * dbPath;
@property (nonatomic, strong) NSMutableDictionary *resultDict;

@end

@implementation LockDBManager

+ (LockDBManager *)sharedInstance {
    static LockDBManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString * doc = PATH_OF_DOCUMENT;
        NSString * path = [doc stringByAppendingPathComponent:kLockDBFileName];
        _dbPath = path;
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
            // create it
            FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
            if ([db open]) {
                NSString * sql = [NSString stringWithFormat:@"create table if not exists '%@' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text)", kLockAddressTable, kLockMac, kLockName, kLockProvince, kLockCity, kLockDistrict, kLockCommunity, kLockStreet, kThoroughfare, kCommunityCode];
                BOOL res = [db executeUpdate:sql];
                if (!res) {
                    NSLog(@"error when creating db table");
                } else {
                    NSLog(@"succ to creating db table");
                }
                [db close];
            } else {
                NSLog(@"error when open db");
            }
        }
        else
        {
            [self deleteSuperfluous];
        }
        
        _resultDict = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    return self;
}

- (void)deleteSuperfluous {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"select COUNT(*) from %@;", kLockAddressTable];
        
        int count = [db intForQuery:sql];
        
        if (count > maxLockDBCount) {
            
            NSString * sqlWhere = [NSString stringWithFormat:@"select * from %@", kLockAddressTable];
            FMResultSet *rs = [db executeQuery:sqlWhere];
            NSString *idx = nil;
            while ([rs next]) {
                idx = [rs stringForColumn:kLockID];
                break;
            }
            
            NSInteger startIdx = 0;
            if (idx != nil && [idx compare:@""] != NSOrderedSame) {
                startIdx = [idx integerValue];
            }
            
            
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ <= %ld;", kLockAddressTable, kLockID, startIdx + (count - maxLockDBCount)];
            BOOL bDelete = [db executeUpdate:sql];
            if (bDelete) {
                //
            }
        }
    }
    [db close];
}

- (void)insertData:(NSString *)name  mac:(NSString *)mac province:(NSString *)province city:(NSString *)city district:(NSString *)district community:(NSString *)community street:(NSString *)street th:(NSString *)thoroughfare code:(NSString *)communityCode{
    if (name == nil || [name compare:@""] == NSOrderedSame) {
        return;
    }
    
    [self deleteSuperfluous];
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    
    if ([db open]) {
        
        NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@, %@, %@, %@, %@, %@, %@, %@, %@) values(?, ?, ?, ?, ?, ?, ?, ?, ?)", kLockAddressTable, kLockName, kLockMac, kLockProvince, kLockCity, kLockDistrict, kLockCommunity, kLockStreet, kThoroughfare,kCommunityCode];
        BOOL res = [db executeUpdate:sql, name, mac, province, city, district, community, street, thoroughfare, communityCode];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        
        [db close];
    }
}

- (void)update:(FMDatabase *)db mac:(NSString *)mac key:(NSString *)key value:(NSString *)value {
    if ([db columnExists:key inTableWithName:kLockAddressTable]) {
        NSString *update = [NSString stringWithFormat:@"update %@ set %@=? where %@ = ?",kLockAddressTable,key,kLockMac];
        [db executeUpdate:update, mac, value];
    }else{
        
        NSString *sql = [NSString stringWithFormat:@"alter table %@ add %@ text", kLockAddressTable, key];
        [db executeUpdate:sql];
        
        NSString *update = [NSString stringWithFormat:@"update %@ set %@=? where %@ = ?",kLockAddressTable, key, kLockMac];
        [db executeUpdate:update, mac, value];
    }
}

- (void)update:(NSString *)mac key:(NSString *)key value:(NSString *)value  {
    if (!mac || [mac compare:@""] == NSOrderedSame) {
        return;
    }
    
    FMDatabase * db = [FMDatabase databaseWithPath:_dbPath];
    if ([db open]) {
        [self update:db mac:mac key:key value:value];
        [db close];
    }
}

- (NSMutableDictionary *)queryData:(NSString *)mac {
    NSMutableDictionary *dict = [_resultDict objectForKey:mac];
    if (dict && dict.count > 0) {
        return dict;
    }
    
    NSMutableDictionary *result = [self queryData:kLockMac value:mac];
    [_resultDict setValue:result forKey:mac];
    return result;
}

- (NSMutableArray *)queryALLData:(queryALLDataBlock)block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:showMaxLockDBCount];
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from %@ ORDER BY %@ DESC", kLockAddressTable, kLockID];
        FMResultSet *rs = [db executeQuery:sql];
        
        NSInteger i = 0;
        while ([rs next]) {
            
            if (i == showMaxLockDBCount) {
                break;
            }
            
            NSDictionary *dict = [rs resultDictionary];
            LockAddress *la = [[LockAddress alloc] initDictionary:dict];
            [array addObject:la];
            i++;
        }
        
        [db close];
    }
    if (block) {
        block(array);
    }
    
    return array;
}

- (NSMutableDictionary *)queryData:(NSString *)key value:(NSString *)value {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    NSMutableDictionary *resultDict = nil;
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from %@", kLockAddressTable];
        sql = [sql stringByAppendingFormat:@" where %@='%@'", key,value];
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {

            resultDict = (NSMutableDictionary *)[rs resultDictionary];
            
        }
        [db close];
    }
    
    return resultDict;
}

- (void)deleteWidthAccount:(NSString *)mac {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@ where %@ = %@",kLockAddressTable, kLockMac, mac];
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            DLog(@"error to delete db data");
        } else {
            DLog(@"succ to delete db data");
        }
        [db close];
    }
}

- (void)clearAll {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@",kLockAddressTable];
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            DLog(@"error to delete db data");
        } else {
            DLog(@"succ to delete db data");
        }
        [db close];
    }
}

- (void)dealloc {
    [_resultDict removeAllObjects];
    _resultDict = nil;
}

@end

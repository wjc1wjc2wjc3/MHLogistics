//
//  AESCryptUtils.m
//  HZBitApp
//
//  Created by Apple on 9/6/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "AESCryptUtils.h"
#import "DeviceUtils.h"
#import "LoginInfoUtils.h"
#import "GTMBase64.h"
#import "NSData+Add.h"

@implementation AESCryptUtils

+(NSString *)createToken:(NSString *)sid identity:(NSString *)identity time:(NSString *)timeStamp{
    
    if (!sid || [sid compare:@""] == NSOrderedSame
        || !identity || [identity compare:@""] == NSOrderedSame) {
        return nil;
    }
    
    //第一部分
    NSString *token = [NSString stringWithFormat:@"%@", sid];
    
    //第二部分
    NSString *mac = [DeviceUtils idfaString];
    NSString *md5Identity = [AESCryptUtils md5_32bit:identity];
    NSString *secondPart = [AESCryptUtils md5_32bit:[NSString stringWithFormat:@"%@%@%@", md5Identity, mac, timeStamp]];
    token = [token stringByAppendingString:secondPart];
    
    //第三部分
    token = [token stringByAppendingString:timeStamp];
    
    return token;
}


+ (NSString *)md5_32bit:(NSString *)input {
    
    if (!input) {
        return input;
    }
    
    const char * str = [input UTF8String];
    unsigned char md[CC_MD5_DIGEST_LENGTH];

    CC_MD5(str, (int)strlen(str), md);
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",md[i]];
    }

    return ret;
}

+ (NSString *)enCryptString:(NSString *)enString time:(NSString *)timeStamp {
    if (kUserFixKey) {
        return [AESCryptUtils enCryptString:enString time:timeStamp fixKey:YES];
    }

    NSString *key = [self createKey:timeStamp];
    return [AESCryptUtils enCryptString:enString key:key];
}

+ (NSString *)enCryptString:(NSString *)enString time:(NSString *)timeStamp fixKey:(BOOL)bFixKey {
    NSString *account = bFixKey ? @"" : [AccountUtils getAccount];
    NSString *key = [self createKey:account time:timeStamp];
    return [AESCryptUtils enCryptString:enString key:key];
}

+ (NSString *)enCryptString:(NSString *)account encrypt:(NSString *)enString time:(NSString *)timeStamp; {
    
    if (kUserFixKey) {
        return [AESCryptUtils enCryptString:enString time:timeStamp fixKey:YES];
    }

    NSString *key = [self createKey:account time:timeStamp];
    return [AESCryptUtils enCryptString:enString key:key];

}

+ (NSString *)enCryptString:(NSString *)enString key:(NSString *)key {
    
    NSData *saltKey = [NSData AESKeyForPassword:key];
    
    NSData *enStringData = [enString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [enStringData AESCryptWithOperation:kCCEncrypt key:saltKey iv:[iv dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    
    NSString *cipherTextStr = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    return cipherTextStr;
}

+ (NSString *)enCryptStringNoBase64:(NSString *)enString key:(NSString *)key {
    NSData *saltKey = [NSData AESKeyForPassword:key];
    
    NSData *enStringData = [enString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [enStringData AESCryptWithOperation:kCCEncrypt key:saltKey iv:[iv dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *hexString = [data hexString];
    return hexString;
}

+ (NSString *)desCryptStringNoBase64:(NSString *)desString key:(NSString *)key {
    NSData *saltKey = [NSData AESKeyForPassword:key];
    NSData *dataDecoded = [NSData dataWithHexString:desString];
    NSData *data = [dataDecoded AESCryptWithOperation:kCCDecrypt key:saltKey iv:[iv dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *descryData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return descryData;
}

+ (NSString *)desCryptString:(NSString *)desString time:(NSString *)timeStamp {
    
    if (kUserFixKey) {
        return [AESCryptUtils desCryptString:desString time:timeStamp fixKey:YES];
    }

    if (!desString || [desString compare:@""] == NSOrderedSame) {
        return desString;
    }
    
    NSString *key = [self createKey:timeStamp];
    return [AESCryptUtils desCryptString:desString key:key];

}

+ (NSString *)desCryptString:(NSString *)desString time:(NSString *)timeStamp fixKey:(BOOL)bFixKey {
    if (!desString || [desString compare:@""] == NSOrderedSame) {
        return desString;
    }
    
    NSString *account = bFixKey ? @"" : [AccountUtils getAccount];
    NSString *key = [self createKey:account time:timeStamp];
    return [AESCryptUtils desCryptString:desString key:key];
    
}


+ (NSString *)desCryptString:(NSString *)desString key:(NSString *)key {
    NSData *base64DataDecodeds = [GTMBase64 decodeString:desString];
//    NSData *base64DataDecodeds = [[NSData alloc] initWithBase64EncodedString:desString options:0];
    NSData *saltKey = [NSData AESKeyForPassword:key];
    
    NSData *data = [base64DataDecodeds AESCryptWithOperation:kCCDecrypt key:saltKey iv:[iv dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *descryData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return descryData;
}

+ (NSString *)createKey:(NSString *)timeStamp {
    if (!timeStamp || [timeStamp compare:@""] == NSOrderedSame) {
        return @"";
    }
    
    //现在正在登陆的账号
    NSString *now_account = [AccountUtils getAccount];
    if (now_account) {
        NSInteger loginState = [LoginInfoUtils getLoginState:now_account];
      if (loginState == online) {
          return [AESCryptUtils createKey:now_account time:timeStamp];
        }
    }
    
    return [AESCryptUtils createKey:@"" time:timeStamp];
}

/**
 token包含三部分:token = uid + verify + time  其中verify为服务端需要校验的部分,其生成规则如下:
 verify  = MD5.GetMD5Code(MD5.GetMD5Code(uid)+mac+time)
 */
+ (NSString *)createToken:(NSString *)timeStamp {
    if (kUserFixKey) {
        return nil;
    }
    
    NSString *account = [AccountUtils getAccount];
    FMDBManager *mgr = [FMDBManager sharedInstance];
    NSDictionary *resultDict = [mgr queryData:account];
    if (!resultDict || [resultDict count] == 0) {
        return nil;
    }
    
    NSString *uid = [resultDict objectForKey:kFMDBIdentity];
    if (!uid) {
        return nil;
    }
    
    NSString *uidMD5 = [AESCryptUtils md5_32bit:uid];
    NSString *mac = [DeviceUtils idfaString];
    NSString *verify = [NSString stringWithFormat:@"%@%@%@", uidMD5, mac, timeStamp];
    NSString *verifyMD5 = [AESCryptUtils md5_32bit:verify];
    NSMutableString *token = [NSMutableString stringWithFormat:@"%@%@%@", uid, verifyMD5, timeStamp];
    
    return token;
}

+ (NSString *)createKey:(NSString *)account time:(NSString *)timeStamp {
    
    NSMutableString *escryptStr = [@"" mutableCopy];
    
    if (!account || [account compare:@""] == NSOrderedSame) {
        escryptStr = [NSMutableString stringWithFormat:@"%@%@", aescrypt_secret, timeStamp];
    }
    else
    {
        //有身份证缓存
        FMDBManager *mgr = [FMDBManager sharedInstance];
        NSDictionary *resultDict = [mgr queryData:account];
        if (!resultDict || ![resultDict objectForKey:kFMDBIdentity]) {
           escryptStr = [NSMutableString stringWithFormat:@"%@%@", aescrypt_secret, timeStamp];
        }
        else
        {
            NSString *identity = [resultDict objectForKey:kFMDBIdentity];
            if (identity && [identity compare:@""] != NSOrderedSame) {
                NSString *identityMD5 = [AESCryptUtils md5_32bit:identity];
                escryptStr = [NSMutableString stringWithFormat:@"%@%@", identityMD5, timeStamp];
            }
            else
            {
                escryptStr = [NSMutableString stringWithFormat:@"%@%@", aescrypt_secret, timeStamp];
            }
        }
    }

    NSString *escryptString = [AESCryptUtils md5_32bit:escryptStr];
    NSString *subString = [escryptString substringToIndex:16];
    NSString *uppercaseSubString = [subString uppercaseString];
    return uppercaseSubString;
}


@end

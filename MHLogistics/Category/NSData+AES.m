//
//  NSData+AES.m
//  HZBitApp
//
//  Created by Apple on 9/12/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "NSData+AES.h"

const NSUInteger kAlgorithmKeySize = kCCKeySizeAES128;
const NSUInteger kPBKDFRounds = 100;

NSString *const salt = @"4BDD60B281D31F1B70EC3AAA81F282BC";
NSString *const iv = @"1269571869323221";
NSString *const aescrypt_secret= @"GM56771314";

@implementation NSData (AES)

+ (NSString *)md5_32bit:(NSString *)input {
    
    const char * str = [input UTF8String];
    unsigned char md[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (int)strlen(str), md);
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",md[i]];
    }
    
    return ret;
}

+ (NSData *)AESKeyForPassword:(NSString *)password {                  //Derive a key from a text password/passphrase
    
    NSMutableData *derivedKey = [NSMutableData dataWithLength:kAlgorithmKeySize];
    
    NSData *saltData = [salt dataUsingEncoding:NSUTF8StringEncoding];

    
    int result = CCKeyDerivationPBKDF(kCCPBKDF2,        // algorithm算法
                                      password.UTF8String,  // password密码
                                      password.length,      // passwordLength密码的长度
                                      saltData.bytes,           // salt内容
                                      saltData.length,          // saltLen长度
                                      kCCPRFHmacAlgSHA1,    // PRF
                                      kPBKDFRounds,         // rounds循环次数
                                      derivedKey.mutableBytes, // derivedKey
                                      derivedKey.length);   // derivedKeyLen derive:出自
    
    NSAssert(result == kCCSuccess,
                 @"Unable to create AES key for spassword: %d", result);
    return derivedKey;
}

- (NSData *)AESCryptWithOperation:(CCOperation)operation key:(NSData *)key iv:(NSData *)iv
{
    CCCryptorRef cryptorRef = NULL;
    CCCryptorStatus status = CCCryptorCreate(operation,
                                             kCCAlgorithmAES,
                                             kCCOptionPKCS7Padding,
                                             [key bytes],
                                             [key length],
                                             [iv bytes],
                                             &cryptorRef);
    if ( status==kCCSuccess ) {
        NSUInteger bufferSize = CCCryptorGetOutputLength(cryptorRef, [self length], true);
        NSMutableData *result = [[NSMutableData alloc] initWithLength:bufferSize];
        void *buffer = [result mutableBytes];
        NSUInteger totalLength = 0;
        size_t writtenLength = 0;
        status = CCCryptorUpdate(cryptorRef,
                                 [self bytes],
                                 [self length],
                                 buffer,
                                 bufferSize,
                                 &writtenLength);
        if ( status==kCCSuccess ) {
            totalLength += writtenLength;
            status = CCCryptorFinal(cryptorRef,
                                    buffer+writtenLength,
                                    bufferSize-writtenLength,
                                    &writtenLength);
            if ( status==kCCSuccess ) {
                totalLength += writtenLength;
                [result setLength:totalLength];
                CCCryptorRelease(cryptorRef);
                return result;
            }
        }
        CCCryptorRelease(cryptorRef);
    }
    return nil;
}


@end

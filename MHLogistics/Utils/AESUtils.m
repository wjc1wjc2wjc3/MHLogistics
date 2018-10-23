//
//  AESUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 14/11/2017.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "AESUtils.h"
#import "NSData+Add.h"

NSString *const kAESUtilsKey = @"0123456789abcdef";

#define FBENCRYPT_ALGORITHM     kCCAlgorithmAES128
#define FBENCRYPT_BLOCK_SIZE    kCCBlockSizeAES128
#define FBENCRYPT_KEY_SIZE      kCCKeySizeAES128

@implementation AESUtils


+ (NSString *)AESEncryptWithNoPadding:(NSString *)plain password:(NSString *)key {
    
    if (!plain || !key) {
        DLog(@"AESEncryptWithNoPadding data is nil");
        return nil;
    }
    
    NSData *keyData = [NSData dataWithHexString:key];
    NSData *plainData = [NSData dataWithHexString:plain];
    NSData *aesData = [AESUtils AESEncryptWithNoPaddingData:plainData password:keyData];
    
    return [aesData hexString];
}

//函数里面的打印代码不要去除，否则xcode adhoc版本时会引起加密时引起野指针的闪退
+ (NSData *)AESEncryptWithNoPaddingData:(NSData *)plainData password:(NSData *)keyData
{
    
    if(keyData == nil || (keyData.length != 16 && keyData.length != 32))
    {
        DLog(@"AESEncryptWithNoPaddingData data legnth is invalid!");
        return nil;
    }
    
    NSData *keyDataMutableCopy = [keyData mutableCopy];
    
    DLog(@"1 CCCrypt keyData %@", keyData);  //warning don't remove
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr,0,sizeof(keyPtr));
    memcpy(keyPtr, keyData.bytes, sizeof(keyPtr));
    DLog(@"2 CCCrypt keyPtr:%s, keyData:%@", keyPtr, keyData); //warning don't remove
    
    char ivPtr[kCCKeySizeAES128 + 1];
    memset(ivPtr,0,sizeof(ivPtr));
    memcpy(ivPtr, keyData.bytes, sizeof(ivPtr));
    
    NSData *data = [plainData copy];
    NSUInteger dataLength = [data length];
    NSUInteger mode = dataLength % kCCKeySizeAES128;
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    
    unsigned long newSize = dataLength;
    if(diff > 0 && mode != 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x0000;
    }
    
    size_t bufferSize = newSize + kCCKeySizeAES256;
    void *buffer = malloc(bufferSize);
    if (!buffer) {
        DLog(@" buffer is nil");
        return data;
    }
    
    memset(buffer,0,bufferSize);
    size_t numBytesCrypted = 0;
    
    DLog(@"3 CCCrypt kCCEncrypt:%d, kCCAlgorithmAES128:%d, plainData:%@, plainData:%p, keyData:%@,%p keyDataMutableCopy:%@,%p keyPtr:%s, kCCKeySizeAES128:%d, dataPtr:%s,dataPtr:%p, buffer:%s, bufferSize:%zu, numBytesCrypted:%ld", kCCEncrypt, kCCAlgorithmAES128, plainData, plainData, keyData,keyData, keyDataMutableCopy, keyDataMutableCopy, keyPtr, kCCKeySizeAES128, dataPtr, dataPtr, buffer, bufferSize, numBytesCrypted);//warning don't remove
    NSData *CCCryptKeyData = nil;
    if (keyData) {
        DLog(@"keyData != nil, %p", keyData);//warning don't remove
        CCCryptKeyData = keyData;
    }
    else if (keyDataMutableCopy) {
        DLog(@"keyDataMutableCopy != nil, %p", keyDataMutableCopy);//warning don't remove
        CCCryptKeyData = keyDataMutableCopy;
    }
    else
    {
        return plainData;
    }
    
    DLog(@"start CCCrypt");//warning don't remove
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode,
                                          keyDataMutableCopy.bytes,
                                          kCCKeySizeAES128,
                                          nil,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    DLog(@"cryptStatus %d, %zu, %s", cryptStatus, numBytesCrypted, buffer);//warning don't remove
    if (cryptStatus == kCCSuccess || cryptStatus == kCCParamError)
    {

        NSData *resultData = [[NSData alloc] initWithBytes:buffer length:numBytesCrypted];
        free(buffer);
        buffer = NULL;
//        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted freeWhenDone:NO];
        DLog(@"2 cryptStatus %d, %zu", cryptStatus, numBytesCrypted);//warning don't remove
        return resultData;
    }

    free(buffer);
    buffer = NULL;
    return nil;
}

+ (NSString *)AES128Decrypt:(NSString *)decrypt password:(NSString *)key {
    if (!decrypt || !key) {
        DLog(@"AES128Decrypt data is nil");
        return nil;
    }
    
    NSData *encryData = [NSData dataWithHexString:decrypt];
    NSData *aesKeyData = [NSData dataWithHexString:key];
    NSData *decryptData = [AESUtils AES128DecryptData:encryData password:aesKeyData];
    
    return  [decryptData hexString];
}

+ (NSData *)AES128DecryptData:(NSData *)decryptData password:(NSData *)keyData
{
    if (!decryptData || !keyData) {
        DLog(@"AES128Decrypt data is nil");
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    memcpy(keyPtr, keyData.bytes, sizeof(keyPtr));
    
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    memcpy(ivPtr, keyData.bytes, sizeof(ivPtr));
    
    NSMutableData *data = [decryptData mutableCopy];
//    NSData *data = decryptData;
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          nil,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [[NSData alloc] initWithBytes:buffer length:numBytesCrypted];
        free(buffer);
        buffer = NULL;
//        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted freeWhenDone:NO];
        return resultData;
    }
    free(buffer);
    buffer = NULL;
    return nil;
}

@end

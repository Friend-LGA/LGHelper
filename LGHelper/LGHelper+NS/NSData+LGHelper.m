//
//  NSData+LGHelper.m
//  LGHelper
//
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Grigory Lutkov <Friend.LGA@gmail.com>
//  (https://github.com/Friend-LGA/LGHelper)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "NSData+LGHelper.h"
#import "LGHelper.h"

@implementation NSData (LGHelper)

#pragma mark - MD5 hash

- (NSString *)md5Hash
{
    return [LGHelper md5HashFromData:self];
}

#pragma mark - SHA hash

- (NSString *)sha1Hash
{
    return [LGHelper sha1HashFromData:self];
}

- (NSString *)sha224Hash
{
    return [LGHelper sha224HashFromData:self];
}

- (NSString *)sha256Hash
{
    return [LGHelper sha256HashFromData:self];
}

- (NSString *)sha384Hash
{
    return [LGHelper sha384HashFromData:self];
}

- (NSString *)sha512Hash
{
    return [LGHelper sha512HashFromData:self];
}

#pragma mark - XOR Crypto

- (NSData *)xorCryptedWithKey:(NSString *)key
{
    return [LGHelper xorCryptedData:self key:key];
}

#pragma mark - AES Crypto

- (NSData *)aes128EncryptedDataWithKey:(NSString *)key
{
    return [LGHelper aes128EncryptedData:self key:key];
}

- (NSData *)aes128DecryptedDataWithKey:(NSString *)key
{
    return [LGHelper aes128DecryptedData:self key:key];
}

- (NSData *)aes192EncryptedDataWithKey:(NSString *)key
{
    return [LGHelper aes192EncryptedData:self key:key];
}

- (NSData *)aes192DecryptedDataWithKey:(NSString *)key
{
    return [LGHelper aes192DecryptedData:self key:key];
}

- (NSData *)aes256EncryptedDataWithKey:(NSString *)key
{
    return [LGHelper aes256EncryptedData:self key:key];
}

- (NSData *)aes256DecryptedDataWithKey:(NSString *)key
{
    return [LGHelper aes256DecryptedData:self key:key];
}

#pragma mark - GZIP

- (NSData *)gZippedDataWithCompressionLevel:(float)level
{
    return [LGHelper gZippedData:self compressionLevel:level];
}

- (NSData *)gZippedData
{
    return [LGHelper gZippedData:self];
}

- (NSData *)gUnZippedData
{
    return [LGHelper gUnZippedData:self];
}

@end

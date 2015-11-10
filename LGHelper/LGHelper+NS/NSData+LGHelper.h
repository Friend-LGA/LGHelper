//
//  NSData+LGHelper.h
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

#import <Foundation/Foundation.h>

@interface NSData (LGHelper)

#pragma mark - MD5 hash

- (NSString *)md5Hash;

#pragma mark - SHA hash

- (NSString *)sha1Hash;
- (NSString *)sha224Hash;
- (NSString *)sha256Hash;
- (NSString *)sha384Hash;
- (NSString *)sha512Hash;

#pragma mark - XOR Crypto

- (NSData *)xorCryptedWithKey:(NSString *)key;

#pragma mark - AES Crypto

- (NSData *)aes128EncryptedDataWithKey:(NSString *)key;
- (NSData *)aes128DecryptedDataWithKey:(NSString *)key;
- (NSData *)aes192EncryptedDataWithKey:(NSString *)key;
- (NSData *)aes192DecryptedDataWithKey:(NSString *)key;
- (NSData *)aes256EncryptedDataWithKey:(NSString *)key;
- (NSData *)aes256DecryptedDataWithKey:(NSString *)key;

#pragma mark - GZIP

- (NSData *)gZippedDataWithCompressionLevel:(float)level;
- (NSData *)gZippedData;
- (NSData *)gUnZippedData;

@end

//
//  NSString+LGHelper.m
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

#import "NSString+LGHelper.h"
#import "LGHelper.h"

@implementation NSString (LGHelper)

#pragma mark -

- (BOOL)containsString:(NSString *)string
{
    return [self rangeOfString:string].location != NSNotFound;
}

- (NSRange)range
{
    return NSMakeRange(0.f, self.length);
}

#pragma mark -

+ (NSString *)stringWithObject:(id)object
{
    if (object && ![object isKindOfClass:[NSNull class]])
    {
        NSString *string = [NSString stringWithFormat:@"%@", object];
        
        if (!string.length) string = nil;
        
        return string;
    }
    else
        return nil;
}

+ (NSString *)stringWithObjectReturnNil:(id)object
{
    return [NSString stringWithObject:object];
}

+ (NSString *)stringWithObjectReturnEmpty:(id)object
{
    if (object && ![object isKindOfClass:[NSNull class]])
    {
        NSString *string = [NSString stringWithFormat:@"%@", object];
        
        if (!string) string = @"";
        
        return string;
    }
    else
        return @"";
}

#pragma mark -

- (NSString *)stringByCapitalizingFirstLetter
{
    return [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[self substringToIndex:1].uppercaseString];
}

- (NSString *)stringByRemovingAllWhitespacesAndNewLine
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)stringByRemovingAllNumbers
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)stringByRemovingAllExeptNumbers
{
    return [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
}

- (NSString *)stringByRemovingAllExeptPhoneSymbols
{
    return [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"-1234567890"] invertedSet]] componentsJoinedByString:@""];
}

- (NSString *)stringByRemovingAllExeptSymbols:(NSString *)symbols
{
    return [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:symbols] invertedSet]] componentsJoinedByString:@""];
}

#pragma mark - MD5 hash

- (NSString *)md5Hash
{
    return [LGHelper md5HashFromString:self];
}

#pragma mark - SHA hash

- (NSString *)sha1Hash
{
    return [LGHelper sha1HashFromString:self];
}

- (NSString *)sha224Hash
{
    return [LGHelper sha224HashFromString:self];
}

- (NSString *)sha256Hash
{
    return [LGHelper sha256HashFromString:self];
}

- (NSString *)sha384Hash
{
    return [LGHelper sha384HashFromString:self];
}

- (NSString *)sha512Hash
{
    return [LGHelper sha512HashFromString:self];
}

#pragma mark - XOR Crypto

- (NSString *)xorCryptedWithKey:(NSString *)key
{
    return [LGHelper xorCryptedString:self key:key];
}

@end

//
//  UIColor+LGHelper.m
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

#import "UIColor+LGHelper.h"
#import "LGHelper.h"

@implementation UIColor (LGHelper)

#pragma mark -

/** 0-255, 0-255, 0-255, 0.f-1.f */
+ (UIColor *)colorWithRGB_red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [LGHelper colorWithRGB_red:red green:green blue:blue alpha:alpha];
}

/** #000000 */
+ (UIColor *)colorWithHEX:(UInt32)hex
{
    return [LGHelper colorWithHEX:hex];
}

#pragma mark -

/** #000000 */
- (NSUInteger)hex
{
    return [LGHelper colorHEX:self];
}

#pragma mark -

+ (UIColor *)colorMixedInRGB:(UIColor *)color1 andColor:(UIColor *)color2 percent:(CGFloat)percent
{
    return [LGHelper colorMixedInRGB:color1 andColor:color2 percent:percent];
}

+ (UIColor *)colorMixedInLAB:(UIColor *)color1 andColor:(UIColor *)color2 percent:(CGFloat)percent
{
    return [LGHelper colorMixedInLAB:color1 andColor:color2 percent:percent];
}

#pragma mark -

/** 0-255 */
- (UIColor *)darkerOnRGB:(NSUInteger)k
{
    return [LGHelper color:self darkerOnRGB:k];
}

/** 0-255 */
- (UIColor *)lighterOnRGB:(NSUInteger)k
{
    return [LGHelper color:self lighterOnRGB:k];
}

/** 0.f-1.f */
- (UIColor *)darkerOn:(CGFloat)k
{
    return [LGHelper color:self darkerOn:k];
}

/** 0.f-1.f */
- (UIColor *)lighterOn:(CGFloat)k
{
    return [LGHelper color:self lighterOn:k];
}

/** 0.f-100.f */
- (UIColor *)darkerOnPercent:(CGFloat)percent
{
    return [LGHelper color:self darkerOnPercent:percent];
}

/** 0.f-100.f */
- (UIColor *)lighterOnPercent:(CGFloat)percent
{
    return [LGHelper color:self lighterOnPercent:percent];
}

#pragma mark -

- (NSArray *)convertedRGBtoXYZ
{
    return [LGHelper colorConvertRGBtoXYZ:self];
}

- (NSArray *)convertedRGBtoLAB
{
    return [LGHelper colorConvertRGBtoLAB:self];
}

#pragma mark -

+ (NSArray *)colorConvertRGBtoXYZ:(UIColor *)color
{
    return [LGHelper colorConvertRGBtoXYZ:color];
}

+ (NSArray *)colorConvertRGBtoLAB:(UIColor *)color
{
    return [LGHelper colorConvertRGBtoLAB:color];
}

+ (NSArray *)colorConvertXYZtoLAB:(NSArray *)xyzArray
{
    return [LGHelper colorConvertXYZtoLAB:xyzArray];
}

+ (NSArray *)colorConvertLABtoXYZ:(NSArray *)labArray
{
    return [LGHelper colorConvertLABtoXYZ:labArray];
}

+ (UIColor *)colorConvertXYZtoRGB:(NSArray *)xyzArray
{
    return [LGHelper colorConvertXYZtoRGB:xyzArray];
}

+ (UIColor *)colorConvertLABtoRGB:(NSArray *)labArray
{
    return [LGHelper colorConvertLABtoRGB:labArray];
}

@end

//
//  UIColor+LGHelper.h
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

#import <UIKit/UIKit.h>

@interface UIColor (LGHelper)

/** 0-255, 0-255, 0-255, 0.f-1.f */
+ (UIColor *)colorWithRGB_red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;
/** #000000 */
+ (UIColor *)colorWithHEX:(UInt32)hex;

/** #000000 */
- (NSUInteger)hex;

+ (UIColor *)colorMixedInRGB:(UIColor *)color1 andColor:(UIColor *)color2 percent:(CGFloat)percent;
+ (UIColor *)colorMixedInLAB:(UIColor *)color1 andColor:(UIColor *)color2 percent:(CGFloat)percent;

/** 0-255 */
- (UIColor *)darkerOnRGB:(NSUInteger)k;
/** 0-255 */
- (UIColor *)lighterOnRGB:(NSUInteger)k;
/** 0.f-1.f */
- (UIColor *)darkerOn:(CGFloat)k;
/** 0.f-1.f */
- (UIColor *)lighterOn:(CGFloat)k;
/** 0.f-100.f */
- (UIColor *)darkerOnPercent:(CGFloat)percent;
/** 0.f-100.f */
- (UIColor *)lighterOnPercent:(CGFloat)percent;

- (NSArray *)convertedRGBtoXYZ;
- (NSArray *)convertedRGBtoLAB;

+ (NSArray *)colorConvertRGBtoXYZ:(UIColor *)color;
+ (NSArray *)colorConvertRGBtoLAB:(UIColor *)color;
+ (NSArray *)colorConvertXYZtoLAB:(NSArray *)xyzArray;
+ (NSArray *)colorConvertLABtoXYZ:(NSArray *)labArray;
+ (UIColor *)colorConvertXYZtoRGB:(NSArray *)xyzArray;
+ (UIColor *)colorConvertLABtoRGB:(NSArray *)labArray;

@end

//
//  UIImage+LGHelper.m
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

#import "UIImage+LGHelper.h"

@implementation UIImage (LGHelper)

- (UIImage *)imageWithOrientationExifFix
{
    return [LGHelper imageWithOrientationExifFix:self];
}

+ (UIImage *)image1x1WithColor:(UIColor *)color
{
    return [LGHelper image1x1WithColor:color];
}

- (UIImage *)imageWithAlpha:(CGFloat)alpha
{
    return [LGHelper image:self withAlpha:alpha];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    return [LGHelper image:self withColor:color];
}

- (UIImage *)imageBlackAndWhite
{
    return [LGHelper imageBlackAndWhite:self];
}

- (UIImage *)imageScaledToSize:(CGSize)size scalingMode:(LGImageScalingMode)scalingMode
{
    return [LGHelper image:self scaleToSize:size scalingMode:scalingMode];
}

- (UIImage *)imageScaledToSize:(CGSize)size scalingMode:(LGImageScalingMode)scalingMode backgroundColor:(UIColor *)backgroundColor
{
    return [LGHelper image:self scaleToSize:size scalingMode:scalingMode backgroundColor:backgroundColor];
}

- (UIImage *)imageScaledWithMultiplier:(float)multiplier
{
    return [LGHelper image:self scaleWithMultiplier:multiplier];
}

- (UIImage *)imageRoundedWithRadius:(CGFloat)radius
{
    return [LGHelper image:self roundWithRadius:radius];
}

- (UIImage *)imageRoundedWithRadius:(CGFloat)radius backgroundColor:(UIColor *)backgroundColor
{
    return [LGHelper image:self roundWithRadius:radius backgroundColor:backgroundColor];
}

- (UIImage *)imageCroppedCenterWithSize:(CGSize)size
{
    return [LGHelper image:self cropCenterWithSize:size];
}

- (UIImage *)imageCroppedCenterWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor
{
    return [LGHelper image:self cropCenterWithSize:size backgroundColor:backgroundColor];
}

- (UIImage *)imageWithMaskImage:(UIImage *)maskImage
{
    return [LGHelper image:self withMaskImage:maskImage];
}

+ (UIImage *)imageFromView:(UIView *)view inPixels:(BOOL)inPixels
{
    return [LGHelper screenshotMakeOfView:view inPixels:inPixels];
}

- (UIColor *)colorAtPixel:(CGPoint)point
{
    return [LGHelper image:self colorAtPixel:point];
}

@end

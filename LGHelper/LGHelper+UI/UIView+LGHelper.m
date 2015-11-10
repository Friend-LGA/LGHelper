//
//  UIView+LGHelper.m
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

#import "UIView+LGHelper.h"
#import "LGHelper.h"

#define kLGHelperPlusUIViewIsNotRetina [UIScreen mainScreen].scale == 1.0

@implementation UIView (LGHelper)

#pragma mark - Frame

- (void)setFrame:(CGRect)frame integral:(BOOL)integral
{
    self.frame = (integral && kLGHelperPlusUIViewIsNotRetina ? CGRectIntegral(frame) : frame);
}

#pragma mark - Origin

- (void)setOrigin:(CGPoint)origin
{
    [self setOrigin:origin integral:NO];
}

- (void)setOrigin:(CGPoint)origin integral:(BOOL)integral
{
    CGRect newFrame = self.frame;
    newFrame.origin = origin;
    self.frame = (integral && kLGHelperPlusUIViewIsNotRetina ? CGRectIntegral(newFrame) : newFrame);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

#pragma mark - Origin X

- (void)setOriginX:(CGFloat)x
{
    [self setOriginX:x integral:NO];
}

- (void)setOriginX:(CGFloat)x integral:(BOOL)integral
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = x;
    self.frame = (integral && kLGHelperPlusUIViewIsNotRetina ? CGRectIntegral(newFrame) : newFrame);
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

#pragma mark - Origin Y

- (void)setOriginY:(CGFloat)y
{
    [self setOriginY:y integral:NO];
}

- (void)setOriginY:(CGFloat)y integral:(BOOL)integral
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = y;
    self.frame = (integral && kLGHelperPlusUIViewIsNotRetina ? CGRectIntegral(newFrame) : newFrame);
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

#pragma mark - Size

- (void)setSize:(CGSize)size
{
    [self setSize:size integral:NO];
}

- (void)setSize:(CGSize)size integral:(BOOL)integral
{
    CGRect newFrame = self.frame;
    newFrame.size = size;
    self.frame = (integral && kLGHelperPlusUIViewIsNotRetina ? CGRectIntegral(newFrame) : newFrame);
}

- (CGSize)size
{
    return self.frame.size;
}

#pragma mark - Width

- (void)setWidth:(CGFloat)width
{
    [self setWidth:width integral:NO];
}

- (void)setWidth:(CGFloat)width integral:(BOOL)integral
{
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = (integral && kLGHelperPlusUIViewIsNotRetina ? CGRectIntegral(newFrame) : newFrame);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

#pragma mark - Height

- (void)setHeight:(CGFloat)height
{
    [self setHeight:height integral:NO];
}

- (void)setHeight:(CGFloat)height integral:(BOOL)integral
{
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = (integral && kLGHelperPlusUIViewIsNotRetina ? CGRectIntegral(newFrame) : newFrame);
}

- (CGFloat)height
{
    return self.frame.size.height;
}

#pragma mark - Center

- (void)setCenter:(CGPoint)center integral:(BOOL)integral
{
    self.center = center;
    if (integral && kLGHelperPlusUIViewIsNotRetina) self.frame = CGRectIntegral(self.frame);
}

#pragma mark - Center X

- (void)setCenterX:(CGFloat)centerX
{
    [self setCenterX:centerX integral:NO];
}

- (void)setCenterX:(CGFloat)centerX integral:(BOOL)integral
{
    self.center = CGPointMake(centerX, self.center.y);
    if (integral && kLGHelperPlusUIViewIsNotRetina) self.frame = CGRectIntegral(self.frame);
}

- (CGFloat)centerX
{
    return self.center.x;
}

#pragma mark - Center Y

- (void)setCenterY:(CGFloat)centerY
{
    [self setCenterY:centerY integral:NO];
}

- (void)setCenterY:(CGFloat)centerY integral:(BOOL)integral
{
    self.center = CGPointMake(self.center.x, centerY);
    if (integral && kLGHelperPlusUIViewIsNotRetina) self.frame = CGRectIntegral(self.frame);
}

- (CGFloat)centerY
{
    return self.center.y;
}

#pragma mark -

- (CGFloat)bottomY
{
    return self.frame.origin.y+self.frame.size.height;
}

- (CGFloat)rightX
{
    return self.frame.origin.x+self.frame.size.width;
}

#pragma mark -

- (void)makeIntegral
{
    self.frame = CGRectIntegral(self.frame);
}

- (void)sizeInvalidate
{
    [self sizeToFit];
    [self layoutIfNeeded];
}

- (void)setAllSubviewsHidden:(BOOL)hidden exept:(NSArray *)viewsArray
{
    if (!self.subviews.count) return;
    
    for (UIView *view in self.subviews)
        if (![viewsArray containsObject:view])
            view.hidden = hidden;
}

- (void)setAllSubviewsAlpha:(CGFloat)alpha exept:(NSArray *)viewsArray
{
    if (!self.subviews.count) return;
    
    for (UIView *view in self.subviews)
        if (![viewsArray containsObject:view])
            view.alpha = alpha;
}

#pragma mark -

- (UIView *)firstResponder
{
    return [LGHelper firstResponderInView:self];
}

@end

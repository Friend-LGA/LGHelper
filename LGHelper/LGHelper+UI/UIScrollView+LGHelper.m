//
//  UIScrollView+LGHelper.m
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

#import "UIScrollView+LGHelper.h"
#import "LGHelper.h"

@implementation UIScrollView (LGHelper)

#pragma mark - Content Size Width

- (void)setContentSizeWidth:(CGFloat)width
{
    self.contentSize = CGSizeMake(width, self.contentSize.height);
}

- (CGFloat)contentSizeWidth
{
    return self.contentSize.width;
}

#pragma mark - Content Size Width

- (void)setContentSizeHeight:(CGFloat)height
{
    self.contentSize = CGSizeMake(self.contentSize.width, height);
}

- (CGFloat)contentSizeHeight
{
    return self.contentSize.height;
}

#pragma mark - Content Inset Top

- (void)setContentInsetTop:(CGFloat)topInset
{
    UIEdgeInsets insets = self.contentInset;
    insets.top = topInset;
    self.contentInset = insets;
}

- (CGFloat)contentInsetTop
{
    return self.contentInset.top;
}

#pragma mark - Content Inset Bottom

- (void)setContentInsetBottom:(CGFloat)bottomInset
{
    UIEdgeInsets insets = self.contentInset;
    insets.bottom = bottomInset;
    self.contentInset = insets;
}

- (CGFloat)contentInsetBottom
{
    return self.contentInset.bottom;
}

#pragma mark - Content Inset Left

- (void)setContentInsetLeft:(CGFloat)leftInset
{
    UIEdgeInsets insets = self.contentInset;
    insets.left = leftInset;
    self.contentInset = insets;
}

- (CGFloat)contentInsetLeft
{
    return self.contentInset.left;
}

#pragma mark - Content Inset Right

- (void)setContentInsetRight:(CGFloat)rightInset
{
    UIEdgeInsets insets = self.contentInset;
    insets.right = rightInset;
    self.contentInset = insets;
}

- (CGFloat)contentInsetRight
{
    return self.contentInset.right;
}

#pragma mark - Content Offset X

- (void)setContentOffsetX:(CGFloat)contentOffsetX animated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.x = contentOffsetX;
    [self setContentOffset:offset animated:animated];
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX
{
    [self setContentOffsetX:contentOffsetX animated:NO];
}

- (CGFloat)contentOffsetX
{
    return self.contentOffset.x;
}

#pragma mark - Content Offset Y

- (void)setContentOffsetY:(CGFloat)contentOffsetY animated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.y = contentOffsetY;
    [self setContentOffset:offset animated:animated];
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY
{
    [self setContentOffsetY:contentOffsetY animated:NO];
}

- (CGFloat)contentOffsetY
{
    return self.contentOffset.y;
}

#pragma mark - Content And Scroll Indicator Inset Top

- (void)setContentAndScrollIndicatorInsetTop:(CGFloat)topInset
{
    [self setContentInsetTop:topInset];
    [self setScrollIndicatorInsetTop:topInset];
}

#pragma mark - Content And Scroll Indicator Inset Bottom

- (void)setContentAndScrollIndicatorInsetBottom:(CGFloat)bottomInset
{
    [self setContentInsetBottom:bottomInset];
    [self setScrollIndicatorInsetBottom:bottomInset];
}

#pragma mark - Content And Scroll Indicator Inset Left

- (void)setContentAndScrollIndicatorInsetLeft:(CGFloat)leftInset
{
    [self setContentInsetLeft:leftInset];
    [self setScrollIndicatorInsetLeft:leftInset];
}

#pragma mark - Content And Scroll Indicator Inset Right

- (void)setContentAndScrollIndicatorInsetRight:(CGFloat)rightInset
{
    [self setContentInsetRight:rightInset];
    [self setScrollIndicatorInsetRight:rightInset];
}

#pragma mark - Scroll Indicator Inset Top

- (void)setScrollIndicatorInsetTop:(CGFloat)topInset
{
    UIEdgeInsets insets = self.scrollIndicatorInsets;
    insets.top = topInset;
    self.scrollIndicatorInsets = insets;
}

- (CGFloat)scrollIndicatorInsetTop
{
    return self.scrollIndicatorInsets.top;
}

#pragma mark - Scroll Indicator Inset Bottom

- (void)setScrollIndicatorInsetBottom:(CGFloat)bottomInset
{
    UIEdgeInsets insets = self.scrollIndicatorInsets;
    insets.bottom = bottomInset;
    self.scrollIndicatorInsets = insets;
}

- (CGFloat)scrollIndicatorInsetBottom
{
    return self.scrollIndicatorInsets.bottom;
}

#pragma mark - Scroll Indicator Inset Left

- (void)setScrollIndicatorInsetLeft:(CGFloat)leftInset
{
    UIEdgeInsets insets = self.scrollIndicatorInsets;
    insets.left = leftInset;
    self.scrollIndicatorInsets = insets;
}

- (CGFloat)scrollIndicatorInsetLeft
{
    return self.scrollIndicatorInsets.left;
}

#pragma mark - Scroll Indicator Inset Right

- (void)setScrollIndicatorInsetRight:(CGFloat)rightInset
{
    UIEdgeInsets insets = self.scrollIndicatorInsets;
    insets.right = rightInset;
    self.scrollIndicatorInsets = insets;
}

- (CGFloat)scrollIndicatorInsetRight
{
    return self.scrollIndicatorInsets.right;
}

#pragma mark -

- (void)scrollRectToVisible:(CGRect)rect edgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated
{
    return [LGHelper scrollView:self scrollRectToVisible:rect edgeInsets:edgeInsets animated:animated];
}

- (void)scrollFirstResponderToVisibleAnimated:(BOOL)animated
{
    return [LGHelper scrollView:self scrollFirstResponderToVisibleAnimated:animated];
}

- (void)scrollFirstResponderToVisibleWithEdgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated
{
    return [LGHelper scrollView:self scrollFirstResponderToVisibleWithEdgeInsets:edgeInsets animated:animated];
}

@end

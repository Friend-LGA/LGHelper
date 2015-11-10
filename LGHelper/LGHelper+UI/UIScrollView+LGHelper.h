//
//  UIScrollView+LGHelper.h
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

@interface UIScrollView (LGHelper)

@property (assign, nonatomic) CGFloat contentSizeWidth;
@property (assign, nonatomic) CGFloat contentSizeHeight;
@property (assign, nonatomic) CGFloat contentInsetTop;
@property (assign, nonatomic) CGFloat contentInsetBottom;
@property (assign, nonatomic) CGFloat contentInsetLeft;
@property (assign, nonatomic) CGFloat contentInsetRight;
@property (assign, nonatomic) CGFloat contentOffsetX;
@property (assign, nonatomic) CGFloat contentOffsetY;
@property (assign, nonatomic) CGFloat scrollIndicatorInsetTop;
@property (assign, nonatomic) CGFloat scrollIndicatorInsetBottom;
@property (assign, nonatomic) CGFloat scrollIndicatorInsetLeft;
@property (assign, nonatomic) CGFloat scrollIndicatorInsetRight;

- (void)setContentSizeWidth:(CGFloat)width;
- (void)setContentSizeHeight:(CGFloat)height;

- (void)setContentInsetTop:(CGFloat)topInset;
- (void)setContentInsetBottom:(CGFloat)bottomInset;
- (void)setContentInsetLeft:(CGFloat)leftInset;
- (void)setContentInsetRight:(CGFloat)rightInset;

- (void)setContentOffsetX:(CGFloat)contentOffsetX animated:(BOOL)animated;
- (void)setContentOffsetX:(CGFloat)contentOffsetX;
- (void)setContentOffsetY:(CGFloat)contentOffsetY animated:(BOOL)animated;
- (void)setContentOffsetY:(CGFloat)contentOffsetY;

- (void)setContentAndScrollIndicatorInsetTop:(CGFloat)topInset;
- (void)setContentAndScrollIndicatorInsetBottom:(CGFloat)bottomInset;
- (void)setContentAndScrollIndicatorInsetLeft:(CGFloat)leftInset;
- (void)setContentAndScrollIndicatorInsetRight:(CGFloat)rightInset;

- (void)setScrollIndicatorInsetTop:(CGFloat)topInset;
- (void)setScrollIndicatorInsetBottom:(CGFloat)bottomInset;
- (void)setScrollIndicatorInsetLeft:(CGFloat)leftInset;
- (void)setScrollIndicatorInsetRight:(CGFloat)rightInset;

- (void)scrollRectToVisible:(CGRect)rect edgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated;
- (void)scrollFirstResponderToVisibleAnimated:(BOOL)animated;
- (void)scrollFirstResponderToVisibleWithEdgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated;

@end

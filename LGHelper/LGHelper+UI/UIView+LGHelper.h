//
//  UIView+LGHelper.h
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

@interface UIView (LGHelper)

@property (assign, nonatomic) CGSize  size;
@property (assign, nonatomic) CGPoint origin;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat originX;
@property (assign, nonatomic) CGFloat originY;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

- (void)setFrame:(CGRect)frame integral:(BOOL)integral;
- (void)setOrigin:(CGPoint)origin integral:(BOOL)integral;
- (void)setOriginX:(CGFloat)x integral:(BOOL)integral;
- (void)setOriginY:(CGFloat)y integral:(BOOL)integral;

- (void)setSize:(CGSize)size integral:(BOOL)integral;
- (void)setWidth:(CGFloat)width integral:(BOOL)integral;
- (void)setHeight:(CGFloat)height integral:(BOOL)integral;

- (void)setCenter:(CGPoint)center integral:(BOOL)integral;
- (void)setCenterX:(CGFloat)centerX integral:(BOOL)integral;
- (void)setCenterY:(CGFloat)centerY integral:(BOOL)integral;

- (CGFloat)bottomY;
- (CGFloat)rightX;

- (void)makeIntegral;
- (void)sizeInvalidate;

- (void)setAllSubviewsHidden:(BOOL)hidden exept:(NSArray *)viewsArray;
- (void)setAllSubviewsAlpha:(CGFloat)alpha exept:(NSArray *)viewsArray;

- (UIView *)firstResponder;

@end

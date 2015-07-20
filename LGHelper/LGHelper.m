//
//  LGHelper.m
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

#import "LGHelper.h"

/** Need to determine device platform & processor cores */
#import <sys/utsname.h>

/** Need to determine processor cores */
#include <mach/mach_host.h>

/** Need for MD5 & SHA1 hash */
#import <CommonCrypto/CommonDigest.h>

/** Need to determine IP address */
#include <ifaddrs.h>
#include <arpa/inet.h>

/** Need to determine MIME types */
@import MobileCoreServices;

@import EventKit;
@import AddressBook;

static NSUInteger const kActionSheetTagImagePicker = 1;

@interface LGHelper () <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentInteractionControllerDelegate>

@property (assign, nonatomic) UIViewController *emailViewController;
@property (assign, nonatomic) BOOL emailAnimated;
@property (strong, nonatomic) void (^emailDismissCompletionHandler)();
@property (strong, nonatomic) void (^emailCompletionHandler)(MFMailComposeResult result, NSError *error);

@property (assign, nonatomic) UIViewController *smsViewController;
@property (assign, nonatomic) BOOL smsAnimated;
@property (strong, nonatomic) void (^smsDismissCompletionHandler)();
@property (strong, nonatomic) void (^smsCompletionHandler)(MessageComposeResult result);

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (assign, nonatomic) UIViewController *imagePickerParentViewController;
@property (assign, nonatomic) BOOL imagePickerAnimated;
@property (strong, nonatomic) void (^imagePickerSetupHandler)(UIImagePickerController *imagePickerController);
@property (strong, nonatomic) void (^imagePickerPresentCompletionHandler)();
@property (strong, nonatomic) void (^imagePickerCompletionHandler)(UIImage *image);
@property (strong, nonatomic) void (^imagePickerDismissCompletionHandler)();
@property (assign, nonatomic) id<UINavigationControllerDelegate, UIImagePickerControllerDelegate> imagePickerDelegate;

@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;
@property (assign, nonatomic) UIViewController *documentInteractionParentViewController;
@property (assign, nonatomic) BOOL documentInteractionAnimated;
@property (strong, nonatomic) void (^documentInteractionDidEndPreviewHandler)();
@property (assign, nonatomic) id<UIDocumentInteractionControllerDelegate> documentInteractionDelegate;

@end

@implementation LGHelper

+ (instancetype)sharedHelper
{
    static dispatch_once_t once;
    static id sharedManager;
    
    dispatch_once(&once, ^(void)
                  {
                      sharedManager = [super new];
                  });
    
    return sharedManager;
}

#pragma mark - Device

+ (NSString *)devicePlatform
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    return platform;
}

+ (NSString *)deviceName
{
    NSString *platform = [LGHelper devicePlatform];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (UK+Europe+Asia+China)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (UK+Europe+Asia+China)";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (GSM+CDMA)";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

#pragma mark - UIView

+ (UIView *)superviewForView:(UIView *)view withClass:(Class)superViewClass
{
    UIView *superView = view.superview;
    UIView *foundSuperView = nil;
    
    while (nil != superView && nil == foundSuperView)
    {
        if ([superView isKindOfClass:superViewClass]) foundSuperView = superView;
        else superView = superView.superview;
    }
    
    return foundSuperView;
}

+ (UIView *)firstResponderInView:(UIView *)view
{
    if (!view.subviews.count) return nil;
    
    UIView *firstResponderView = nil;
    
    for (UIView *subview in view.subviews)
    {
        if (subview.canBecomeFirstResponder && subview.isFirstResponder)
            firstResponderView = subview;
        else
            firstResponderView = [LGHelper firstResponderInView:subview];
        
        if (firstResponderView) break;
    }
    
    return firstResponderView;
}

#pragma mark - UIScrollView

+ (void)scrollView:(UIScrollView *)scrollView scrollRectToVisible:(CGRect)rect edgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated
{
    rect.origin.x -= edgeInsets.left;
    rect.origin.y -= edgeInsets.top;
    rect.size.width += (edgeInsets.left+edgeInsets.right);
    rect.size.height += (edgeInsets.top+edgeInsets.bottom);
    
    [scrollView scrollRectToVisible:rect animated:animated];
}

+ (void)scrollView:(UIScrollView *)scrollView scrollFirstResponderToVisibleAnimated:(BOOL)animated
{
    UIView *firstResponderView = [LGHelper firstResponderInView:scrollView];
    if (!firstResponderView) return;
    
    [scrollView scrollRectToVisible:firstResponderView.frame animated:animated];
}

+ (void)scrollView:(UIScrollView *)scrollView scrollFirstResponderToVisibleWithEdgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated
{
    UIView *firstResponderView = [LGHelper firstResponderInView:scrollView];
    if (!firstResponderView) return;
    
    [LGHelper scrollView:scrollView scrollRectToVisible:firstResponderView.frame edgeInsets:edgeInsets animated:animated];
}

+ (void)scrollView:(UIScrollView *)scrollView focusOnView:(UIView *)view bottomShift:(CGFloat)bottomShift
{
    CGRect viewRect = CGRectMake(0.f, 0.f, view.frame.size.width, view.frame.size.height);
    if ([view isKindOfClass:[UITextView class]])
    {
        UITextView *textView = (UITextView *)view;
        
        viewRect = [textView caretRectForPosition:textView.selectedTextRange.start];
    }
    else if ([view isKindOfClass:[UITextField class]])
    {
        UITextField *textField = (UITextField *)view;
        
        viewRect = [textField caretRectForPosition:textField.selectedTextRange.start];
    }
    
    // if the control is a deep in the hierarchy below the scroll view, this will calculate the frame as if it were a direct subview
    CGRect controlFrameInScrollView = [scrollView convertRect:viewRect fromView:view];
    
    // replace bottomShift with any nice visual offset between control and keyboard or control and top of the scroll view.
    controlFrameInScrollView.size.height += bottomShift;
    
    CGFloat controlVisualOffsetToTopOfScrollView = controlFrameInScrollView.origin.y - scrollView.contentOffset.y;
    CGFloat controlVisualBottom = controlVisualOffsetToTopOfScrollView + controlFrameInScrollView.size.height;
    
    // this is the visible part of the scroll view
    CGFloat scrollViewVisibleHeight = scrollView.frame.size.height - scrollView.contentInset.bottom;
    
    if (controlVisualBottom > scrollViewVisibleHeight)
    {
        // check if the keyboard will hide the control in question
        // scroll up until the control is in place
        CGPoint newContentOffset = scrollView.contentOffset;
        newContentOffset.y += (controlVisualBottom - scrollViewVisibleHeight);
        
        // make sure we don't set an impossible offset caused by the "nice visual offset"
        // if a control is at the bottom of the scroll view, it will end up just above the keyboard to eliminate scrolling inconsistencies
        newContentOffset.y = MIN(newContentOffset.y, scrollView.contentSize.height - scrollViewVisibleHeight);
        
        [scrollView setContentOffset:newContentOffset animated:NO]; // animated:NO because we have created our own animation context around this code
    }
    else if (controlFrameInScrollView.origin.y < scrollView.contentOffset.y)
    {
        // if the control is not fully visible, make it so (useful if the user taps on a partially visible input field
        CGPoint newContentOffset = scrollView.contentOffset;
        newContentOffset.y = controlFrameInScrollView.origin.y;
        
        // animated:NO because we have created our own animation context around this code
        [scrollView setContentOffset:newContentOffset animated:NO];
    }
}

+ (void)scrollViewKillScroll:(UIScrollView *)scrollView
{
    scrollView.scrollEnabled = NO;
    scrollView.scrollEnabled = YES;
}

#pragma mark - Images

+ (UIImage *)imageWithOrientationExifFix:(UIImage *)image
{
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation)
    {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0.f);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0.f, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0.f);
            transform = CGAffineTransformScale(transform, -1.f, 1.f);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0.f);
            transform = CGAffineTransformScale(transform, -1.f, 1.f);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL,
                                             image.size.width,
                                             image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0.f,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0.f, 0.f, image.size.height, image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0.f, 0.f, image.size.width, image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)image1x1WithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.f, 0.f, 1.f, 1.f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)image:(UIImage *)image withAlpha:(CGFloat)alpha
{
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextScaleCTM(context, 1.f, -1.f);
    CGContextTranslateCTM(context, 0.f, -rect.size.height);
    
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextSetAlpha(context, alpha);
    
    CGContextDrawImage(context, rect, image.CGImage);
    
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageNew;
}

+ (UIImage *)image:(UIImage *)image withColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [image drawInRect:rect];
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageNew;
}

+ (UIImage *)imageBlackAndWhite:(UIImage *)image
{
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [image drawInRect:rect];
    
    CGContextSetBlendMode(context, kCGBlendModeLuminosity);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageNew;
}

+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size scalingMode:(LGImageScalingMode)scalingMode
{
    return [LGHelper image:image scaleToSize:size scalingMode:scalingMode backgroundColor:nil];
}

+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size scalingMode:(LGImageScalingMode)scalingMode backgroundColor:(UIColor *)backgroundColor
{
    if (scalingMode == LGImageScalingModeAspectFit)
    {
        CGFloat koefWidth = (image.size.height > image.size.width ? image.size.width/image.size.height : 1.f);
        CGFloat koefHeight = (image.size.width > image.size.height ? image.size.height/image.size.width : 1.f);
        
        size.width *= koefWidth;
        size.height *= koefHeight;
    }
    
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (backgroundColor && ![backgroundColor isEqual:[UIColor clearColor]])
    {
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, rect);
    }
    
    if (scalingMode == LGImageScalingModeAspectFill)
    {
        if (image.size.width / image.size.height >= 1 && image.size.width / image.size.height > size.width / size.height)
            size.width = size.height * (image.size.width / image.size.height);
        else if (image.size.height / image.size.width >= 1 && image.size.height / image.size.width > size.height / size.width)
            size.height = size.width * (image.size.height / image.size.width);
        
        if (rect.size.width < size.width)
        {
            rect.origin.x = -(size.width - rect.size.width)/2;
            rect.size.width = size.width;
        }
        
        if (rect.size.height < size.height)
        {
            rect.origin.y = -(size.height - rect.size.height)/2;
            rect.size.height = size.height;
        }
    }
    else if (scalingMode == LGImageScalingModeAspectFit)
    {
        if (image.size.width / image.size.height <= 1 && image.size.width / image.size.height < size.width / size.height)
            size.width = size.height * (image.size.width / image.size.height);
        else if (image.size.height / image.size.width <= 1 && image.size.height / image.size.width < size.height / size.width)
            size.height = size.width * (image.size.height / image.size.width);
        
        if (rect.size.width > size.width)
        {
            rect.origin.x = (rect.size.width - size.width)/2;
            rect.size.width = size.width;
        }
        
        if (rect.size.height > size.height)
        {
            rect.origin.y = (rect.size.height - size.height)/2;
            rect.size.height = size.height;
        }
    }
    
    [image drawInRect:rect];
    
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageNew;
}

+ (UIImage *)image:(UIImage *)image scaleWithMultiplier:(float)multiplier
{
    CGSize size = CGSizeMake(image.size.width*multiplier, image.size.height*multiplier);
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.f);
    
    [image drawInRect:rect];
    
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageNew;
}

+ (UIImage *)image:(UIImage *)image roundWithRadius:(CGFloat)radius
{
    return [LGHelper image:image roundWithRadius:radius backgroundColor:nil];
}

+ (UIImage *)image:(UIImage *)image roundWithRadius:(CGFloat)radius backgroundColor:(UIColor *)backgroundColor
{
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (backgroundColor && ![backgroundColor isEqual:[UIColor clearColor]])
    {
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, rect);
    }
    
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    
    [image drawInRect:rect];
    
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageNew;
}

+ (UIImage *)image:(UIImage *)image cropCenterWithSize:(CGSize)size
{
    return [LGHelper image:image cropCenterWithSize:size backgroundColor:nil];
}

+ (UIImage *)image:(UIImage *)image cropCenterWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor
{
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (backgroundColor && ![backgroundColor isEqual:[UIColor clearColor]])
    {
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, rect);
    }
    
    int heightDifference = size.height-image.size.height;
    int widthDifference = size.width-image.size.width;
    
    CGRect bounds = CGRectMake(widthDifference/2, heightDifference/2, image.size.width, image.size.height);
    
    [image drawInRect:bounds];
    
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageNew;
}

+ (UIImage *)image:(UIImage *)image withMaskImage:(UIImage *)maskImage
{
    CGImageRef imageReference = image.CGImage;
    CGImageRef maskImageReference = maskImage.CGImage;
    
    maskImageReference = CGImageMaskCreate(CGImageGetWidth(maskImageReference),
                                           CGImageGetHeight(maskImageReference),
                                           CGImageGetBitsPerComponent(maskImageReference),
                                           CGImageGetBitsPerPixel(maskImageReference),
                                           CGImageGetBytesPerRow(maskImageReference),
                                           CGImageGetDataProvider(maskImageReference),
                                           NULL,
                                           YES);
    
    CGImageRef maskedImageReference = CGImageCreateWithMask(imageReference, maskImageReference);
    CGImageRelease(maskImageReference);
    
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedImageReference];
    CGImageRelease(maskedImageReference);
    
    return maskedImage;
}

+ (UIImage *)imageFromView:(UIView *)view
{
    return [LGHelper imageFromView:view inPixels:NO];
}

+ (UIImage *)imageFromView:(UIView *)view inPixels:(BOOL)inPixels
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, (inPixels ? 1.f : 0.f));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return capturedImage;
}

+ (UIColor *)image:(UIImage *)image colorAtPixel:(CGPoint)point
{
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), point))
        return nil;
    
    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = image.CGImage;
    NSUInteger width = image.size.width;
    NSUInteger height = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (BOOL)maskAlphaImage:(UIImage *)maskImage pointIsCorrect:(CGPoint)point
{
    UIColor *pixelColor = [LGHelper image:maskImage colorAtPixel:point];
    CGFloat alpha = 0.0;
    
    [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    
    return alpha > 0.f;
}

+ (BOOL)maskAlphaImage:(UIImage *)maskImage pointIsCorrect:(CGPoint)point containerSize:(CGSize)containerSize
{
    CGSize imageSize = maskImage.size;
    
    point.x *= (containerSize.width != 0) ? (imageSize.width / containerSize.width) : 1;
    point.y *= (containerSize.height != 0) ? (imageSize.height / containerSize.height) : 1;
    
    UIColor *pixelColor = [LGHelper image:maskImage colorAtPixel:point];
    CGFloat alpha = 0.0;
    
    [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    
    return alpha > 0.f;
}

+ (BOOL)maskBlackAndWhiteImage:(UIImage *)maskImage pointIsCorrect:(CGPoint)point
{
    UIColor *pixelColor = [LGHelper image:maskImage colorAtPixel:point];
    
    return ![pixelColor isEqual:[UIColor blackColor]];
}

+ (BOOL)maskBlackAndWhiteImage:(UIImage *)maskImage pointIsCorrect:(CGPoint)point containerSize:(CGSize)containerSize
{
    CGSize imageSize = maskImage.size;
    
    point.x *= (containerSize.width != 0) ? (imageSize.width / containerSize.width) : 1;
    point.y *= (containerSize.height != 0) ? (imageSize.height / containerSize.height) : 1;
    
    UIColor *pixelColor = [LGHelper image:maskImage colorAtPixel:point];
    
    return ![pixelColor isEqual:[UIColor blackColor]];
}

#pragma mark - Network Activity Indicator

+ (void)networkActivityIndicatorSetHidden:(BOOL)hidden
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = !hidden;
}

#pragma mark - NSUserDefaults clear storage

+ (void)userDefaultsClear
{
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}

#pragma mark - Screenshot

+ (UIImage *)screenshotMakeInPixels:(BOOL)inPixels
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    UIGraphicsBeginImageContextWithOptions(window.frame.size, NO, (inPixels ? 1.f : 0.f));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [window.layer renderInContext:context];
    
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return capturedImage;
}

+ (UIImage *)screenshotMakeOfView:(UIView *)view inPixels:(BOOL)inPixels
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, (inPixels ? 1.f : 0.f));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return capturedImage;
}

#pragma mark - Reachability

+ (Reachability *)reachabilityAddObserver:(id)target selector:(SEL)selector
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:kReachabilityChangedNotification object:reachability];
    
    return reachability;
}

+ (Reachability *)reachabilityForHostName:(NSString *)hostName addObserver:(id)target selector:(SEL)selector
{
    Reachability *reachability = [Reachability reachabilityWithHostName:hostName];
    [reachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:kReachabilityChangedNotification object:reachability];
    
    return reachability;
}

+ (void)reachability:(Reachability *)reachability removeObserver:(id)target
{
    [reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:target name:kReachabilityChangedNotification object:reachability];
}

+ (NetworkStatus)reachabilityStatus
{
    return [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
}

+ (NetworkStatus)reachabilityStatusForHostName:(NSString *)hostName
{
    return [[Reachability reachabilityWithHostName:hostName] currentReachabilityStatus];
}

#pragma mark - Keyboard Notifications

+ (void)keyboardNotificationsAddToTarget:(id)target selector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:UIKeyboardWillHideNotification object:nil];
}

+ (void)keyboardNotificationsRemoveFromTarget:(id)target selector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] removeObserver:target name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:target name:UIKeyboardWillHideNotification object:nil];
}

+ (void)keyboardAnimateWithNotificationUserInfo:(NSDictionary *)notificationUserInfo animations:(void(^)(CGFloat keyboardHeight))animations
{
    CGFloat keyboardHeight = (notificationUserInfo[@"UIKeyboardBoundsUserInfoKey"] ? [notificationUserInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height : 0.f);
    if (!keyboardHeight)
        keyboardHeight = (notificationUserInfo[UIKeyboardFrameBeginUserInfoKey] ? [notificationUserInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height : 0.f);
    if (!keyboardHeight)
        keyboardHeight = (notificationUserInfo[UIKeyboardFrameEndUserInfoKey] ? [notificationUserInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height : 0.f);
    if (!keyboardHeight)
        return;
    
    NSTimeInterval animationDuration = [notificationUserInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    int animationCurve = [notificationUserInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    if (animations) animations(keyboardHeight);
    
    [UIView commitAnimations];
}

#pragma mark - Disk capacity

+ (uint64_t)diskGetFreeSpace
{
    uint64_t totalSpace = 0.0f;
    uint64_t totalFreeSpace = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        
        totalSpace = [fileSystemSizeInBytes floatValue];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
        
        NSLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
    }
    else
    {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return totalFreeSpace;
}

#pragma mark - MIME Type

+ (NSString *)mimeTypeForPath:(NSString *)path
{
    NSString *mimeTypeString;
    
    if (path.length && path.pathExtension.length)
        mimeTypeString = [LGHelper mimeTypeForExtension:path.pathExtension];
    
    return mimeTypeString;
}

+ (NSString *)mimeTypeForExtension:(NSString *)extension
{
    NSString *mimeTypeString;
    
    if (extension.length)
    {
        CFStringRef extension_ = (__bridge CFStringRef)extension;
        CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension_, NULL);
        assert(UTI != NULL);
        
        NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
        assert(mimetype != NULL);
        
        CFRelease(UTI);
        
        mimeTypeString = mimetype;
    }
    
    return mimeTypeString;
}

#pragma mark - IP address

+ (NSString *)ipAddressLocal
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Get NSString from C String
                address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

+ (NSString *)ipAddressGlobal
{
    NSUInteger an_Integer;
    NSArray *ipItemsArray;
    NSString *externalIP;
    
    NSURL *ipUrl = [NSURL URLWithString:@"http://www.dyndns.org/cgi-bin/check_ip.cgi"];
    
    if (ipUrl)
    {
        NSError *error = nil;
        NSString *theIpHtml = [NSString stringWithContentsOfURL:ipUrl encoding:NSUTF8StringEncoding error:&error];
        
        if (!error)
        {
            NSScanner *theScanner;
            NSString *text = nil;
            
            theScanner = [NSScanner scannerWithString:theIpHtml];
            
            while ([theScanner isAtEnd] == NO)
            {
                // find start of tag
                [theScanner scanUpToString:@"<" intoString:NULL] ;
                
                // find end of tag
                [theScanner scanUpToString:@">" intoString:&text] ;
                
                // replace the found tag with a space
                //(you can filter multi-spaces out later if you wish)
                theIpHtml = [theIpHtml stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
                                                                 withString:@" "];
                ipItemsArray = [theIpHtml  componentsSeparatedByString:@" "];
                an_Integer = [ipItemsArray indexOfObject:@"Address:"];
                externalIP =[ipItemsArray objectAtIndex:  ++an_Integer];
            }
        }
        else NSLog(@"%s Error: %@", __PRETTY_FUNCTION__, error);
    }
    
    return externalIP;
}

#pragma mark - MD5 hash

+ (NSString *)md5HashFromData:(NSData *)data
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14],
            result[15]];
}

+ (NSString *)md5HashFromString:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14],
            result[15]];
}

#pragma mark - SHA1 hash

+ (NSString *)sha1HashFromData:(NSData *)data
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14],
            result[15], result[16], result[17], result[18], result[19]];
}

+ (NSString *)sha1HashFromString:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14],
            result[15], result[16], result[17], result[18], result[19]];
}

#pragma mark - Open URL's

+ (void)urlOpenInSafari:(NSURL *)url
{
    [[UIApplication sharedApplication] openURL:url];
}

+ (void)phoneCallToNumber:(NSString *)number
{
    NSString *newString = [LGHelper stringByRemovingAllExeptPhoneSymbols:number];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", newString]]];
}

+ (void)phoneCallWithConfirmationToNumber:(NSString *)number
{
    NSString *newString = [LGHelper stringByRemovingAllExeptPhoneSymbols:number];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", newString]]];
}

+ (void)emailSendToAddress:(NSString *)address
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", address]]];
}

#pragma mark - Locations

+ (void)addressOpenOnMap:(NSString *)address
{
    Class mapItemClass = [MKMapItem class];
    
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        CLGeocoder *geocoder = [CLGeocoder new];
        
        [geocoder geocodeAddressString:address
                     completionHandler:^(NSArray *placemarks, NSError *error)
         {
             // Convert the CLPlacemark to an MKPlacemark
             // Note: There's no error checking for a failed geocode
             CLPlacemark *geocodedPlacemark = [placemarks objectAtIndex:0];
             
             MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:geocodedPlacemark.location.coordinate
                                                            addressDictionary:geocodedPlacemark.addressDictionary];
             
             // Create a map item for the geocoded address to pass to Maps app
             MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
             [mapItem setName:geocodedPlacemark.name];
             
             [mapItem openInMapsWithLaunchOptions:nil];
         }];
    }
}

+ (void)addressOpenOnMapWithTrack:(NSString *)address
{
    Class mapItemClass = [MKMapItem class];
    
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        CLGeocoder *geocoder = [CLGeocoder new];
        
        [geocoder geocodeAddressString:address
                     completionHandler:^(NSArray *placemarks, NSError *error)
         {
             // Convert the CLPlacemark to an MKPlacemark
             // Note: There's no error checking for a failed geocode
             CLPlacemark *geocodedPlacemark = [placemarks objectAtIndex:0];
             
             MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:geocodedPlacemark.location.coordinate
                                                            addressDictionary:geocodedPlacemark.addressDictionary];
             
             // Create a map item for the geocoded address to pass to Maps app
             MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
             
             [mapItem setName:geocodedPlacemark.name];
             
             // Set the directions mode to "Driving"
             // Can use MKLaunchOptionsDirectionsModeWalking instead
             NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
             
             // Get the "Current User Location" MKMapItem
             MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
             
             // Pass the current location and destination map items to the Maps app
             // Set the direction mode in the launchOptions dictionary
             [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
         }];
    }
}

+ (void)coordinateOpenOnMap:(CLLocationCoordinate2D)coordinate
{
    Class mapItemClass = [MKMapItem class];
    
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        [mapItem setName:@"My Place"];
        
        [mapItem openInMapsWithLaunchOptions:nil];
    }
}

+ (void)coordinateOpenOnMapTrack:(CLLocationCoordinate2D)coordinate
{
    Class mapItemClass = [MKMapItem class];
    
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        [mapItem setName:@"My Place"];
        
        // Set the directions mode to "Walking"
        // Can use MKLaunchOptionsDirectionsModeDriving instead
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
        
        // Get the "Current User Location" MKMapItem
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        
        // Pass the current location and destination map items to the Maps app
        // Set the direction mode in the launchOptions dictionary
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}

#pragma mark - Calendar

+ (void)calendarAddEventWithTitle:(NSString *)title
                        startDate:(NSDate *)startDate
                         duration:(NSTimeInterval)duration
                completionHandler:(void(^)(BOOL accessGranted, NSString *identifier))completionHandler
{
    EKEventStore *store = [EKEventStore new];
    
    [store requestAccessToEntityType:EKEntityTypeEvent
                          completion:^(BOOL granted, NSError *error)
     {
         if (!granted || error)
         {
             dispatch_async_main_safe(^(void)
                                      {
                                          if (completionHandler) completionHandler(granted, nil);
                                      });
             return;
         }
         
         // -----
         
         NSDate *endDate = [startDate dateByAddingTimeInterval:duration];
         
         EKCalendar *calendar = [store defaultCalendarForNewEvents];
         
         NSPredicate *predicate = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:@[calendar]];
         
         NSArray *matchesEvents = [store eventsMatchingPredicate:predicate];
         
         EKEvent *mathesEvent = nil;
         
         for (EKEvent *event in matchesEvents)
         {
             if ([event.title isEqualToString:title])
                 mathesEvent = event;
         }
         
         // -----
         
         if (!mathesEvent)
         {
             EKEvent *event = [EKEvent eventWithEventStore:store];
             event.title = title;
             event.startDate = startDate;
             event.endDate = endDate;
             event.calendar = calendar;
             NSError *err = nil;
             [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
             
             dispatch_async_main_safe(^(void)
                                      {
                                          if (completionHandler) completionHandler(granted, event.eventIdentifier);
                                      });
         }
         else
         {
             dispatch_async_main_safe(^(void)
                                      {
                                          if (completionHandler) completionHandler(granted, mathesEvent.eventIdentifier);
                                      });
         }
     }];
}

+ (void)calendarRemoveEventWithId:(NSString *)identifier
                completionHandler:(void(^)(BOOL accessGranted))completionHandler
{
    EKEventStore *store = [EKEventStore new];
    
    [store requestAccessToEntityType:EKEntityTypeEvent
                          completion:^(BOOL granted, NSError *error)
     {
         if (!granted || error)
         {
             dispatch_async_main_safe(^(void)
                                      {
                                          if (completionHandler) completionHandler(granted);
                                      });
             return;
         }
         
         EKEvent *eventToRemove = [store eventWithIdentifier:identifier];
         
         if (eventToRemove)
         {
             NSError* err = nil;
             [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&err];
         }
         
         dispatch_async_main_safe(^(void)
                                  {
                                      if (completionHandler) completionHandler(granted);
                                  });
     }];
}

+ (void)calendarRemoveEventWithTitle:(NSString *)title
                           startDate:(NSDate *)startDate
                            duration:(NSTimeInterval)duration
                   completionHandler:(void(^)(BOOL accessGranted))completionHandler
{
    EKEventStore *store = [EKEventStore new];
    
    [store requestAccessToEntityType:EKEntityTypeEvent
                          completion:^(BOOL granted, NSError *error)
     {
         if (!granted || error)
         {
             dispatch_async_main_safe(^(void)
                                      {
                                          if (completionHandler) completionHandler(granted);
                                      });
             return;
         }
         
         // -----
         
         NSDate *endDate = [startDate dateByAddingTimeInterval:duration];
         
         EKCalendar *calendar = [store defaultCalendarForNewEvents];
         
         NSPredicate *predicate = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:@[calendar]];
         
         NSArray *matchesEvents = [store eventsMatchingPredicate:predicate];
         
         EKEvent *mathesEvent = nil;
         
         for (EKEvent *event in matchesEvents)
         {
             if ([event.title isEqualToString:title])
                 mathesEvent = event;
         }
         
         // -----
         
         if (mathesEvent)
         {
             NSError* err = nil;
             [store removeEvent:mathesEvent span:EKSpanThisEvent commit:YES error:&err];
         }
         
         dispatch_async_main_safe(^(void)
                                  {
                                      if (completionHandler) completionHandler(granted);
                                  });
     }];
}

#pragma mark - Address Book

+ (void)addressBookAddContactWithImage:(UIImage *)image
                             firstName:(NSString *)firstName
                              lastName:(NSString *)lastName
                            middleName:(NSString *)middleName
                              nickname:(NSString *)nickname
                          organization:(NSString *)organization
                              jobTitle:(NSString *)jobTitle
                            department:(NSString *)department
                              birthday:(NSDate *)birthday
                          phonesMobile:(NSArray *)phonesMobile
                            phonesHome:(NSArray *)phonesHome
                                 email:(NSString *)email
                                  site:(NSString *)site
                               country:(NSString *)country
                                region:(NSString *)region
                                  city:(NSString *)city
                                street:(NSString *)street
                                   zip:(NSString *)zip
                                  note:(NSString *)note
                     completionHandler:(void(^)(BOOL accessGranted, NSString *identifier))completionHandler
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL); // create address book record
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                             {
                                                 if (!granted || error)
                                                 {
                                                     dispatch_async_main_safe(^(void)
                                                                              {
                                                                                  if (completionHandler) completionHandler(granted, nil);
                                                                              });
                                                     return;
                                                 }
                                                 
                                                 // -----
                                                 
                                                 ABRecordRef person = ABPersonCreate(); // create a person
                                                 
                                                 // -----
                                                 
                                                 NSData *dataRef = UIImagePNGRepresentation(image);
                                                 ABPersonSetImageData(person, (__bridge CFDataRef)dataRef, &error);
                                                 
                                                 // -----
                                                 
                                                 if (firstName.length)       ABRecordSetValue(person, kABPersonFirstNameProperty, (__bridge CFStringRef)firstName, &error);
                                                 if (lastName.length)        ABRecordSetValue(person, kABPersonLastNameProperty, (__bridge CFStringRef)lastName, &error);
                                                 if (middleName.length)      ABRecordSetValue(person, kABPersonMiddleNameProperty, (__bridge CFStringRef)middleName, &error);
                                                 if (nickname.length)        ABRecordSetValue(person, kABPersonNicknameProperty, (__bridge CFStringRef)nickname, &error);
                                                 if (organization.length)    ABRecordSetValue(person, kABPersonOrganizationProperty, (__bridge CFStringRef)organization, &error);
                                                 if (jobTitle.length)        ABRecordSetValue(person, kABPersonJobTitleProperty, (__bridge CFStringRef)jobTitle, &error);
                                                 if (department.length)      ABRecordSetValue(person, kABPersonDepartmentProperty, (__bridge CFStringRef)department, &error);
                                                 if (birthday)               ABRecordSetValue(person, kABPersonBirthdayProperty, (__bridge CFDateRef)birthday, &error);
                                                 if (note.length)            ABRecordSetValue(person, kABPersonNoteProperty, (__bridge CFStringRef)note, &error);
                                                 
                                                 // -----
                                                 
                                                 if (phonesMobile.count || phonesHome.count)
                                                 {
                                                     ABMutableMultiValueRef phoneMultiValue = ABMultiValueCreateMutable(kABPersonPhoneProperty);
                                                     
                                                     if (phonesMobile.count)
                                                         for (NSString *phone in phonesMobile)
                                                             ABMultiValueAddValueAndLabel(phoneMultiValue, (__bridge CFStringRef)phone, kABPersonPhoneMobileLabel, NULL);
                                                     
                                                     if (phonesHome.count)
                                                         for (NSString *phone in phonesHome)
                                                             ABMultiValueAddValueAndLabel(phoneMultiValue, (__bridge CFStringRef)phone, kABPersonPhoneMainLabel, NULL);
                                                     
                                                     ABRecordSetValue(person, kABPersonPhoneProperty, phoneMultiValue, nil);
                                                     CFRelease(phoneMultiValue);
                                                 }
                                                 
                                                 // -----
                                                 
                                                 if (country.length || region.length || city.length || street.length || zip.length)
                                                 {
                                                     ABMutableMultiValueRef addressMultiValue = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
                                                     
                                                     if (country.length) ABMultiValueAddValueAndLabel(addressMultiValue, (__bridge CFStringRef)country, kABPersonAddressCountryKey, NULL);
                                                     if (region.length)  ABMultiValueAddValueAndLabel(addressMultiValue, (__bridge CFStringRef)region, kABPersonAddressStateKey, NULL);
                                                     if (city.length)    ABMultiValueAddValueAndLabel(addressMultiValue, (__bridge CFStringRef)city, kABPersonAddressCityKey, NULL);
                                                     if (street.length)  ABMultiValueAddValueAndLabel(addressMultiValue, (__bridge CFStringRef)street, kABPersonAddressStreetKey, NULL);
                                                     if (zip.length)     ABMultiValueAddValueAndLabel(addressMultiValue, (__bridge CFStringRef)zip, kABPersonAddressZIPKey, NULL);
                                                     
                                                     ABRecordSetValue(person, kABPersonAddressProperty, addressMultiValue, &error);
                                                     CFRelease(addressMultiValue);
                                                 }
                                                 
                                                 // -----
                                                 
                                                 if (email.length)
                                                 {
                                                     ABMutableMultiValueRef emailMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
                                                     
                                                     ABMultiValueAddValueAndLabel(emailMultiValue, (__bridge CFStringRef)email, kABHomeLabel, NULL);
                                                     
                                                     ABRecordSetValue(person, kABPersonEmailProperty, emailMultiValue, &error);
                                                 }
                                                 
                                                 // -----
                                                 
                                                 if (site.length)
                                                 {
                                                     ABMutableMultiValueRef siteMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
                                                     
                                                     ABMultiValueAddValueAndLabel(siteMultiValue, (__bridge CFStringRef)site, kABHomeLabel, NULL);
                                                     
                                                     ABRecordSetValue(person, kABPersonURLProperty, siteMultiValue, &error);
                                                 }
                                                 
                                                 // -----
                                                 
                                                 ABAddressBookAddRecord(addressBook, person, &error); //add the new person to the record
                                                 
                                                 ABAddressBookSave(addressBook, &error); //save the record
                                                 
                                                 ABRecordID identifier = ABRecordGetRecordID(person);
                                                 
                                                 dispatch_async_main_safe(^(void)
                                                                          {
                                                                              if (completionHandler) completionHandler(granted, [NSString stringWithFormat:@"%i", (int)identifier]);
                                                                          });
                                             });
}

#pragma mark - Cookies

+ (void)cookiesClear
{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in [storage cookies])
        [storage deleteCookie:cookie];
}

#pragma mark - Strings

+ (NSString *)stringByCapitalizingFirstLetter:(NSString *)string
{
    return [string stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[string substringToIndex:1].uppercaseString];
}

+ (NSString *)stringByRemovingAllWhitespacesAndNewLine:(NSString *)string
{
    return [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""];
}

+ (NSString *)stringByRemovingAllNumbers:(NSString *)string
{
    return [[string componentsSeparatedByCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] componentsJoinedByString:@""];
}

+ (NSString *)stringByRemovingAllExeptNumbers:(NSString *)string
{
    return [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
}

+ (NSString *)stringByRemovingAllExeptPhoneSymbols:(NSString *)string
{
    return [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"+1234567890"] invertedSet]] componentsJoinedByString:@""];
}

+ (NSString *)string:(NSString *)string byRemovingAllExeptSymbols:(NSString *)symbols
{
    return [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:symbols] invertedSet]] componentsJoinedByString:@""];
}

+ (NSString *)stringWithNonBreakingSpace
{
    return @"\u00a0";
}

#pragma mark - Unicode

/** Unicode to normal text */
+ (NSString *)stringByDecodingHTMLEntitiesInString:(NSString *)input
{
    NSMutableString *results = [NSMutableString string];
    
    NSScanner *scanner = [NSScanner scannerWithString:input];
    [scanner setCharactersToBeSkipped:nil];
    
    while (![scanner isAtEnd])
    {
        NSString *temp;
        
        if ([scanner scanUpToString:@"&" intoString:&temp]) [results appendString:temp];
        
        if ([scanner scanString:@"&" intoString:NULL])
        {
            BOOL valid = YES;
            unsigned c = 0;
            NSUInteger savedLocation = [scanner scanLocation];
            
            if ([scanner scanString:@"#" intoString:NULL])
            {
                // it's a numeric entity
                if ([scanner scanString:@"x" intoString:NULL])
                {
                    // hexadecimal
                    unsigned int value;
                    
                    if ([scanner scanHexInt:&value]) c = value;
                    
                    else valid = NO;
                }
                else
                {
                    // decimal
                    int value;
                    
                    if ([scanner scanInt:&value] && value >= 0) c = value;
                    
                    else valid = NO;
                }
                
                if (![scanner scanString:@";" intoString:NULL])
                {
                    // not ;-terminated, bail out and emit the whole entity
                    valid = NO;
                }
            }
            else
            {
                if (![scanner scanUpToString:@";" intoString:&temp])
                {
                    // &; is not a valid entity
                    valid = NO;
                }
                else if (![scanner scanString:@";" intoString:NULL])
                {
                    // there was no trailing ;
                    valid = NO;
                }
                else if ([temp isEqualToString:@"amp"]) c = '&';
                else if ([temp isEqualToString:@"quot"]) c = '"';
                else if ([temp isEqualToString:@"lt"]) c = '<';
                else if ([temp isEqualToString:@"gt"]) c = '>';
                else
                {
                    // unknown entity
                    valid = NO;
                }
            }
            if (!valid)
            {
                // we errored, just emit the whole thing raw
                [results appendString:[input substringWithRange:NSMakeRange(savedLocation, [scanner scanLocation]-savedLocation)]];
            }
            else [results appendFormat:@"%C", (unichar)c];
        }
    }
    return results;
}

#pragma mark - Animations

+ (void)animateStandardWithAnimations:(void(^)())animations completion:(void(^)(BOOL finished))completion
{
    [LGHelper animateStandardWithDuration:0.5 delay:0.0 animations:animations completion:completion];
}

+ (void)animateStandardWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion
{
    [LGHelper animateStandardWithDuration:duration delay:0.0 animations:animations completion:completion];
}

+ (void)animateStandardWithDelay:(NSTimeInterval)delay animations:(void(^)())animations completion:(void(^)(BOOL finished))completion
{
    [LGHelper animateStandardWithDuration:0.5 delay:delay animations:animations completion:completion];
}

+ (void)animateStandardWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void(^)())animations completion:(void(^)(BOOL finished))completion
{
    if (kSystemVersion >= 7.0)
    {
        [UIView animateWithDuration:duration
                              delay:delay
             usingSpringWithDamping:1.f
              initialSpringVelocity:0.5
                            options:0
                         animations:animations
                         completion:completion];
    }
    else
    {
        [UIView animateWithDuration:duration*kAnimationSpringToNormal
                              delay:delay
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animations
                         completion:completion];
    }
}

#pragma mark - Colors

/** 0-255, 0-255, 0-255, 0.f-1.f */
+ (UIColor *)colorWithRGB_red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(CGFloat)red/255.f green:(CGFloat)green/255.f blue:(CGFloat)blue/255.f alpha:alpha];
}

/** #000000 */
+ (UIColor *)colorWithHEX:(UInt32)hex
{
    int red = (hex >> 16) & 0xFF;
    int green = (hex >> 8) & 0xFF;
    int blue = (hex) & 0xFF;
    
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.f];
}

/** #000000 */
+ (NSUInteger)colorHEX:(UIColor *)color
{
    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    NSInteger ired, igreen, iblue;
    ired = roundf(red * 255);
    igreen = roundf(green * 255);
    iblue = roundf(blue * 255);
    
    NSUInteger result = (ired << 16) | (igreen << 8) | iblue;
    return result;
}

+ (UIColor *)colorMixedInRGB:(UIColor *)color1 andColor:(UIColor *)color2 percent:(CGFloat)percent
{
    CGFloat mixSize = 100;
    
    CGFloat r1, g1, b1, r2, g2, b2, r3, g3, b3, empty;
    
    [color1 getRed:&r1 green:&g1 blue:&b1 alpha:&empty];
    [color2 getRed:&r2 green:&g2 blue:&b2 alpha:&empty];
    
    CGFloat mixStepR = (r2 - r1) / mixSize;
    CGFloat mixStepG = (g2 - g1) / mixSize;
    CGFloat mixStepB = (b2 - b1) / mixSize;
    
    r3 = r1 + mixStepR * percent;
    g3 = g1 + mixStepG * percent;
    b3 = b1 + mixStepB * percent;
    
    return [UIColor colorWithRed:r3 green:g3 blue:b3 alpha:1];
}

+ (UIColor *)colorMixedInLAB:(UIColor *)color1 andColor:(UIColor *)color2 percent:(CGFloat)percent
{
    if (percent <= 0) return color1;
    else if (percent >= 100) return color2;
    else
    {
        CGFloat mixSize = 100;
        
        NSArray *array1 = [self colorConvertRGBtoLAB:color1];
        NSArray *array2 = [self colorConvertRGBtoLAB:color2];
        
        NSArray *array3 = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:[[array1 objectAtIndex:0] floatValue] - (([[array1 objectAtIndex:0] floatValue] - [[array2 objectAtIndex:0] floatValue]) * (percent / mixSize))],
                           [NSNumber numberWithFloat:[[array1 objectAtIndex:1] floatValue] - (([[array1 objectAtIndex:1] floatValue] - [[array2 objectAtIndex:1] floatValue]) * (percent / mixSize))],
                           [NSNumber numberWithFloat:[[array1 objectAtIndex:2] floatValue] - (([[array1 objectAtIndex:2] floatValue] - [[array2 objectAtIndex:2] floatValue]) * (percent / mixSize))], nil];
        
        return [self colorConvertLABtoRGB:array3];
    }
}

/** 0-255 */
+ (UIColor *)color:(UIColor *)color darkerOnRGB:(NSUInteger)k
{
    if (k > 255) k = 255;
    
    CGFloat r, g, b, a;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    CGFloat rgbMax = 255.f;
    
    return [UIColor colorWithRed:r-((CGFloat)k/rgbMax) green:g-((CGFloat)k/rgbMax) blue:b-((CGFloat)k/rgbMax) alpha:a];
}

/** 0-255 */
+ (UIColor *)color:(UIColor *)color lighterOnRGB:(NSUInteger)k
{
    if (k > 255) k = 255;
    
    CGFloat r, g, b, a;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    CGFloat rgbMax = 255.f;
    
    return [UIColor colorWithRed:r+((CGFloat)k/rgbMax) green:g+((CGFloat)k/rgbMax) blue:b+((CGFloat)k/rgbMax) alpha:a];
}

/** 0.f-1.f */
+ (UIColor *)color:(UIColor *)color darkerOn:(CGFloat)k
{
    if (k < 0.f) k = 0.f;
    if (k > 1.f) k = 1.f;
    
    CGFloat r, g, b, a;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    return [UIColor colorWithRed:r-k green:g-k blue:b-k alpha:a];
}

/** 0.f-1.f */
+ (UIColor *)color:(UIColor *)color lighterOn:(CGFloat)k
{
    if (k < 0.f) k = 0.f;
    if (k > 1.f) k = 1.f;
    
    CGFloat r, g, b, a;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    return [UIColor colorWithRed:r+k green:g+k blue:b+k alpha:a];
}

/** 0.f-100.f */
+ (UIColor *)color:(UIColor *)color darkerOnPercent:(CGFloat)percent
{
    if (percent < 0.f) percent = 0.f;
    if (percent > 100.f) percent = 100.f;
    
    CGFloat r, g, b, a;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    CGFloat percent_ = percent/100.f;
    
    return [UIColor colorWithRed:r-r*percent_ green:g-g*percent_ blue:b-b*percent_ alpha:a];
}

/** 0.f-100.f */
+ (UIColor *)color:(UIColor *)color lighterOnPercent:(CGFloat)percent
{
    if (percent < 0.f) percent = 0.f;
    if (percent > 100.f) percent = 100.f;
    
    CGFloat r, g, b, a;
    
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    CGFloat rgbMax = 255.f;
    
    CGFloat percent_ = percent/100.f;
    
    return [UIColor colorWithRed:r+(rgbMax-r)*percent_ green:g+(rgbMax-g)*percent_ blue:b+(rgbMax-b)*percent_ alpha:a];
}

+ (NSArray *)colorConvertRGBtoXYZ:(UIColor *)color
{
    ////make variables to get color values
    CGFloat red2;
    CGFloat green2;
    CGFloat blue2;
    
    [color getRed:&red2 green:&green2 blue:&blue2 alpha:nil];
    
    //convert to XYZ
    
    float red = (float)red2;
    float green = (float)green2;
    float blue = (float)blue2;
    
    // adjusting values
    if (red > 0.04045)
    {
        red = (red + 0.055)/1.055;
        red = pow(red,2.4);
    }
    else red = red/12.92;
    
    if (green > 0.04045)
    {
        green = (green + 0.055)/1.055;
        green = pow(green,2.4);
    }
    else green = green/12.92;
    
    if (blue > 0.04045)
    {
        blue = (blue + 0.055)/1.055;
        blue = pow(blue,2.4);
    }
    else blue = blue/12.92;
    
    red *= 100;
    green *= 100;
    blue *= 100;
    
    //make x, y and z variables
    float x;
    float y;
    float z;
    
    // applying the matrix to finally have XYZ
    x = (red * 0.4124) + (green * 0.3576) + (blue * 0.1805);
    y = (red * 0.2126) + (green * 0.7152) + (blue * 0.0722);
    z = (red * 0.0193) + (green * 0.1192) + (blue * 0.9505);
    
    NSNumber *xNumber = [NSNumber numberWithFloat:x];
    NSNumber *yNumber = [NSNumber numberWithFloat:y];
    NSNumber *zNumber = [NSNumber numberWithFloat:z];
    
    //add them to an array to return.
    NSArray *xyzArray = [NSArray arrayWithObjects:xNumber, yNumber, zNumber, nil];
    
    return xyzArray;
}

+ (NSArray *)colorConvertRGBtoLAB:(UIColor *)color
{
    return [self colorConvertXYZtoLAB:[self colorConvertRGBtoXYZ:color]];
}

+ (NSArray *)colorConvertXYZtoLAB:(NSArray *)xyzArray
{
    NSNumber *xNumber = [xyzArray objectAtIndex:0];
    NSNumber *yNumber = [xyzArray objectAtIndex:1];
    NSNumber *zNumber = [xyzArray objectAtIndex:2];
    
    //make x, y and z variables
    float x = xNumber.floatValue;
    float y = yNumber.floatValue;
    float z = zNumber.floatValue;
    
    //NSLog(@"LGKit: XYZ color - %f, %f, %f", x, y, z);
    
    //then convert XYZ to LAB
    
    x = x/95.047;
    y = y/100;
    z = z/108.883;
    
    // adjusting the values
    if (x > 0.008856) x = powf(x,(1.0/3.0));
    else x = ((7.787 * x) + (16/116));
    
    if (y > 0.008856) y = pow(y,(1.0/3.0));
    else y = ((7.787 * y) + (16/116));
    
    if (z > 0.008856) z = pow(z,(1.0/3.0));
    else z = ((7.787 * z) + (16/116));
    
    //make L, A and B variables
    float l;
    float a;
    float b;
    
    //finally have your l, a, b variables!!!!
    l = ((116 * y) - 16);
    a = 500 * (x - y);
    b = 200 * (y - z);
    
    NSNumber *lNumber = [NSNumber numberWithFloat:l];
    NSNumber *aNumber = [NSNumber numberWithFloat:a];
    NSNumber *bNumber = [NSNumber numberWithFloat:b];
    
    //add them to an array to return.
    NSArray *labArray = [NSArray arrayWithObjects:lNumber, aNumber, bNumber, nil];
    
    return labArray;
}

+ (NSArray *)colorConvertLABtoXYZ:(NSArray *)labArray
{
    NSNumber *lNumber = [labArray objectAtIndex:0];
    NSNumber *aNumber = [labArray objectAtIndex:1];
    NSNumber *bNumber = [labArray objectAtIndex:2];
    
    //make l, a and b variables
    float l = lNumber.floatValue;
    float a = aNumber.floatValue;
    float b = bNumber.floatValue;
    
    float delta = 6 / 29;
    
    float y = (l + 16) / 116;
    float x = y + (a / 500);
    float z = y - (b / 200);
    
    if (pow(x, 3.0) > delta) x = pow(x, 3);
    else x = (x - 16 / 116) * 3 * (delta * delta);
    
    if (pow(y, 3.0) > delta) y = pow(y, 3);
    else y = (y - 16 / 116) * 3 * (delta * delta);
    
    if (pow(z, 3.0) > delta) z = pow(z, 3);
    else z = (z - 16 / 116) * 3 * (delta * delta);
    
    x = x * 95.047;
    y = y * 100;
    z = z * 108.883;
    
    NSNumber *xNumber = [NSNumber numberWithFloat:x];
    NSNumber *yNumber = [NSNumber numberWithFloat:y];
    NSNumber *zNumber = [NSNumber numberWithFloat:z];
    
    //add them to an array to return.
    NSArray *xyzArray = [NSArray arrayWithObjects:xNumber, yNumber, zNumber, nil];
    
    return xyzArray;
}

+ (UIColor *)colorConvertXYZtoRGB:(NSArray *)xyzArray
{
    NSNumber *xNumber = [xyzArray objectAtIndex:0];
    NSNumber *yNumber = [xyzArray objectAtIndex:1];
    NSNumber *zNumber = [xyzArray objectAtIndex:2];
    
    //make x, y and z variables
    float x = xNumber.floatValue;
    float y = yNumber.floatValue;
    float z = zNumber.floatValue;
    
    x = x / 100;
    y = y / 100;
    z = z / 100;
    
    float r = x *  3.2406 + y * -1.5372 + z * -0.4986;
    float g = x * -0.9689 + y *  1.8758 + z *  0.0415;
    float b = x *  0.0557 + y * -0.2040 + z *  1.0570;
    
    if (r > 0.0031308) r = 1.055 * pow(r, 1 / 2.4) - 0.055;
    else r = 12.92 * r;
    
    if (g > 0.0031308) g = 1.055 * pow(g, 1 / 2.4) - 0.055;
    else g = 12.92 * g;
    
    if (b > 0.0031308) b = 1.055 * pow(b, 1 / 2.4) - 0.055;
    else b = 12.92 * b;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

+ (UIColor *)colorConvertLABtoRGB:(NSArray *)labArray
{
    return [self colorConvertXYZtoRGB:[self colorConvertLABtoXYZ:labArray]];
}

#pragma mark - Email

+ (BOOL)emailIsCorrect:(NSString *)string
{
    NSString *regExString =
    @"(?:[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-"
    @"z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExString];
    BOOL isMatchesRegEx = [regExPredicate evaluateWithObject:string];
    
    return isMatchesRegEx;
}

- (BOOL)emailSendToAddresses:(NSArray *)addresses
                       theme:(NSString *)theme
                     message:(NSString *)message
            inViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
                setupHandler:(void(^)(MFMailComposeViewController *viewController))setupHandler
    presentCompletionHandler:(void(^)())presentCompletionHandler
           completionHandler:(void(^)(MFMailComposeResult result, NSError *error))completionHandler
    dismissCompletionHandler:(void(^)())dismissCompletionHandler
{
    return [self emailSendToAddresses:addresses
                         theme:theme
                       message:message
              inViewController:viewController
                      animated:animated
                      delegate:nil
                  setupHandler:setupHandler
      presentCompletionHandler:presentCompletionHandler
            completionHandler:completionHandler
             dismissCompletionHandler:dismissCompletionHandler];
}

- (BOOL)emailSendToAddresses:(NSArray *)addresses
                       theme:(NSString *)theme
                     message:(NSString *)message
            inViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
                    delegate:(id<MFMailComposeViewControllerDelegate>)delegate
                setupHandler:(void(^)(MFMailComposeViewController *viewController))setupHandler
    presentCompletionHandler:(void(^)())presentCompletionHandler
{
    return [self emailSendToAddresses:addresses
                                theme:theme
                              message:message
                     inViewController:viewController
                             animated:animated
                             delegate:delegate
                         setupHandler:setupHandler
             presentCompletionHandler:presentCompletionHandler
                    completionHandler:nil
             dismissCompletionHandler:nil];
}

- (BOOL)emailSendToAddresses:(NSArray *)addresses
                       theme:(NSString *)theme
                     message:(NSString *)message
            inViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
                    delegate:(id<MFMailComposeViewControllerDelegate>)delegate
                setupHandler:(void(^)(MFMailComposeViewController *viewController))setupHandler
    presentCompletionHandler:(void(^)())presentCompletionHandler
           completionHandler:(void(^)(MFMailComposeResult result, NSError *error))completionHandler
    dismissCompletionHandler:(void(^)())dismissCompletionHandler
{
    BOOL canSendMail = [MFMailComposeViewController canSendMail];
    
    if (canSendMail)
    {
        _emailViewController = viewController;
        _emailAnimated = animated;
        _emailCompletionHandler = completionHandler;
        _emailDismissCompletionHandler = dismissCompletionHandler;
        
        MFMailComposeViewController *mailViewController = [MFMailComposeViewController new];
        mailViewController.mailComposeDelegate = (delegate ? delegate : self);
        [mailViewController setSubject:theme];
        [mailViewController setToRecipients:addresses];
        [mailViewController setMessageBody:message isHTML:NO];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            mailViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        if (setupHandler) setupHandler(mailViewController);
        
        [viewController presentViewController:mailViewController animated:animated completion:presentCompletionHandler];
    }
    
    return canSendMail;
}

#pragma mark Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (_emailCompletionHandler) _emailCompletionHandler(result, error);
    
    [_emailViewController dismissViewControllerAnimated:_emailAnimated completion:_emailDismissCompletionHandler];
}

#pragma mark - Phone, SMS

+ (BOOL)phoneNumberIsCorrect:(NSString *)string
{
    NSString *regExString = @"^[1-9\\+][0-9]{5,15}$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExString];
    BOOL isMatchesRegEx = [regExPredicate evaluateWithObject:string];
    
    return isMatchesRegEx;
}

- (BOOL)smsSendWithText:(NSString *)text
       inViewController:(UIViewController *)viewController
               animated:(BOOL)animated
           setupHandler:(void(^)(MFMessageComposeViewController *viewController))setupHandler
presentCompletionHandler:(void(^)())presentCompletionHandler
      completionHandler:(void(^)(MessageComposeResult result))completionHandler
dismissCompletionHandler:(void(^)())dismissCompletionHandler
{
    return [self smsSendWithText:text
                inViewController:viewController
                        animated:animated
                        delegate:nil
                    setupHandler:setupHandler
        presentCompletionHandler:presentCompletionHandler
            completionHandler:completionHandler
        dismissCompletionHandler:dismissCompletionHandler];
}

- (BOOL)smsSendWithText:(NSString *)text
       inViewController:(UIViewController *)viewController
               animated:(BOOL)animated
               delegate:(id<MFMessageComposeViewControllerDelegate>)delegate
           setupHandler:(void(^)(MFMessageComposeViewController *viewController))setupHandler
presentCompletionHandler:(void(^)())presentCompletionHandler
{
    return [self smsSendWithText:text
                inViewController:viewController
                        animated:animated
                        delegate:delegate
                    setupHandler:setupHandler
        presentCompletionHandler:presentCompletionHandler
            completionHandler:nil
        dismissCompletionHandler:nil];
}

- (BOOL)smsSendWithText:(NSString *)text
       inViewController:(UIViewController *)viewController
               animated:(BOOL)animated
               delegate:(id<MFMessageComposeViewControllerDelegate>)delegate
           setupHandler:(void(^)(MFMessageComposeViewController *viewController))setupHandler
presentCompletionHandler:(void(^)())presentCompletionHandler
      completionHandler:(void(^)(MessageComposeResult result))completionHandler
dismissCompletionHandler:(void(^)())dismissCompletionHandler
{
    BOOL canSendText = [MFMessageComposeViewController canSendText];
    
    if (canSendText)
    {
        _smsViewController = viewController;
        _smsAnimated = animated;
        _smsCompletionHandler = completionHandler;
        _smsDismissCompletionHandler = dismissCompletionHandler;
        
        MFMessageComposeViewController *messageViewController = [[MFMessageComposeViewController alloc] init];
        messageViewController.messageComposeDelegate = self;
        [messageViewController setBody:text];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            messageViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [viewController presentViewController:messageViewController animated:animated completion:presentCompletionHandler];
    }

    return canSendText;
}

#pragma mark Delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (_smsCompletionHandler) _smsCompletionHandler(result);
    
    [_smsViewController dismissViewControllerAnimated:_smsAnimated completion:_smsDismissCompletionHandler];
}

#pragma mark - UIImagePickerController

- (BOOL)imagePickerControllerShowWithActionSheetInView:(UIView *)view
                                      inViewController:(UIViewController *)viewController
                                              animated:(BOOL)animated
                                          setupHandler:(void(^)(UIImagePickerController *imagePickerController))setupHandler
                              presentCompletionHandler:(void(^)())presentCompletionHandler
                                     completionHandler:(void(^)(UIImage *image))completionHandler
                              dismissCompletionHandler:(void(^)())dismissCompletionHandler
{
    return [self imagePickerControllerShowWithActionSheetInView:view
                                               inViewController:viewController
                                                       animated:animated
                                                       delegate:nil
                                                   setupHandler:setupHandler
                                       presentCompletionHandler:presentCompletionHandler
                                              completionHandler:completionHandler
                                       dismissCompletionHandler:dismissCompletionHandler];
}

- (BOOL)imagePickerControllerShowWithActionSheetInView:(UIView *)view
                                      inViewController:(UIViewController *)viewController
                                              animated:(BOOL)animated
                                              delegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate
                                          setupHandler:(void(^)(UIImagePickerController *imagePickerController))setupHandler
                              presentCompletionHandler:(void(^)())presentCompletionHandler
{
    return [self imagePickerControllerShowWithActionSheetInView:view
                                               inViewController:viewController
                                                       animated:animated
                                                       delegate:delegate
                                                   setupHandler:setupHandler
                                       presentCompletionHandler:presentCompletionHandler
                                              completionHandler:nil
                                       dismissCompletionHandler:nil];
}

- (BOOL)imagePickerControllerShowWithActionSheetInView:(UIView *)view
                                      inViewController:(UIViewController *)viewController
                                              animated:(BOOL)animated
                                              delegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate
                                          setupHandler:(void(^)(UIImagePickerController *imagePickerController))setupHandler
                              presentCompletionHandler:(void(^)())presentCompletionHandler
                                     completionHandler:(void(^)(UIImage *image))completionHandler
                              dismissCompletionHandler:(void(^)())dismissCompletionHandler
{
    BOOL sourceTypeAvailable = NO;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        sourceTypeAvailable = YES;
        
        _imagePickerController = [UIImagePickerController new];
        _imagePickerParentViewController = viewController;
        _imagePickerSetupHandler = setupHandler;
        _imagePickerPresentCompletionHandler = presentCompletionHandler;
        _imagePickerCompletionHandler = completionHandler;
        _imagePickerDismissCompletionHandler = dismissCompletionHandler;
        _imagePickerAnimated = animated;
        _imagePickerDelegate = delegate;
        
        // -----
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:LS(@"Cancel")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:LS(@"Take photo"), LS(@"Choose from gallery"), nil];
        actionSheet.tag = kActionSheetTagImagePicker;
        [actionSheet showInView:view];
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ||
             [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        sourceTypeAvailable = YES;
        
        _imagePickerController = [UIImagePickerController new];
        
        UIImagePickerControllerSourceType sourceType = ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ?
                                                        UIImagePickerControllerSourceTypeCamera :
                                                        UIImagePickerControllerSourceTypePhotoLibrary);
        
        [self imagePickerControllerShowWithSourceType:sourceType
                                     inViewController:viewController
                                             animated:animated
                                             delegate:delegate
                                         setupHandler:setupHandler
                             presentCompletionHandler:presentCompletionHandler
                                    completionHandler:completionHandler
                             dismissCompletionHandler:dismissCompletionHandler];
    }
    
    return sourceTypeAvailable;
}

- (BOOL)imagePickerControllerShowWithSourceType:(UIImagePickerControllerSourceType)sourceType
                               inViewController:(UIViewController *)viewController
                                       animated:(BOOL)animated
                                   setupHandler:(void(^)(UIImagePickerController *imagePickerController))setupHandler
                       presentCompletionHandler:(void(^)())presentCompletionHandler
                              completionHandler:(void(^)(UIImage *image))completionHandler
                       dismissCompletionHandler:(void(^)())dismissCompletionHandler
{
    return [self imagePickerControllerShowWithSourceType:sourceType
                                        inViewController:viewController
                                                animated:animated
                                                delegate:nil
                                            setupHandler:setupHandler
                                presentCompletionHandler:presentCompletionHandler
                                       completionHandler:completionHandler
                                dismissCompletionHandler:dismissCompletionHandler];
}

- (BOOL)imagePickerControllerShowWithSourceType:(UIImagePickerControllerSourceType)sourceType
                               inViewController:(UIViewController *)viewController
                                       animated:(BOOL)animated
                                       delegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate
                                   setupHandler:(void(^)(UIImagePickerController *imagePickerController))setupHandler
                       presentCompletionHandler:(void(^)())presentCompletionHandler
{
    return [self imagePickerControllerShowWithSourceType:sourceType
                                        inViewController:viewController
                                                animated:animated
                                                delegate:delegate
                                            setupHandler:setupHandler
                                presentCompletionHandler:presentCompletionHandler
                                       completionHandler:nil
                                dismissCompletionHandler:nil];
}

- (BOOL)imagePickerControllerShowWithSourceType:(UIImagePickerControllerSourceType)sourceType
                               inViewController:(UIViewController *)viewController
                                       animated:(BOOL)animated
                                       delegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate
                                   setupHandler:(void(^)(UIImagePickerController *imagePickerController))setupHandler
                       presentCompletionHandler:(void(^)())presentCompletionHandler
                              completionHandler:(void(^)(UIImage *image))completionHandler
                       dismissCompletionHandler:(void(^)())dismissCompletionHandler
{
    BOOL sourceTypeAvailable = NO;
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        sourceTypeAvailable = YES;
        
        _imagePickerParentViewController = viewController;
        _imagePickerCompletionHandler = completionHandler;
        _imagePickerDismissCompletionHandler = dismissCompletionHandler;
        _imagePickerAnimated = animated;
        _imagePickerDelegate = delegate;
        
        // -----
        
        if (!_imagePickerController)
            _imagePickerController = [UIImagePickerController new];
        
        _imagePickerController.sourceType = sourceType;
        _imagePickerController.delegate = (delegate ? delegate : self);
        
        if (setupHandler) setupHandler(_imagePickerController);
        
        [viewController presentViewController:_imagePickerController animated:animated completion:presentCompletionHandler];
    }
    
    return sourceTypeAvailable;
}

#pragma mark Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    image = [LGHelper imageWithOrientationExifFix:image];
    
    if (_imagePickerCompletionHandler) _imagePickerCompletionHandler(image);
    
    [_imagePickerParentViewController dismissViewControllerAnimated:_imagePickerAnimated completion:^(void)
     {
         self.imagePickerController = nil;
         
         if (_imagePickerDismissCompletionHandler) _imagePickerDismissCompletionHandler();
     }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePickerParentViewController dismissViewControllerAnimated:_imagePickerAnimated completion:^(void)
     {
         self.imagePickerController = nil;
         
         if (_imagePickerDismissCompletionHandler) _imagePickerDismissCompletionHandler();
     }];
}

#pragma mark - UIDocumentInteractionController

- (BOOL)documentInteractionControllerShowWithFileURL:(NSURL *)fileUrl
                                    inViewController:(UIViewController *)viewController
                                            animated:(BOOL)animated
                                        setupHandler:(void(^)(UIDocumentInteractionController *documentInteractionController))setupHandler
                                didEndPreviewHandler:(void(^)())didEndPreviewHandler
{
    return [self documentInteractionControllerShowWithFileURL:fileUrl
                                             inViewController:viewController
                                                     animated:animated
                                                     delegate:nil
                                                 setupHandler:setupHandler
                                         didEndPreviewHandler:didEndPreviewHandler];
}

- (BOOL)documentInteractionControllerShowWithFileURL:(NSURL *)fileUrl
                                    inViewController:(UIViewController *)viewController
                                            animated:(BOOL)animated
                                            delegate:(id<UIDocumentInteractionControllerDelegate>)delegate
                                        setupHandler:(void(^)(UIDocumentInteractionController *documentInteractionController))setupHandler
{
    return [self documentInteractionControllerShowWithFileURL:fileUrl
                                             inViewController:viewController
                                                     animated:animated
                                                     delegate:delegate
                                                 setupHandler:setupHandler
                                         didEndPreviewHandler:nil];
}

- (BOOL)documentInteractionControllerShowWithFileURL:(NSURL *)fileUrl
                                    inViewController:(UIViewController *)viewController
                                            animated:(BOOL)animated
                                            delegate:(id<UIDocumentInteractionControllerDelegate>)delegate
                                        setupHandler:(void(^)(UIDocumentInteractionController *documentInteractionController))setupHandler
                                didEndPreviewHandler:(void(^)())didEndPreviewHandler
{
    _documentInteractionParentViewController = viewController;
    _documentInteractionDidEndPreviewHandler = didEndPreviewHandler;
    _documentInteractionAnimated = animated;
    _documentInteractionDelegate = delegate;
    
    // -----
    
    _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileUrl];
    _documentInteractionController.delegate = (delegate ? delegate : self);
    
    if (setupHandler) setupHandler(_documentInteractionController);
    
    return [_documentInteractionController presentPreviewAnimated:animated];
}

#pragma mark Delegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return _documentInteractionParentViewController;
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller
{
    if (_documentInteractionDidEndPreviewHandler) _documentInteractionDidEndPreviewHandler();
}

#pragma mark - UIActivityViewController

- (void)activityViewControllerShowWithFilesUrl:(NSArray *)filesUrl
                         applicationActivities:(NSArray *)applicationActivities
                         excludedActivityTypes:(NSArray *)excludedActivityTypes
                              inViewController:(UIViewController *)viewController
                                      animated:(BOOL)animated
                                  setupHandler:(void(^)(UIActivityViewController *activityViewController))setupHandler
                             completionHandler:(void(^)(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError))completionHandler
                      presentCompletionHandler:(void(^)())presentCompletionHandler
{
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:filesUrl
                                                                                         applicationActivities:applicationActivities];
    activityViewController.excludedActivityTypes = excludedActivityTypes;
    
    if (kSystemVersion < 8.0)
    {
        activityViewController.completionHandler = ^(NSString *activityType, BOOL completed)
        {
            if (completionHandler) completionHandler(activityType, completed, nil, nil);
        };
    }
    else
    {
        activityViewController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError)
        {
            if (completionHandler) completionHandler(activityType, completed, returnedItems, activityError);
        };
    }
    
    if (setupHandler) setupHandler(activityViewController);
    
    [viewController presentViewController:activityViewController animated:animated completion:presentCompletionHandler];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == kActionSheetTagImagePicker && buttonIndex != actionSheet.cancelButtonIndex)
    {
        UIImagePickerControllerSourceType sourceType;
        
        if (buttonIndex == 0)
            sourceType = UIImagePickerControllerSourceTypeCamera;
        else
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self imagePickerControllerShowWithSourceType:sourceType
                                     inViewController:_imagePickerParentViewController
                                             animated:_imagePickerAnimated
                                             delegate:_imagePickerDelegate
                                         setupHandler:_imagePickerSetupHandler
                             presentCompletionHandler:_imagePickerPresentCompletionHandler
                                    completionHandler:_imagePickerCompletionHandler
                             dismissCompletionHandler:_imagePickerDismissCompletionHandler];
    }
}

#pragma mark - MWPhotoBrowser
/*
- (void)photoBrowserShow
{
    MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    photoBrowser.displayActionButton = YES;     // Show action button to allow sharing, copying, etc (defaults to YES)
    photoBrowser.displayNavArrows = YES;        // Whether to display left and right nav arrows on toolbar (defaults to NO)
    photoBrowser.displaySelectionButtons = NO;  // Whether selection buttons are shown on each image (defaults to NO)
    photoBrowser.zoomPhotosToFill = YES;        // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    photoBrowser.alwaysShowControls = NO;       // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    photoBrowser.enableGrid = NO;               // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    photoBrowser.startOnGrid = NO;              // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    photoBrowser.enableSwipeToDismiss = NO;
    photoBrowser.currentPhotoIndex = 0;
    
    for (NSUInteger i=0; i<someNumber; i++)
    {
        MWPhoto *photo = [MWPhoto photoWithURL:PhotoURL];
        photo.caption = Description;
        
        [_photosArray addObject:photo];
    }
    
    UINavigationController *photoNavController = [[UINavigationController alloc] initWithRootViewController:photoBrowser];
    [self.navigationController presentViewController:photoNavController animated:YES completion:nil];
}
*/
#pragma mark Delegate
/*
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _photosArray.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _photosArray.count)
        return _photosArray[index];
    
    return nil;
}
*/
#pragma mark - Processor
/*
unsigned int countCores()
{
    host_basic_info_data_t hostInfo;
    mach_msg_type_number_t infoCount;
    
    infoCount = HOST_BASIC_INFO_COUNT;
    host_info(mach_host_self(), HOST_BASIC_INFO, (host_info_t)&hostInfo, &infoCount);
    
    return (unsigned int)(hostInfo.max_cpus);
}

unsigned int countCores()
{
    size_t len;
    unsigned int ncpu;
    
    len = sizeof(ncpu);
    sysctlbyname ("hw.ncpu",&ncpu,&len,NULL,0);
    
    return ncpu;
}
*/
@end

//
//  LGHelper.h
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

#pragma mark - Debug

#if DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

// --------------------------------------------------

#pragma mark - Device

#define kDeviceIsPad    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kDeviceIsPhone  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kDeviceIsPhoneSmallerOrEqual35 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 480.0)
#define kDeviceIsPhoneSmallerOrEqual40 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 568.0)
#define kDeviceIsPhoneSmallerOrEqual47 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 667.0)
#define kDeviceIsPhoneSmallerOrEqual55 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 1104.0)

#define kDeviceIsRetina     (UIScreen.mainScreen.scale >= 2.0)
#define kDeviceIsNotRetina  (UIScreen.mainScreen.scale == 1.0)

#define kMainScreenScale    UIScreen.mainScreen.scale

#define kMainScreenWidth    UIScreen.mainScreen.bounds.size.width
#define kMainScreenHeight   UIScreen.mainScreen.bounds.size.height

#define kMainScreenSideMax  MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)
#define kMainScreenSideMin  MIN(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)

#define kSystemVersion                                          UIDevice.currentDevice.systemVersion.floatValue
#define kSystemName                                             UIDevice.currentDevice.systemName
#define kDeviceModel                                            UIDevice.currentDevice.model
#define kDeviceModelLocalized                                   UIDevice.currentDevice.localizedModel
#define kDeviceName                                             UIDevice.currentDevice.name
#define kDeviceBatteryLevel                                     (float)UIDevice.currentDevice.batteryLevel
#define kDeviceBatteryState                                     (UIDeviceBatteryState)UIDevice.currentDevice.batteryState
#define kDeviceOrientation                                      (UIDeviceOrientation)UIDevice.currentDevice.orientation
#define kDeviceBeginGeneratingDeviceOrientationNotifications    [UIDevice.currentDevice beginGeneratingDeviceOrientationNotifications]
#define kDeviceEndGeneratingDeviceOrientationNotifications      [UIDevice.currentDevice endGeneratingDeviceOrientationNotifications]
#define kDeviceIsGeneratingDeviceOrientationNotifications       UIDevice.currentDevice.isGeneratingDeviceOrientationNotifications

#define kProcessorNumberOfCores         NSProcessInfo.processInfo.processorCount
#define kProcessorNumberActiveOfCores   NSProcessInfo.processInfo.activeProcessorCount

#define kDeviceIsOld                    (NSProcessInfo.processInfo.activeProcessorCount < 2)

#define kStatusBarOrientation               UIApplication.sharedApplication.statusBarOrientation
#define kStatusBarOrientationIsPortrait     UIInterfaceOrientationIsPortrait(UIApplication.sharedApplication.statusBarOrientation)
#define kStatusBarOrientationIsLandscape    UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation)
#define kStatusBarHidden                    UIApplication.sharedApplication.statusBarHidden

#define kLanguageDefault    (NSString *)[[NSLocale preferredLanguages] objectAtIndex:0] // "en"
#define kCountryCode        (NSString *)[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode] // "en"
#define kTimeZone           NSTimeZone.localTimeZone
#define kTimeZoneName       NSTimeZone.localTimeZone.name // "America/Los_Angeles"

// --------------------------------------------------

#pragma mark - Directories

#define kMainBundleDirectoryURL     [NSURL fileURLWithPath:NSBundle.mainBundle.resourcePath]
#define kApplicationsDirectoryURL   (NSURL *)[[NSFileManager.defaultManager URLsForDirectory:NSApplicationDirectory inDomains:NSUserDomainMask] lastObject]
#define kDocumentsDirectoryURL      (NSURL *)[[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]
#define kInfoDictionary             NSBundle.mainBundle.infoDictionary
#define kBuildVersion               (NSString *)NSBundle.mainBundle.infoDictionary[@"CFBundleVersion"]
#define kAppVersion                 (NSString *)NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"]

// --------------------------------------------------

#pragma mark - Reductions

#define kUserDefaults       NSUserDefaults.standardUserDefaults
#define kFileManager        NSFileManager.defaultManager
#define kApplication        UIApplication.sharedApplication
#define kNotificationCenter NSNotificationCenter.defaultCenter
#define kAppDelegate        (AppDelegate *)UIApplication.sharedApplication.delegate
#define kMainBundle         NSBundle.mainBundle
#define kMainScreen         UIScreen.mainScreen
#define kAppWindow          [UIApplication.sharedApplication.delegate window]
#define kRootViewController [UIApplication.sharedApplication.delegate window].rootViewController

#define kUserDefaultsIsKeyExists(key) [NSUserDefaults.standardUserDefaults.dictionaryRepresentation.allKeys containsObject:(key)]

// --------------------------------------------------

#pragma mark - Colors

#define kColorRGBA(r, g, b, a)  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]
#define kColorRGB(r, g, b)      [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

// --------------------------------------------------

#pragma mark - Geometry

#define kDegreesToRadians(d)    ((d) * M_PI / 180)
#define kRadiansToDegrees(r)    ((r) * 180.0 / M_PI)

// --------------------------------------------------

#pragma mark - Regex

#define kRegexForNumbers            @"^([+-]?)(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"
#define kRegexForIntegers           @"^([+-]?)(?:|0|[1-9]\\d*)?$"
#define kIsStringANumber(string)    [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", kRegexForNumbers] evaluateWithObject:string]
#define kIsStringAnInteger(string)  [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", kRegexForIntegers] evaluateWithObject:string]

// --------------------------------------------------

#pragma mark - Retain Cycle

#define kWeakSelf()     __weak typeof(self) wself = self
#define kStrongSelf()   __strong typeof(wself) self = wself

// --------------------------------------------------

#pragma mark - GDC

#define dispatch_sync_main_safe(block)\
    if ([NSThread isMainThread])\
    {\
        block();\
    }\
    else\
    {\
        dispatch_sync(dispatch_get_main_queue(), block);\
    }\

#define dispatch_async_main_safe(block)\
    if ([NSThread isMainThread])\
    {\
        block();\
    }\
    else\
    {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }\

#define dispatch_sync_main(block)   dispatch_sync(dispatch_get_main_queue(), block)
#define dispatch_async_main(block)  dispatch_async(dispatch_get_main_queue(), block)

#define dispatch_sync_global_default(block)     dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define dispatch_async_global_default(block)    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

// --------------------------------------------------

#pragma mark - Localized

#define LS(key) NSLocalizedString(key, nil)

// --------------------------------------------------

#pragma mark - Sizes

#define kNavBarHeight           44.f //self.navigationController.navigationBar.frame.size.height
#define kStatusBarHeight        20.f //[UIApplication sharedApplication].statusBarFrame.size.height
#define kStatusAndNavBarsHeight 64.f //([UIApplication sharedApplication].statusBarFrame.size.height+self.navigationController.navigationBar.frame.size.height)

// --------------------------------------------------

#pragma mark - Aspects
// width : height

#define kAspect1x1      1       // 1 : 1
#define kAspect4x3      1.33    // 4 : 3
#define kAspect16x10    1.6     // 16 : 10
#define kAspect16x9     1.78    // 16 : 9

// --------------------------------------------------

#pragma mark - Alphabets

#define kAlphabetEnLowercaseArray @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"]
#define kAlphabetEnUppercaseArray @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]
#define kAlphabetRuLowercaseArray @[@"а", @"б", @"в", @"г", @"д", @"е", @"ё", @"ж", @"з", @"и", @"й", @"к", @"л", @"м", @"н", @"о", @"п", @"р", @"с", @"т", @"у", @"ф", @"х", @"ц", @"ч", @"ш", @"щ", @"ъ", @"ы", @"ь", @"э", @"ю", @"я"]
#define kAlphabetRuUppercaseArray @[@"А", @"Б", @"В", @"Г", @"Д", @"Е", @"Ё", @"Ж", @"З", @"И", @"Й", @"К", @"Л", @"М", @"Н", @"О", @"П", @"Р", @"С", @"Т", @"У", @"Ф", @"Х", @"Ц", @"Ч", @"Ш", @"Щ", @"Ъ", @"Ы", @"Ь", @"Э", @"Ю", @"Я"]

// --------------------------------------------------

#pragma mark - Recomended touch area sizes

#define kSizeStandardSmall  32.f
#define kSizeStandardMedium 44.f
#define kSizeStandardLarge  64.f

// --------------------------------------------------

#pragma mark - Animations

#define kAnimationSpringToNormal 0.66

#pragma mark - Useful

#pragma mark Reductions

// [NSArray arrayWithObjects:@"1", @"2", nil]                                       == @[@"1", @"2"];
// [NSDictionary dictionaryWithObjects:@"1", @"2", nil forKeys:@"one", @"two", nil] == @{@"one" : @"1", @"two" : @"2"}
// [NSNumber numberWithChar:'A']                                                    == NSNumber *theA = @'A';
// [NSNumber numberWithInt:42]                                                      == NSNumber *fortyTwo = @42;
// [NSNumber numberWithUnsignedInt:42U]                                             == NSNumber *fortyTwoUnsigned = @42U;
// [NSNumber numberWithLong:42L]                                                    == NSNumber *fortyTwoLong = @42L;
// [NSNumber numberWithLongLong:42LL]                                               == NSNumber *fortyTwoLongLong = @42LL;
// [NSNumber numberWithFloat:3.141592654F]                                          == NSNumber *piFloat = @3.141592654F;
// [NSNumber numberWithDouble:3.1415926535]                                         == NSNumber *piDouble = @3.1415926535;
// [NSNumber numberWithBool:YES]                                                    == NSNumber *yesNumber = @YES;
// [NSNumber numberWithBool:NO]                                                     == NSNumber *noNumber = @NO;

#pragma mark Colors

// [color colorWithAlphaComponent:(CGFloat)] - задает новое значение alpha

#pragma mark Animations

// [UIView animateWithDuration:(NSTimeInterval) delay:(NSTimeInterval) options:(UIViewAnimationOptions) animations:^(void)animations completion:^(BOOL finished)completion]

// [UIView transitionFromView:(UIView *) toView:(UIView *) duration:(NSTimeInterval) options:(UIViewAnimationOptions) completion:^(BOOL finished)completion]

// [UIView transitionWithView:(UIView *) duration:(NSTimeInterval) options:(UIViewAnimationOptions) animations:^(void)animations completion:^(BOOL finished)completion]

// CATransition *transition = [CATransition new];
// transition.type = kCATransitionPush;
// transition.subtype = kCATransitionFromRight;
// transition.duration = 0.2;
// [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
// [self.view.layer addAnimation:transition forKey:@"transition"];

#pragma mark Stop performSelector

// [object cancelPreviousPerformRequestsWithTarget:target selector:@selector(selector:) object:object];

#pragma mark Threads

// Grand Central Dispatch

// dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)block);

// dispatch_async(dispatch_get_main_queue(), ^(void)block);

// dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void)block);

// dispatch_apply(count, dispatch_get_global_queue(0, 0), ^(size_t i)block); // многопоточный аналог цикла for (int i=0; i<=coint-1; i++) { }

// dispatch_queue_t queue = dispatch_queue_create("com.example.unique.identifier", NULL);
// dispatch_async(queue, ^(void)block);
// dispatch_release(queue);

// Perform Selector

// NSOperationQueue *queue = [NSOperationQueue new];
// NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:(id) selector:(SEL) object:(id)];
// [queue addOperation:operation];
// [self performSelectorOnMainThread:(SEL) withObject:(id) waitUntilDone:(BOOL)];

#pragma mark Scroll View

// [_scrollView scrollRectToVisible:(CGRect) animated:(BOOL)]; // прокручивает скролл вью

#pragma mark Lock Screen Play Music

// NSDictionary *currentlyPlayingTrackInfo = @{ MPMediaItemPropertyTitle : (NSString *) };
// [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = currentlyPlayingTrackInfo;

#pragma mark Singleton

// + (instancetype)sharedManager
// {
//     static dispatch_once_t once;
//     static id sharedManager;
//
//     dispatch_once(&once, ^(void)
//                   {
//                       sharedManager = [super new];
//                   });
//
//     return sharedManager;
// }

#pragma mark Add @property to category

// #import <objc/runtime.h>

// - (void)setObject:(Class *)object
// {
//     objc_setAssociatedObject(self, @selector(object), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
// }

// - (Class *)object
// {
//     return objc_getAssociatedObject(self, @selector(object));
// }

#pragma mark UITableView alphabet scroll indicator

// - (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
// {
//     return @[@"a", @"b", @"c"];
// }

#pragma mark Warnings

// #pragma GCC diagnostic push
// #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
//     place here some warning, needs to be hidden
// #pragma GCC diagnostic pop

#pragma mark System Version

// #if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
// #endif

// #if __IPHONE_OS_VERSION_MAX_REQUIRED < __IPHONE_8_0
// #endif

#pragma mark - Enum

// UIButton *button = [UIButton new];
// [button setTitle:@"title" forState:UIControlStateSelected|UIControlStateHighlighted];
// [button setSelected:YES];
// [button setHighlighted:YES];

// if ((button.state & (UIControlStateSelected|UIControlStateHighlighted)) == (UIControlStateSelected|UIControlStateHighlighted))
// {
//     // return YES;
// }
// else
// {
//     // return NO;
// }

#pragma mark - Attributes

// __attribute__((unavailable("description")));
// __attribute__((annotate("some_annotation")))

#pragma mark - UIViewController

// self.automaticallyAdjustsScrollViewInsets = NO;
// self.extendedLayoutIncludesOpaqueBars = YES;
//
// if (kSystemVersion < 7.0)
//     self.wantsFullScreenLayout = YES;

#pragma mark - Interface

#import <UIKit/UIKit.h>

/** Need to determine internet status */
#import "Reachability.h"

/** Need to send email and sms */
@import MessageUI;

/** Need to open addresses and coorinates on map */
@import MapKit;

typedef enum
{
    LGImageScalingModeAspectFill,
    LGImageScalingModeAspectFit
}
LGImageScalingMode;

typedef enum
{
    LGInternetStatusOff  = 0,
    LGInternetStatusWiFi = 1,
    LGInternetStatusWWAN = 2
}
LGInternetStatus;

#define LGHelperShared [LGHelper sharedHelper]

@interface LGHelper : NSObject

+ (instancetype)sharedHelper;

/** Unavailable, use + methods or +sharedHelper instead */
+ (instancetype)alloc __attribute__((unavailable("use + methods or +sharedHelper instead")));
/** Unavailable, use + methods or +sharedHelper instead */
+ (instancetype)allocWithZone:(struct _NSZone *)zone __attribute__((unavailable("use + methods or +sharedHelper instead")));
/** Unavailable, use + methods or +sharedHelper instead */
+ (instancetype)new __attribute__((unavailable("use + methods or +sharedHelper instead")));
/** Unavailable, use + methods or +sharedHelper instead */
- (instancetype)init __attribute__((unavailable("use + methods or +sharedHelper instead")));
/** Unavailable, use + methods or +sharedHelper instead */
- (id)copy __attribute__((unavailable("use + methods or +sharedHelper instead")));

#pragma mark - Device

+ (NSString *)devicePlatform;
+ (NSString *)deviceName;

#pragma mark - Unicode

+ (NSString *)stringByDecodingHTMLEntitiesInString:(NSString *)input;

#pragma mark - UIView

+ (UIView *)superviewForView:(UIView *)view withClass:(Class)superViewClass;
+ (UIView *)firstResponderInView:(UIView *)view;

#pragma mark - UIScrollView

+ (void)scrollView:(UIScrollView *)scrollView scrollRectToVisible:(CGRect)rect edgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated;
+ (void)scrollView:(UIScrollView *)scrollView scrollFirstResponderToVisibleAnimated:(BOOL)animated;
+ (void)scrollView:(UIScrollView *)scrollView scrollFirstResponderToVisibleWithEdgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated;
+ (void)scrollView:(UIScrollView *)scrollView focusOnView:(UIView *)view bottomShift:(CGFloat)bottomShift;
+ (void)scrollViewKillScroll:(UIScrollView *)scrollView;

#pragma mark - Images

+ (UIImage *)imageWithOrientationExifFix:(UIImage *)image;
+ (UIImage *)image1x1WithColor:(UIColor *)color;
+ (UIImage *)image:(UIImage *)image withAlpha:(CGFloat)alpha;
+ (UIImage *)image:(UIImage *)image withColor:(UIColor *)color;
+ (UIImage *)imageBlackAndWhite:(UIImage *)image;
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size scalingMode:(LGImageScalingMode)scalingMode;
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size scalingMode:(LGImageScalingMode)scalingMode backgroundColor:(UIColor *)backgroundColor;
+ (UIImage *)image:(UIImage *)image scaleWithMultiplier:(float)multiplier;
+ (UIImage *)image:(UIImage *)image roundWithRadius:(CGFloat)radius;
+ (UIImage *)image:(UIImage *)image roundWithRadius:(CGFloat)radius backgroundColor:(UIColor *)backgroundColor;
+ (UIImage *)image:(UIImage *)image cropCenterWithSize:(CGSize)size;
+ (UIImage *)image:(UIImage *)image cropCenterWithSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor;
+ (UIImage *)image:(UIImage *)image withMaskImage:(UIImage *)maskImage;
+ (UIImage *)imageFromView:(UIView *)view;
+ (UIImage *)imageFromView:(UIView *)view inPixels:(BOOL)inPixels;
+ (UIColor *)image:(UIImage *)image colorAtPixel:(CGPoint)point;

+ (BOOL)maskAlphaImage:(UIImage *)maskImage pointIsCorrect:(CGPoint)point;
+ (BOOL)maskAlphaImage:(UIImage *)maskImage pointIsCorrect:(CGPoint)point containerSize:(CGSize)containerSize;
+ (BOOL)maskBlackAndWhiteImage:(UIImage *)maskImage pointIsCorrect:(CGPoint)point;
+ (BOOL)maskBlackAndWhiteImage:(UIImage *)maskImage pointIsCorrect:(CGPoint)point containerSize:(CGSize)containerSize;

#pragma mark - Network Activity Indicator

+ (void)networkActivityIndicatorSetHidden:(BOOL)hidden;

#pragma mark - NSUserDefaults clear storage

+ (void)userDefaultsClear;

#pragma mark - Screenshot

+ (UIImage *)screenshotMakeInPixels:(BOOL)inPixels;
+ (UIImage *)screenshotMakeOfView:(UIView *)view inPixels:(BOOL)inPixels;

#pragma mark - Reachability

+ (Reachability *)reachabilityAddObserver:(id)target selector:(SEL)selector;
+ (Reachability *)reachabilityForHostName:(NSString *)hostName addObserver:(id)target selector:(SEL)selector;
+ (void)reachability:(Reachability *)reachability removeObserver:(id)target;
+ (NetworkStatus)reachabilityStatus;
+ (NetworkStatus)reachabilityStatusForHostName:(NSString *)hostName;

#pragma mark - Keyboard Notifications

+ (void)keyboardNotificationsAddToTarget:(id)target selector:(SEL)selector;
+ (void)keyboardNotificationsRemoveFromTarget:(id)target selector:(SEL)selector;
+ (void)keyboardAnimateWithNotificationUserInfo:(NSDictionary *)notificationUserInfo animations:(void(^)(CGFloat keyboardHeight))animations;

#pragma mark - Disk capacity

+ (uint64_t)diskGetFreeSpace;

#pragma mark - MIME Type

+ (NSString *)mimeTypeForPath:(NSString *)path;
+ (NSString *)mimeTypeForExtension:(NSString *)extension;

#pragma mark - IP address

+ (NSString *)ipAddressLocal;
+ (NSString *)ipAddressGlobal;

#pragma mark - MD5 hash

+ (NSString *)md5HashFromData:(NSData *)data;
+ (NSString *)md5HashFromString:(NSString *)string;

#pragma mark - SHA1 hash

+ (NSString *)sha1HashFromData:(NSData *)data;
+ (NSString *)sha1HashFromString:(NSString *)string;

#pragma mark - Open URL's

+ (void)urlOpenInSafari:(NSURL *)url;
+ (void)phoneCallToNumber:(NSString *)number;
+ (void)phoneCallWithConfirmationToNumber:(NSString *)number;
+ (void)emailSendToAddress:(NSString *)address;

#pragma mark - Address, Location, Coordinate

+ (void)addressOpenOnMap:(NSString *)address;
+ (void)addressOpenOnMapWithTrack:(NSString *)address;
+ (void)coordinateOpenOnMap:(CLLocationCoordinate2D)coordinate;
+ (void)coordinateOpenOnMapTrack:(CLLocationCoordinate2D)coordinate;

#pragma mark - Calendar

+ (void)calendarAddEventWithTitle:(NSString *)title startDate:(NSDate *)startDate duration:(NSTimeInterval)duration completionHandler:(void(^)(BOOL accessGranted, NSString *identifier))completionHandler;
+ (void)calendarRemoveEventWithId:(NSString *)identifier completionHandler:(void(^)(BOOL accessGranted))completionHandler;
+ (void)calendarRemoveEventWithTitle:(NSString *)title startDate:(NSDate *)startDate duration:(NSTimeInterval)duration completionHandler:(void(^)(BOOL accessGranted))completionHandler;

#pragma mark - Address Book

+ (void)addressBookAddContactWithImage:(UIImage *)image firstName:(NSString *)firstName lastName:(NSString *)lastName middleName:(NSString *)middleName nickname:(NSString *)nickname organization:(NSString *)organization jobTitle:(NSString *)jobTitle department:(NSString *)department birthday:(NSDate *)birthday phonesMobile:(NSArray *)phonesMobile phonesHome:(NSArray *)phonesHome email:(NSString *)email site:(NSString *)site country:(NSString *)country region:(NSString *)region city:(NSString *)city street:(NSString *)street zip:(NSString *)zip note:(NSString *)note completionHandler:(void(^)(BOOL accessGranted, NSString *identifier))completionHandler;

#pragma mark - Cookies

+ (void)cookiesClear;

#pragma mark - Strings

+ (NSString *)stringByCapitalizingFirstLetter:(NSString *)string;
+ (NSString *)stringByRemovingAllWhitespacesAndNewLine:(NSString *)string;
+ (NSString *)stringByRemovingAllNumbers:(NSString *)string;
+ (NSString *)stringByRemovingAllExeptNumbers:(NSString *)string;
+ (NSString *)stringByRemovingAllExeptPhoneSymbols:(NSString *)string;
+ (NSString *)string:(NSString *)string byRemovingAllExeptSymbols:(NSString *)symbols;
+ (NSString *)stringWithNonBreakingSpace;

#pragma mark - Animations

+ (void)animateStandardWithAnimations:(void(^)())animations completion:(void(^)(BOOL finished))completion;
+ (void)animateStandardWithDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;
+ (void)animateStandardWithDelay:(NSTimeInterval)delay animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;
+ (void)animateStandardWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

#pragma mark - Colors

/** 0-255, 0-255, 0-255, 0.f-1.f */
+ (UIColor *)colorWithRGB_red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;
/** #000000 */
+ (UIColor *)colorWithHEX:(UInt32)hex;
/** #000000 */
+ (NSUInteger)colorHEX:(UIColor *)color;
+ (UIColor *)colorMixedInRGB:(UIColor *)color1 andColor:(UIColor *)color2 percent:(CGFloat)percent;
+ (UIColor *)colorMixedInLAB:(UIColor *)color1 andColor:(UIColor *)color2 percent:(CGFloat)percent;
/** 0-255 */
+ (UIColor *)color:(UIColor *)color darkerOnRGB:(NSUInteger)k;
/** 0-255 */
+ (UIColor *)color:(UIColor *)color lighterOnRGB:(NSUInteger)k;
/** 0.f-1.f */
+ (UIColor *)color:(UIColor *)color darkerOn:(CGFloat)k;
/** 0.f-1.f */
+ (UIColor *)color:(UIColor *)color lighterOn:(CGFloat)k;
/** 0.f-100.f */
+ (UIColor *)color:(UIColor *)color darkerOnPercent:(CGFloat)percent;
/** 0.f-100.f */
+ (UIColor *)color:(UIColor *)color lighterOnPercent:(CGFloat)percent;
+ (NSArray *)colorConvertRGBtoXYZ:(UIColor *)color;
+ (NSArray *)colorConvertRGBtoLAB:(UIColor *)color;
+ (NSArray *)colorConvertXYZtoLAB:(NSArray *)xyzArray;
+ (NSArray *)colorConvertLABtoXYZ:(NSArray *)labArray;
+ (UIColor *)colorConvertXYZtoRGB:(NSArray *)xyzArray;
+ (UIColor *)colorConvertLABtoRGB:(NSArray *)labArray;

#pragma mark - Email

+ (BOOL)emailIsCorrect:(NSString *)string;

/** 
 Return NO if device can not send mail.
 Do not forget about weak referens to self for completionHandler and dismissCompletionHandler blocks.
 */
- (BOOL)emailSendToAddresses:(NSArray *)addresses
                       theme:(NSString *)theme
                     message:(NSString *)message
            inViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
                setupHandler:(void(^)(MFMailComposeViewController *viewController))setupHandler
    presentCompletionHandler:(void(^)())presentCompletionHandler
           completionHandler:(void(^)(MFMailComposeResult result, NSError *error))completionHandler
    dismissCompletionHandler:(void(^)())dismissCompletionHandler;

/** Return NO if device can not send mail */
- (BOOL)emailSendToAddresses:(NSArray *)addresses
                       theme:(NSString *)theme
                     message:(NSString *)message
            inViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
                    delegate:(id<MFMailComposeViewControllerDelegate>)delegate
                setupHandler:(void(^)(MFMailComposeViewController *viewController))setupHandler
    presentCompletionHandler:(void(^)())presentCompletionHandler;

#pragma mark - Phone && SMS

+ (BOOL)phoneNumberIsCorrect:(NSString *)string;

/** 
 Return NO if device can not send text.
 Do not forget about weak referens to self for completionHandler and dismissCompletionHandler blocks.
 */
- (BOOL)smsSendWithText:(NSString *)text
       inViewController:(UIViewController *)viewController
               animated:(BOOL)animated
           setupHandler:(void(^)(MFMessageComposeViewController *viewController))setupHandler
presentCompletionHandler:(void(^)())presentCompletionHandler
      completionHandler:(void(^)(MessageComposeResult result))completionHandler
dismissCompletionHandler:(void(^)())dismissCompletionHandler;

/** Return NO if device can not send text */
- (BOOL)smsSendWithText:(NSString *)text
       inViewController:(UIViewController *)viewController
               animated:(BOOL)animated
               delegate:(id<MFMessageComposeViewControllerDelegate>)delegate
           setupHandler:(void(^)(MFMessageComposeViewController *viewController))setupHandler
presentCompletionHandler:(void(^)())presentCompletionHandler;

#pragma mark - UIImagePickerController

/**
 Return NO if source type unavailable.
 Do not forget about weak referens to self for setupHandler, presentCompletionHandler, completionHandler and dismissCompletionHandler blocks.
 */
- (BOOL)imagePickerControllerShowWithActionSheetInView:(UIView *)view
                                      inViewController:(UIViewController *)viewController
                                              animated:(BOOL)animated
                                          setupHandler:(void(^)(UIImagePickerController *imagePickerController))setupHandler
                              presentCompletionHandler:(void(^)())presentCompletionHandler
                                     completionHandler:(void(^)(UIImage *image))completionHandler
                              dismissCompletionHandler:(void(^)())dismissCompletionHandler;

/**
 Return NO if source type unavailable.
 Do not forget about weak referens to self for setupHandler and presentCompletionHandler blocks.
 */
- (BOOL)imagePickerControllerShowWithActionSheetInView:(UIView *)view
                                      inViewController:(UIViewController *)viewController
                                              animated:(BOOL)animated
                                              delegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate
                                          setupHandler:(void(^)(UIImagePickerController *imagePickerController))setupHandler
                              presentCompletionHandler:(void(^)())presentCompletionHandler;

/**
 Return NO if source type unavailable.
 Do not forget about weak referens to self for completionHandler and dismissCompletionHandler blocks.
 */
- (BOOL)imagePickerControllerShowWithSourceType:(UIImagePickerControllerSourceType)sourceType
                               inViewController:(UIViewController *)viewController
                                       animated:(BOOL)animated
                                   setupHandler:(void(^)(UIImagePickerController *imagePickerController))setupHandler
                       presentCompletionHandler:(void(^)())presentCompletionHandler
                              completionHandler:(void(^)(UIImage *image))completionHandler
                       dismissCompletionHandler:(void(^)())dismissCompletionHandler;

/** Return NO if source type unavailable */
- (BOOL)imagePickerControllerShowWithSourceType:(UIImagePickerControllerSourceType)sourceType
                               inViewController:(UIViewController *)viewController
                                       animated:(BOOL)animated
                                       delegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate
                                   setupHandler:(void(^)(UIImagePickerController *imagePickerController))setupHandler
                       presentCompletionHandler:(void(^)())presentCompletionHandler;

#pragma mark - UIDocumentInteractionController

/** 
 Returns NO if the item could not be previewed.
 Do not forget about weak referens to self for didEndPreviewHandler block.
 */
- (BOOL)documentInteractionControllerShowWithFileURL:(NSURL *)fileUrl
                                    inViewController:(UIViewController *)viewController
                                            animated:(BOOL)animated
                                        setupHandler:(void(^)(UIDocumentInteractionController *documentInteractionController))setupHandler
                                didEndPreviewHandler:(void(^)())didEndPreviewHandler;

/** Returns NO if the item could not be previewed */
- (BOOL)documentInteractionControllerShowWithFileURL:(NSURL *)fileUrl
                                    inViewController:(UIViewController *)viewController
                                            animated:(BOOL)animated
                                            delegate:(id<UIDocumentInteractionControllerDelegate>)delegate
                                        setupHandler:(void(^)(UIDocumentInteractionController *documentInteractionController))setupHandler;

#pragma mark - UIActivityViewController

- (void)activityViewControllerShowWithFilesUrl:(NSArray *)filesUrl
                         applicationActivities:(NSArray *)applicationActivities
                         excludedActivityTypes:(NSArray *)excludedActivityTypes
                              inViewController:(UIViewController *)viewController
                                      animated:(BOOL)animated
                                  setupHandler:(void(^)(UIActivityViewController *activityViewController))setupHandler
                             completionHandler:(void(^)(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError))completionHandler
                      presentCompletionHandler:(void(^)())presentCompletionHandler;

#pragma mark - MWPhotoBrowser

// - (void)photoBrowserShow
 
#pragma mark - Processor

// - (NSUInteger)processorNumberOfCores;
// - (NSUInteger)processorNumberOfActiveCores;

@end

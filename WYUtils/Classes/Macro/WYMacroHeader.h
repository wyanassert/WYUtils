//
//  WYMacroHeader.h
//  Pods
//
//  Created by wyan on 2018/11/26.
//

#ifndef WYMacroHeader_h
#define WYMacroHeader_h

#define WYWIDTH(view) view.frame.size.width
#define WYHEIGHT(view) view.frame.size.height
#define WYLEFT(view) view.frame.origin.x
#define WYTOP(view) view.frame.origin.y
#define WYBOTTOM(view) (view.frame.origin.y + view.frame.size.height)
#define WYRIGHT(view) (view.frame.origin.x + view.frame.size.width)

#ifndef WY_DESIGN_WIDTH
#define WY_DESIGN_WIDTH (375)
#endif

#ifndef WY_DESIGN_HEIGHT
#define WY_DESIGN_HEIGHT (667)
#endif

#ifndef WX_DESIGN_WIDTH
#define WX_DESIGN_WIDTH (375)
#endif

#ifndef WX_DESIGN_HEIGHT
#define WX_DESIGN_HEIGHT (812)
#endif

#ifndef WZ_DESIGN_WIDTH
#define WZ_DESIGN_WIDTH (414)
#endif

#ifndef WZ_DESIGN_HEIGHT
#define WZ_DESIGN_HEIGHT (896)
#endif

#ifndef WY_SCREEN_WIDTH
#define WY_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#endif

#ifndef WY_SCREEN_HEIGHT
#define WY_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#endif

#ifndef WYX
#define WYX(x)  ((x) * WY_SCREEN_WIDTH / WY_DESIGN_WIDTH)
#endif

#ifndef WYY
#define WYY(y)  ((y) * WY_SCREEN_HEIGHT / WY_DESIGN_HEIGHT)
#endif

#ifndef WYSIZE
#define WYSIZE(x, y) CGSizeMake(WYX(x), WYY(y))
#endif

#ifndef WYMIN
#define WYMIN(x) (x<0?MAX(WYX(x), WYY(x)):MIN(WYX(x), WYY(x)))
#endif

#ifndef WYMINSIZE
#define WYMINSIZE(x, y) CGSizeMake(WYMIN(x), WYMIN(y))
#endif

#ifndef WYXSIZE
#define WYXSIZE(x, y) CGSizeMake(WYX(x), WYX(y))
#endif

#ifndef WYYSIZE
#define WYYSIZE(x, y) CGSizeMake(WYY(x), WYY(y))
#endif

#ifndef WXX //Apply For iPhoneX 375*812
#define WXX(x)  ((x) * WY_SCREEN_WIDTH / WX_DESIGN_WIDTH)
#endif

#ifndef WXY
#define WXY(y)  ((y) * WY_SCREEN_HEIGHT / WX_DESIGN_HEIGHT)
#endif

#ifndef WXSIZE
#define WXSIZE(x, y) CGSizeMake(WXX(x), WXY(y))
#endif

#ifndef WXMIN
#define WXMIN(x) (x<0?MAX(WXX(x), WXY(x)):MIN(WXX(x), WXY(x)))
#endif

#ifndef WXMINSIZE
#define WXMINSIZE(x, y) CGSizeMake(WXMIN(x), WXMIN(y))
#endif

#ifndef WXXSIZE
#define WXXSIZE(x, y) CGSizeMake(WXX(x), WXX(y))
#endif

#ifndef WXYSIZE
#define WXYSIZE(x, y) CGSizeMake(WXY(x), WXY(y))
#endif

#ifndef WZX //Apply For iPhone11 Pro Max 414*896
#define WZX(x)  ((x) * WY_SCREEN_WIDTH / WZ_DESIGN_WIDTH)
#endif

#ifndef WZY
#define WZY(y)  ((y) * WY_SCREEN_HEIGHT / WZ_DESIGN_HEIGHT)
#endif

#ifndef WZSIZE
#define WZSIZE(x, y) CGSizeMake(WZX(x), WZY(y))
#endif

#ifndef WZMIN
#define WZMIN(x) (x<0?MAX(WZX(x), WZY(x)):MIN(WZX(x), WZY(x)))
#endif

#ifndef WZMINSIZE
#define WZMINSIZE(x, y) CGSizeMake(WZMIN(x), WZMIN(y))
#endif

#ifndef WZXSIZE
#define WZXSIZE(x, y) CGSizeMake(WZX(x), WZX(y))
#endif

#ifndef WZYSIZE
#define WZYSIZE(x, y) CGSizeMake(WZY(x), WZY(y))
#endif

//execute time interval
#ifndef WYTICK
#define WYTICK   CFTimeInterval startTime = CACurrentMediaTime();
#endif

#ifndef WYTOCK
#define WYTOCK   NSLog(@"Time: %lf", (CACurrentMediaTime() - startTime));startTime = CACurrentMediaTime();
#endif

#ifndef WYAS_SINGLETON

#define WYAS_SINGLETON( __class ) \
+ (__class *) sharedInstance;

#endif

#ifndef WYDEF_SINGLETON

#define WYDEF_SINGLETON( __class ) \
+ (__class *) sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}
#endif

#ifndef wy_dispatch_queue_async_safe
#define wy_dispatch_queue_async_safe(queue, block)\
if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
block();\
} else {\
dispatch_async(queue, block);\
}
#endif

#ifndef wy_dispatch_main_async_safe
#define wy_dispatch_main_async_safe(block) wy_dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

// Color
#ifndef WYColorFromHexWithAlpha
#define WYColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#endif

#ifndef WYColorFromHex
#define WYColorFromHex(hexValue)            WYColorFromHexWithAlpha(hexValue,1.0)
#endif

#ifndef WYColorFromRGBA
#define WYColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

#ifndef WYColorFromRGB
#define WYColorFromRGB(r,g,b)               WYColorFromRGBA(r,g,b,1.0)
#endif

#ifndef WYColorFromHSB
#define WYColorFromHSB(h,s,b)               [UIColor colorWithHue:h saturation:s brightness:b alpha:1.0f]
#endif

#ifndef WY_SINGLETON_AS

#define WY_SINGLETON_AS( __class ) \
+ (__class *) sharedInstance;

#endif

#ifndef WY_SINGLETON_DEF

#define WY_SINGLETON_DEF( __class ) \
+ (__class *) sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}
#endif

#define kWYDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define kWYTempPath NSTemporaryDirectory()
#define kWYCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#pragma mark iOS Version

#define WY_IOS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define WY_IOS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define WY_IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define WY_IOS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define WY_IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define WY_IOS_SDK_MORE_THAN_OR_EQUAL(__num) [UIDevice currentDevice].systemVersion.floatValue >= (__num)
#define WY_IOS_SDK_MORE_THAN(__num) [UIDevice currentDevice].systemVersion.floatValue > (__num)
#define WY_IOS_SDK_LESS_THAN(__num) [UIDevice currentDevice].systemVersion.floatValue < (__num)

#define kWYPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kWYPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define WY_TARGETED_DEVICE_IS_IPHONE_X   (kWYPhone && (WY_SCREEN_HEIGHT == 812 || WY_SCREEN_HEIGHT == 896))
#define WY_TARGETED_DEVICE_IS_IPAD_iOS12 (kWYPad && WY_IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"12.0"))

//iPhone X 适配的
#define WYDeviceNaviHeight      (WY_TARGETED_DEVICE_IS_IPHONE_X ? 88 : WY_TARGETED_DEVICE_IS_IPAD_iOS12 ? 70 : 64)
#define WYDeviceTabbarHeight    (WY_TARGETED_DEVICE_IS_IPHONE_X ? 83 : 49)
#define WYDeviceBottomHeight    (WY_TARGETED_DEVICE_IS_IPHONE_X ? 34 : 0)

#define WYStatusBarHeight MIN([[UIApplication sharedApplication] statusBarFrame].size.width, [[UIApplication sharedApplication] statusBarFrame].size.height)

#define kWYStringEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#define kWYArrayEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define kWYDictEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
#define kWYObjectEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#define kWYAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kWYSystemVersion [[UIDevice currentDevice] systemVersion]

// 把为nil的字符串返回@""
#define WY_AVOID_NIL_STRING(x) ((x) ?: @"")
#define WY_AVOID_NIL_DIC(x) ((x) ?: @{})
#define WY_AVOID_NIL_ARRAY(x) ((x) ?: @[])


// 判断当前运行在主线程
#define ASSERT_MAIN_THREAD ASSERT([NSThread currentThread] == [NSThread mainThread]);
#define ASSERT_NO_MAIN_THREAD() ASSERT([NSThread currentThread] != [NSThread mainThread])


/* 宏字符串操作，避免在宏里面嵌套使用宏带来的问题 */
#define WY_STRING_CONCAT(A, B) WY_STRING_CONCAT_(A, B)
#define WY_STRING_CONCAT_(A, B) A ## B
// Weak Strong
#define WY_WEAK_SELF(VAR) \
__weak __typeof__(VAR) WY_STRING_CONCAT(VAR, _weak_) = (VAR)

#define WY_STRONG_SELF(VAR) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof__(VAR) VAR = WY_STRING_CONCAT(VAR, _weak_) \
_Pragma("clang diagnostic pop")

#endif /* WYMacroHeader_h */

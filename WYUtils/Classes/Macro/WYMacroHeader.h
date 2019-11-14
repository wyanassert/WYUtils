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

//execute time interval
#ifndef WYTICK
#define WYTICK   CFTimeInterval startTime = CACurrentMediaTime();
#endif

#ifndef WYTOCK
#define WYTOCK   NSLog(@"Time: %lf", (CACurrentMediaTime() - startTime));startTime = CACurrentMediaTime();
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

#endif /* WYMacroHeader_h */

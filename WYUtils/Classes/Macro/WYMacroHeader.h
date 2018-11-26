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
#define WYMIN(x) (x<0?MAX(S_X(x), S_Y(x)):MIN(S_X(x), S_Y(x)))
#endif

#ifndef WYMINSIZE
#define WYMINSIZE(x, y) CGSizeMake(WYMIN(x), WYMIN(y))
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

#endif /* WYMacroHeader_h */

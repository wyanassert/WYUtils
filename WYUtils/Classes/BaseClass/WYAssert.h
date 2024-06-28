//
//  WYAssert.h
//  WYUtils
//
//  Created by wyan on 2024/6/28.
//

#import <UIKit/UIKit.h>
#define ASSERT(x) if(!(x)){AssertBreakProintCall(__FILE__, __FUNCTION__, __LINE__); assert(0);}

#ifdef __cplusplus
extern "C"
{
#endif
    void AssertBreakProintCall(const char* pszFile, const char* pszFunction, unsigned long iLine);
#ifdef __cplusplus
}
#endif

#ifdef __cplusplus
extern "C"
{
#endif
int AmIBeingDebugged(void);
#ifdef __cplusplus
}
#endif

// 判断当前运行在主线程
#define ASSERT_MAIN_THREAD ASSERT([NSThread currentThread] == [NSThread mainThread]);
#define ASSERT_NO_MAIN_THREAD() ASSERT([NSThread currentThread] != [NSThread mainThread])

#ifdef DEBUG
    #define WYDebugBreak() if(AmIBeingDebugged()) {NSLog(@"请注意，这里有断言！！！"); raise(SIGTRAP); }
    #define WYDebugBreakPoint() time(NULL)
    
    #define WYASSERT(x) {if (!(x)) {WYDebugBreak();}}
    #define WYASSERTLOG(msg) {NSLog(@"请注意，这里有断言！！！-- %@", msg);QMASSERT(0);}
#else
    #define WYDebugBreak()
    #define WYDebugBreakPoint()
    #define WYASSERT(x)
    #define WYASSERTLOG(msg)
#endif

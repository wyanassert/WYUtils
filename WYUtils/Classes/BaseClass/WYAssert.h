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

// 判断当前运行在主线程
#define ASSERT_MAIN_THREAD ASSERT([NSThread currentThread] == [NSThread mainThread]);
#define ASSERT_NO_MAIN_THREAD() ASSERT([NSThread currentThread] != [NSThread mainThread])

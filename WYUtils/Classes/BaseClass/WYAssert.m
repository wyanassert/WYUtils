//
//  WYAssert.m
//  WYUtils
//
//  Created by wyan on 2024/6/28.
//

#import "WYAssert.h"
#include <sys/sysctl.h>

void AssertBreakProintCall(const char* pszFile, const char* pszFunction, unsigned long iLine)
{
    // do while 防止被优化
    // 写代码的时候在这里下一个断点。
    do {
        // release 版本会打印关键信息出来
#ifndef DEBUG
        NSString* strAssert = [NSString stringWithFormat:@"%s, %s:%lu", pszFunction, pszFile, iLine];
        NSString* strToLog = [NSString stringWithFormat:@"*** Assertion failure in (%@).", strAssert];
        NSLog(@"%@", strToLog);
#endif
    } while (0);
}

int AmIBeingDebugged(void)
// Returns true if the current process is being debugged (either
// running under the debugger or has a debugger attached post facto).
{
    int                 junk;
    int                 mib[4];
    struct kinfo_proc   info;
    size_t              size;
    
    // Initialize the flags so that, if sysctl fails for some bizarre
    // reason, we get a predictable result.
    
    info.kp_proc.p_flag = 0;
    
    // Initialize mib, which tells sysctl the info we want, in this case
    // we're looking for information about a specific process ID.
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();
    
    // Call sysctl.
    
    size = sizeof(info);
    junk = sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
    assert(junk == 0);
    
    // We're being debugged if the P_TRACED flag is set.
    
    return ( (info.kp_proc.p_flag & P_TRACED) != 0 );
}

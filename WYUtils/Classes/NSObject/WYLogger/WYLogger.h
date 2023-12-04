//
//  WYLogger.h
//  WYUtils_Example
//
//  Created by wyan on 2023/12/4.
//  Copyright © 2023 wyanassert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYMacroHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WYLogLevel)
{
    /// Detailed information on the flow through the system.
    WYLogLevelDebug = 1,
    /// Interesting runtime events (startup/shutdown), should be conservative and keep to a minimum.
    WYLogLevelInfo = 2,
    /// Other runtime situations that are undesirable or unexpected, but not necessarily "wrong".
    WYLogLevelWarn = 3,
    /// Other runtime errors or unexpected conditions.
    WYLogLevelError = 4,
};

@interface WYLogger : NSObject

WYAS_SINGLETON(WYLogger)

- (void)writeLogFile:(const char *)file
            function:(const char *)function
                line:(int)line
               level:(WYLogLevel)level
                      tag:(NSString *)tag
                   format:(NSString *)format, ... NS_FORMAT_FUNCTION(6,7);
- (void)writeLogFile:(const char *)file
            function:(const char *)function
                line:(int)line
               level:(WYLogLevel)level
                      tag:(NSString *)tag
                   format:(NSString *)format
                     args:(va_list)args;
- (void)writeLogFile:(const char *)file
            function:(const char *)function
                line:(int)line
               level:(WYLogLevel)level
                      tag:(NSString *)tag
                     body:(NSString *)body;
@end

#pragma mark - Macro

#ifndef WYLogWithLevelAndTag
#define WYLogWithLevelAndTag(lvl, tg, frmt, ...) [[WYLogger sharedInstance] writeLogFile:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ level:lvl tag:tg format:frmt, ##__VA_ARGS__];
#endif

NS_ASSUME_NONNULL_END

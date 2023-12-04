//
//  WYLogger.m
//  WYUtils_Example
//
//  Created by wyan on 2023/12/4.
//  Copyright © 2023 wyanassert. All rights reserved.
//

#import "WYLogger.h"

@implementation WYLogger

WYDEF_SINGLETON(WYLogger)

- (void)writeLogFile:(const char *)file
            function:(const char *)function
                line:(int)line
               level:(WYLogLevel)level
                      tag:(NSString *)tag
                   format:(NSString *)format, ...
{
    va_list ap;
    va_start (ap, format);
    [self writeLogFile:file
              function:function
                  line:line
                 level:level
                   tag:tag
                format:format
                  args:ap];
    va_end(ap);
}

- (void)writeLogFile:(const char *)file
            function:(const char *)function
                line:(int)line
               level:(WYLogLevel)level
                      tag:(NSString *)tag
                   format:(NSString *)format
                     args:(va_list)args
{
    NSString *body = [[NSString alloc] initWithFormat:format arguments:args];
    [self writeLogFile:file
              function:function
                  line:line
                 level:level
                   tag:tag
                  body:body];
}

- (void)writeLogFile:(const char *)file
            function:(const char *)function
                line:(int)line
               level:(WYLogLevel)level
                 tag:(NSString *)tag
                body:(NSString *)body
{
    NSString *fileStr = [NSString stringWithCString:file encoding:NSASCIIStringEncoding];
    NSString *funcStr = [NSString stringWithCString:function encoding:NSASCIIStringEncoding];
    NSString *logString = [NSString stringWithFormat:@"[level-%lu][%@][%@ %@ %d] %@", (unsigned long)level, WY_AVOID_NIL_STRING(tag), fileStr, funcStr, line, WY_AVOID_NIL_STRING(body)];
    NSLog(@"%@", logString);
}

@end

//
//  UIDevice+WYUtils.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/11/15.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (WYUtils)

+ (NSString *)macAddress;
+ (NSUInteger)ramSize;
+ (NSUInteger)cpuNumber;
+ (NSString *)systemVersion;
+ (BOOL)hasCamera;
+ (NSUInteger)totalMemoryBytes;
+ (NSUInteger)freeMemoryBytes;
+ (NSUInteger)totalDiskSpaceBytes;
+ (NSUInteger)freeDiskSpaceBytes;

@end

NS_ASSUME_NONNULL_END

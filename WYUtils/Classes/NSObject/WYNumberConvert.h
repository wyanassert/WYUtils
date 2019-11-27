//
//  WYNumberConver.h
//  AFNetworking
//
//  Created by wyan on 2019/11/27.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYNumberConvert : NSObject

- (instancetype)initWithSourceNumberList:(NSArray<NSNumber *> *)sourceNumberList andTargetNumberList:(NSArray<NSNumber *> *)targetNumberList;

- (CGFloat)convertFromSourceValue:(CGFloat)sourceValue;
- (CGFloat)sourceValueFromTarget:(CGFloat)targetValue;

- (CGFloat)convertValue:(CGFloat)value fromList:(NSArray<NSNumber *> *)sourceList toTarget:(NSArray<NSNumber *> *)targetList;

@end

NS_ASSUME_NONNULL_END

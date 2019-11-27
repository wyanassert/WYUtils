//
//  WYNumberConver.m
//  AFNetworking
//
//  Created by wyan on 2019/11/27.
//

#import "WYNumberConvert.h"


@interface WYNumberConvert ()

@property (nonatomic, strong) NSArray<NSNumber *> *sourceNumberList;
@property (nonatomic, strong) NSArray<NSNumber *> *targetNumberList;

@end

@implementation WYNumberConvert

- (instancetype)initWithSourceNumberList:(NSArray<NSNumber *> *)sourceNumberList andTargetNumberList:(NSArray<NSNumber *> *)targetNumberList {
    self = [super init];
    if (self) {
        sourceNumberList = [sourceNumberList sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
            if(obj1.floatValue < obj2.floatValue) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if(obj1.floatValue > obj2.floatValue) {
                return (NSComparisonResult)NSOrderedDescending;
            } else {
                return (NSComparisonResult)NSOrderedSame;
            }
        }];
        targetNumberList = [targetNumberList sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
            if(obj1.floatValue < obj2.floatValue) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if(obj1.floatValue > obj2.floatValue) {
                return (NSComparisonResult)NSOrderedDescending;
            } else {
                return (NSComparisonResult)NSOrderedSame;
            }
        }];
        NSUInteger minLength = MIN(sourceNumberList.count, targetNumberList.count);
        _sourceNumberList = [sourceNumberList subarrayWithRange:NSMakeRange(0, minLength)];
        _targetNumberList = [targetNumberList subarrayWithRange:NSMakeRange(0, minLength)];
    }
    return self;
}

- (CGFloat)convertFromSourceValue:(CGFloat)sourceValue {
    return [self convertValue:sourceValue fromList:self.sourceNumberList toTarget:self.targetNumberList];
}

- (CGFloat)sourceValueFromTarget:(CGFloat)targetValue {
    return [self convertValue:targetValue fromList:self.targetNumberList toTarget:self.sourceNumberList];
}

- (CGFloat)convertValue:(CGFloat)value fromList:(NSArray<NSNumber *> *)sourceList toTarget:(NSArray<NSNumber *> *)targetList {
    if(sourceList.count < 2) {
        return value;
    }
    value = MIN(sourceList.lastObject.floatValue, MAX(sourceList.firstObject.floatValue, value));
    NSNumber *lowerNumber = @(0);
    NSUInteger baseIndex = 0;
    for (NSNumber *number in sourceList) {
        if(number.floatValue <= value) {
            lowerNumber = number;
            baseIndex++;
        } else {
            break;
        }
    }
    baseIndex--;//0~n-1
    CGFloat baseValue = targetList[baseIndex].floatValue;
    CGFloat scale = baseIndex < sourceList.count-1?(value - [sourceList objectAtIndex:baseIndex].floatValue)/([sourceList objectAtIndex:(baseIndex + 1)].floatValue - [sourceList objectAtIndex:baseIndex].floatValue):0;
    
    return baseIndex < targetList.count-1?[targetList objectAtIndex:baseIndex].floatValue + scale * ([targetList objectAtIndex:(baseIndex + 1)].floatValue - [targetList objectAtIndex:baseIndex].floatValue):baseValue;
}

@end

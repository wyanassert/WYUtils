//
//  NSArray+SafeValue.m
//  WYUtils
//
//  Created by wyan on 2024/6/28.
//

#import "NSArray+SafeValue.h"

@implementation NSArray (SafeValue)

- (id)objectAtSafeIndex:(NSUInteger)index ofClassType:(Class)classType
{
    id retObject = nil;
    if (index < self.count)
    {
        retObject = [self objectAtIndex:index];
        if (![retObject isKindOfClass:classType])
        {
            NSLog(@"error objectAtSafeIndex:期待从数组中获取%@对象，却取到了%@对象",NSStringFromClass(classType),NSStringFromClass([retObject class]));
            retObject = nil;
        }
    }
    return retObject;
}

- (NSUInteger)indexOfExactObject:(id)anObject
{
    __block NSUInteger index = NSNotFound;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == anObject)
        {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

@end

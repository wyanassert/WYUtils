//
//  WYCollectionMutableDeepCopy.m
//  WYUtils_Example
//
//  Created by wyan on 2023/12/8.
//  Copyright © 2023 wyanassert. All rights reserved.
//

#import "WYCollectionMutableDeepCopy.h"

@implementation NSDictionary (MutableDeepCopy)
-(NSMutableDictionary *)wyMutableDeepCopy
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    //新建一个NSMutableDictionary对象，大小为原NSDictionary对象的大小
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id copyValue = nil;
        if ([obj respondsToSelector:@selector(wyMutableDeepCopy)])
        {
            //如果key对应的元素可以响应wyMutableDeepCopy方法(还是NSDictionary)，调用wyMutableDeepCopy方法复制
            copyValue = [obj performSelector:@selector(wyMutableDeepCopy)];
        }
        else if ([obj conformsToProtocol:@protocol(NSMutableCopying)] &&
                 [obj respondsToSelector:@selector(mutableCopyWithZone:)])
        {
            copyValue = [obj mutableCopy];
        }
        else if ([obj conformsToProtocol:@protocol(NSCopying)] &&
                 [obj respondsToSelector:@selector(copyWithZone:)])
        {
            copyValue = [obj copy];//
        }
        if (copyValue)
        {
            [dict setObject:copyValue forKey:key];
        }
        else
        {
            [dict setObject:obj forKey:key];
            NSAssert2(NO, @"NSDictionary (MutableDeepCopy) dict:%@ errorKey:%@",self , key);
        }
    }];
    return dict;
}
@end

@implementation NSArray (MutableDeepCopy)
-(NSMutableArray *)wyMutableDeepCopy
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self count]];
    //新建一个NSMutableArray对象，大小为原NSArray对象的大小
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id copyValue= nil;
        if ([obj respondsToSelector:@selector(wyMutableDeepCopy)])
        {
            //如果item可以响应wyMutableDeepCopy方法(还是NSDictionary)，调用wyMutableDeepCopy方法复制
            copyValue = [obj performSelector:@selector(wyMutableDeepCopy)];
        }
        else if ([obj conformsToProtocol:@protocol(NSMutableCopying)] &&
                 [obj respondsToSelector:@selector(mutableCopyWithZone:)])
        {
            copyValue = [obj mutableCopy];
        }
        else if ([obj conformsToProtocol:@protocol(NSCopying)] &&
                 [obj respondsToSelector:@selector(copyWithZone:)])
        {
            copyValue = [obj copy];
        }
        if (copyValue)
        {
            [array addObject:copyValue];
        }
        else
        {
            [array addObject:obj];
            //NSAssert3(NO, @"NSArray (MutableDeepCopy) array:%@ errorItem:%@ index:%lu",self , obj, (unsigned long)idx);
        }
    }];
    return array;
}
@end

@implementation NSSet (MutableDeepCopy)
-(NSMutableSet *)wyMutableDeepCopy
{
    NSMutableSet *set = [[NSMutableSet alloc] initWithCapacity:[self count]];
    //新建一个NSMutableArray对象，大小为原NSArray对象的大小
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        id copyValue;
        if ([obj respondsToSelector:@selector(wyMutableDeepCopy)])
        {
            //如果item可以响应wyMutableDeepCopy方法(还是NSDictionary)，调用wyMutableDeepCopy方法复制
            copyValue = [obj performSelector:@selector(wyMutableDeepCopy)];
        }
        else if ([obj conformsToProtocol:@protocol(NSMutableCopying)] &&
                 [obj respondsToSelector:@selector(mutableCopyWithZone:)])
        {
            copyValue = [obj mutableCopy];
        }
        else if ([obj conformsToProtocol:@protocol(NSCopying)] &&
                 [obj respondsToSelector:@selector(copyWithZone:)])
        {
            copyValue = [obj copy];
        }
        if (copyValue)
        {
            [set addObject:copyValue];
        }
        else
        {
            [set addObject:obj];
            NSAssert2(NO, @"NSSet (MutableDeepCopy) set:%@ errorItem:%@",self , obj);
        }
    }];
    return set;
}
@end

//
//  NSArray+SafeValue.h
//  WYUtils
//
//  Created by wyan on 2024/6/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SafeValue)

/**
 NSArray安全取容器方法，越界、类型不正确都返回nil
 
 @b Tag 安全 容器 数组 下标 类型

 @param index 下标
 @param classType 期待取出来的数据类型
 @return 实际对象
 */
- (id)objectAtSafeIndex:(NSUInteger)index ofClassType:(Class)classType;

/**
 indexOfObject是根据isEqual方法判断的，这个方法是根据指针地址判断的
 
 @b Tag 容器 数组 下标 指针

 @param anObject 对象
 @return 对象在Array中的下标，如果不存在，返回NSNotFound
 */
- (NSUInteger)indexOfExactObject:(id)anObject;

@end

NS_ASSUME_NONNULL_END

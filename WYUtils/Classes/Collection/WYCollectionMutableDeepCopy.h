//
//  WYCollectionMutableDeepCopy.h
//  WYUtils_Example
//
//  Created by wyan on 2023/12/8.
//  Copyright © 2023 wyanassert. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//字典里的所有Value都至少要实现NSCopy协议的深拷贝（特别是自定义的类）
@interface NSDictionary (MutableDeepCopy)

-(NSMutableDictionary *)wyMutableDeepCopy;

@end

//所有的元素都至少要实现NSCopy协议的深拷贝（特别是自定义的类）
@interface NSArray (MutableDeepCopy)

-(NSMutableArray *)wyMutableDeepCopy;

@end

//所有的元素都至少要实现NSCopy协议的深拷贝（特别是自定义的类）
@interface NSSet (MutableDeepCopy)

-(NSMutableArray *)wyMutableDeepCopy;

@end

NS_ASSUME_NONNULL_END

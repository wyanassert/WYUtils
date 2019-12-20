//
//  WYSyncOperation.h
//  CocoaLumberjack
//
//  Created by wyan on 2019/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define WYSyncOperationCancelToken NSMutableDictionary*

@class WYSyncOperation;

typedef BOOL(^WYSyncBlock)(void);
typedef void(^WYSyncCompletedBlock)(BOOL success, NSString *indexKey, id __nullable result);
typedef void(^WYAsyncBlock)(WYSyncOperation * __nonnull operation, WYSyncCompletedBlock completeBlock);

@interface WYSyncOperation : NSOperation

- (instancetype)initWithCompletion:(WYSyncBlock)syncBlock indexKey:(NSString *)indexKey;
- (instancetype)initWithAsyncCompletion:(WYAsyncBlock)asyncBlock izndexKey:(NSString *)indexKey;

- (WYSyncOperationCancelToken _Nonnull)addHandlersForCompleted:(WYSyncCompletedBlock)completedBlock;

- (BOOL)cancel:(WYSyncOperationCancelToken _Nonnull)token;

@end

NS_ASSUME_NONNULL_END

//
//  WYSyncTaskManager.m
//  CocoaLumberjack
//
//  Created by wyan on 2019/11/14.
//

#import "WYSyncTaskManager.h"

@interface WYSyncTaskManager ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSArray<WYSyncBlock> *> *syncBlockDict;

@property (strong, nonatomic, nonnull ) NSOperationQueue *syncQueue;
@property (strong, nonatomic, nonnull ) NSMutableDictionary<NSString *, WYSyncOperation *> *syncOperations;
@property (strong, nonatomic, nullable) dispatch_queue_t barrierQueue;

@end

@implementation WYSyncTaskManager

WY_SINGLETON_DEF(WYSyncTaskManager)

- (instancetype)init {
    self = [super init];
    if (self) {
        _syncQueue = [NSOperationQueue new];
        _syncQueue.maxConcurrentOperationCount = 4;
        _syncQueue.name = @"com.wyutils.WYSyncTaskManager";
        _syncOperations = [NSMutableDictionary dictionary];
        
        _barrierQueue = dispatch_queue_create("com.wyutils.WYSyncTaskManagerBarrierQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (WYSyncToken *)addTaskWithCompletion:(WYSyncBlock)syncBolck taskIdentifier:(NSString *)taskIdentifier completeBlock:(nonnull WYSyncCompletedBlock)completeBlock {
    if(taskIdentifier.length == 0 || !syncBolck) {
        if(completeBlock) {
            completeBlock(NO, taskIdentifier);
        }
        return nil;
    }
    
    return [self innerAddTaskWithCompletion:syncBolck taskIdentifier:taskIdentifier completeBlock:completeBlock];
}

- (void)cancelTaskForResource:(WYSyncToken *)token {
    if(token) {
        dispatch_barrier_async(self.barrierQueue, ^{
            WYSyncOperation *operation = self.syncOperations[token.indexKey];
            BOOL canceled = [operation cancel:token.renderCancelToken];
            if (canceled) {
                [self.syncOperations removeObjectForKey:token.indexKey];
            }
        });
    }
}


#pragma mark - Private
- (WYSyncToken *)innerAddTaskWithCompletion:(WYSyncBlock)syncBolck taskIdentifier:(NSString *)taskIdentifier completeBlock:(nonnull WYSyncCompletedBlock)completeBlock  {
    __weak typeof(self)weakSelf = self;
    return [self addCompleteBlock:completeBlock forTaskIdentifier:taskIdentifier createCallback:^WYSyncOperation *{
        WYSyncOperation *operation = [[WYSyncOperation alloc] initWithCompletion:syncBolck indexKey:taskIdentifier];
        operation.queuePriority = NSOperationQueuePriorityVeryHigh;
        [weakSelf.syncQueue addOperation:operation];
        return operation;
    }];
}

- (WYSyncToken *)addCompleteBlock:(WYSyncCompletedBlock)completeBlock forTaskIdentifier:(NSString *)indexKey createCallback:(WYSyncOperation *(^)(void))createBlock {
    __block WYSyncToken *token = nil;
    
    dispatch_barrier_sync(self.barrierQueue, ^{
        WYSyncOperation *operation = self.syncOperations[indexKey];
        if(!operation) {
            operation = createBlock();
            self.syncOperations[indexKey] = operation;
            __weak WYSyncOperation *woperation = operation;
            operation.completionBlock = ^{
                WYSyncOperation *soperation = woperation;
                if (!soperation) {
                    return ;
                }
                dispatch_barrier_async(self.barrierQueue, ^{
                    if (self.syncOperations[indexKey] == soperation) {
                        [self.syncOperations removeObjectForKey:indexKey];
                    };
                });
            };
        }

        WYSyncOperationCancelToken renderCancelToken = [operation addHandlersForCompleted:completeBlock];
        token = [WYSyncToken new];
        token.indexKey = indexKey;
        token.renderCancelToken = renderCancelToken;
    });

    return token;
}


@end

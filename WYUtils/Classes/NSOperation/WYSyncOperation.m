//
//  WYSyncOperation.m
//  CocoaLumberjack
//
//  Created by wyan on 2019/11/14.
//

#import "WYSyncOperation.h"
#import "WYMacroHeader.h"

static NSString *const kWYCompleteCallbackKey = @"complete";

@interface WYSyncOperation ()

@property (strong, nonatomic, nonnull ) NSMutableArray<WYSyncOperationCancelToken> *callbackBlocks;

@property (strong, nonatomic, nonnull ) dispatch_queue_t barrierQueue;

@property (nonatomic, copy) WYSyncBlock syncBlock;
@property (nonatomic, strong) NSString         *indexKey;

@end

@implementation WYSyncOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithCompletion:(WYSyncBlock)syncBlock indexKey:(nonnull NSString *)indexKey {
    self = [super init];
    if (self) {
        _syncBlock = syncBlock;
        _indexKey = indexKey;
        _callbackBlocks = [NSMutableArray array];
        _executing = NO;
        _finished = NO;
        _barrierQueue = dispatch_queue_create("com.wyutils.WYSyncOperation", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)dealloc {
    
}


- (WYSyncOperationCancelToken _Nonnull)addHandlersForCompleted:(WYSyncCompletedBlock)completedBlock {
    WYSyncOperationCancelToken callbacks = [NSMutableDictionary new];
    if (completedBlock) callbacks[kWYCompleteCallbackKey] = [completedBlock copy];
    dispatch_barrier_async(self.barrierQueue, ^{
        [self.callbackBlocks addObject:callbacks];
    });
    return callbacks;
}

- (BOOL)cancel:(WYSyncOperationCancelToken _Nonnull)token {
    __block BOOL shouldCancel = NO;
    
    dispatch_barrier_sync(self.barrierQueue, ^{
        [self.callbackBlocks removeObjectIdenticalTo:token];
        if (self.callbackBlocks.count == 0) {
            shouldCancel = YES;
        }
    });
    
    if (shouldCancel) {
        [self cancel];
    }
    return shouldCancel;
}

#pragma mark - Private
- (void)cancelInternal {
    if (self.isFinished) {
        return ;
    }
    [super cancel];
    
    if (self.isExecuting) {
        self.executing = NO;
    }
//    if (!self.isFinished) {
//        //system use KVO observe "isFinished" property, so, when finished changed to YES, will call completionBlock of NSOperation. Even if operation not start yet. PS. completionBlock can be called only once at all.
//        self.finished = YES;
//    }
    // cancel will not callback
    [self reset];
}

- (void)reset {
    dispatch_barrier_async(self.barrierQueue, ^{
        [self.callbackBlocks removeAllObjects];
    });
}

- (void)done {
    self.finished = YES;
    self.executing = NO;
    [self reset];
}

- (void)callCompletionBlocks:(BOOL)success indexKey:(NSString *)indexKey {
    NSArray<WYSyncCompletedBlock> *completionBlocks = [self callbacksForKey:kWYCompleteCallbackKey];
    wy_dispatch_main_async_safe(^{
        for(WYSyncCompletedBlock compelteBlock in completionBlocks) {
            compelteBlock(success, indexKey);
        }
    });
}

- (nullable NSArray<id> *)callbacksForKey:(NSString *)key {
    __block NSMutableArray<id> *callbacks = nil;
    dispatch_sync(self.barrierQueue, ^{
        // We need to remove [NSNull null] because there might not always be a progress block for each callback
        callbacks = [[self.callbackBlocks valueForKey:key] mutableCopy];
        [callbacks removeObjectIdenticalTo:[NSNull null]];
    });
    return [callbacks copy];
}

#pragma mark - Override
- (void)start {
    @synchronized (self) {
        if (self.isCancelled) {
            self.finished = YES;
            [self reset];
            return;
        }
        BOOL success = NO;
        if(self.syncBlock) {
            success = self.syncBlock();
        }
        [self callCompletionBlocks:success indexKey:self.indexKey];
        [self done];
    }
}

- (void)cancel {
    @synchronized (self) {
        [self cancelInternal];
    }
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}


@end

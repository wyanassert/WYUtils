//
//  WYSyncTaskManager.h
//  CocoaLumberjack
//
//  Created by wyan on 2019/11/14.
//

#import <Foundation/Foundation.h>
#import "WYMacroHeader.h"
#import "WYSyncOperation.h"
#import "WYSyncToken.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYSyncTaskManager : NSObject

WY_SINGLETON_AS(WYSyncTaskManager)

- (WYSyncToken *)addTaskWithCompletion:(WYSyncBlock)syncBolck taskIdentifier:(NSString *)taskIdentifier completeBlock:(WYSyncCompletedBlock)completeBlock;
- (void)cancelTaskForResource:(WYSyncToken *)token;

@end

NS_ASSUME_NONNULL_END

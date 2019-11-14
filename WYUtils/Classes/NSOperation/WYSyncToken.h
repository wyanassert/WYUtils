//
//  WYSyncToken.h
//  CocoaLumberjack
//
//  Created by wyan on 2019/11/14.
//

#import <Foundation/Foundation.h>
#import "WYSyncOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYSyncToken : NSOperation

@property (nonatomic, strong, nullable) NSString *indexKey;
@property (nonatomic, strong, nullable) WYSyncOperationCancelToken         renderCancelToken;

@end

NS_ASSUME_NONNULL_END

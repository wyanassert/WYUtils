//
//  WYAssetManager.h
//  CHTCollectionViewWaterfallLayout
//
//  Created by wyan on 2020/6/19.
//

#import <Foundation/Foundation.h>
#import "WYMacroHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYAssetManager : NSObject

WYAS_SINGLETON(WYAssetManager)

- (void)wy_adjustVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput targetRatio:(CGFloat)ratio blurRadius:(CGFloat)blurRadius completion:(void (^)(bool success))completion;

@end

NS_ASSUME_NONNULL_END

//
//  WYAssetManager.h
//  CHTCollectionViewWaterfallLayout
//
//  Created by wyan on 2020/6/19.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "WYMacroHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYAssetManager : NSObject

WYAS_SINGLETON(WYAssetManager)

- (void)wy_renderVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput targetRatio:(CGFloat)ratio  progress:(CGImageRef _Nullable(^)(CGFloat progress, CGFloat currentTime, CGFloat totalTime, CGImageRef currImageRef, CGSize renderSize))progressBlock completion:(void (^)(bool success))completion;

- (void)wy_adjustVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput targetRatio:(CGFloat)ratio blurRadius:(CGFloat)blurRadius progress:(void (^)(CGFloat progress))progressBlock completion:(void (^)(bool success))completion;

@end

NS_ASSUME_NONNULL_END

//
//  AVAsset+WYBlur.h
//  CHTCollectionViewWaterfallLayout
//
//  Created by wyan on 2020/6/19.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVAsset (WYBlur)

+ (void)wy_renderVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput targetRatio:(CGFloat)ratio  progress:(CGImageRef _Nullable(^)(CGFloat progress, CGFloat currentTime, CGFloat totalTime, CGImageRef currImageRef, CGSize renderSize))progressBlock completion:(void (^)(bool success))completion;

+ (void)wy_adjustVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput targetRatio:(CGFloat)ratio blurRadius:(CGFloat)blurRadius progress:(void (^)(CGFloat progress))progressBlock completion:(void (^)(bool success))completion;

+ (void)wy_blurVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput blurRadius:(CGFloat)blurRadius completion:(void (^)(bool success))completion;

+ (void)wy_addAduioFromVideo:(NSURL *)audioAssetUrl toVideo:(NSURL *)videoAssetUrl output:(NSURL *)videoFileOutput completion:(void (^)(bool))completion;

@end

NS_ASSUME_NONNULL_END

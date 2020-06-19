//
//  AVAsset+WYBlur.h
//  CHTCollectionViewWaterfallLayout
//
//  Created by wyan on 2020/6/19.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVAsset (WYBlur)

+ (void)wy_adjustVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput targetRatio:(CGFloat)ratio blurRadius:(CGFloat)blurRadius completion:(void (^)(bool success))completion;

+ (void)wy_blurVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput blurRadius:(CGFloat)blurRadius completion:(void (^)(bool success))completion;

@end

NS_ASSUME_NONNULL_END

//
//  AVAsset+WYTrim.h
//  Masonry
//
//  Created by wyan on 2020/6/17.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVAsset (WYTrim)

+ (void)wy_blurVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput blurRadius:(CGFloat)blurRadius completion:(void (^)(bool success))completion;

+ (void)wy_adjustAudio:(NSURL *)audioFileInput toLength:(CGFloat)length output:(NSURL *)audioFileOutput completion:(void (^)(bool success))completion;

+ (void)wy_trimAudio:(NSURL *)audioFileInput output:(NSURL *)audioFileOutput start:(CGFloat)start end:(CGFloat)end completion:(void (^)(bool success))completion;

@end

NS_ASSUME_NONNULL_END

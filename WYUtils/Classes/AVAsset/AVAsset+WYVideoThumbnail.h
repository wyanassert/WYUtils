//
//  AVAsset+WYVideoThumbnail.h
//  Masonry
//
//  Created by wyan on 2020/6/15.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVAsset (WYVideoThumbnail)

+ (UIImage *)wy_generateThumbnail:(AVURLAsset *)asset;

@end

NS_ASSUME_NONNULL_END

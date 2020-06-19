//
//  AVAssetTrack+WYSize.h
//  Masonry
//
//  Created by wyan on 2020/6/18.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVAssetTrack (WYSize)

- (BOOL)wy_isVideoPortrait;
- (CGSize)wy_size;

@end

NS_ASSUME_NONNULL_END

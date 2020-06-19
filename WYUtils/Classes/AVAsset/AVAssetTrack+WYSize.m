//
//  AVAssetTrack+WYSize.m
//  Masonry
//
//  Created by wyan on 2020/6/18.
//

#import "AVAssetTrack+WYSize.h"

@implementation AVAssetTrack (WYSize)

- (BOOL)wy_isVideoPortrait {
    CGAffineTransform transform = self.preferredTransform;
    BOOL isVideoPortrait = NO;
    if (transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0) {
        isVideoPortrait = YES;
    }
    if (transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0) {
        isVideoPortrait = YES;
    }
    return isVideoPortrait;
}

- (CGSize)wy_size {
    CGSize videoSize = self.naturalSize;
    if([self wy_isVideoPortrait]){
        videoSize = CGSizeMake(self.naturalSize.height, self.naturalSize.width);
    } else {
        videoSize = self.naturalSize;
    }
    return videoSize;
}

@end

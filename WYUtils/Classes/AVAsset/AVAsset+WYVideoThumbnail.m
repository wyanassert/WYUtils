//
//  AVAsset+WYVideoThumbnail.m
//  Masonry
//
//  Created by wyan on 2020/6/15.
//

#import "AVAsset+WYVideoThumbnail.h"

@implementation AVAsset (WYVideoThumbnail)

+ (UIImage *)wy_generateThumbnail:(AVAsset *)asset {
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;

    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return thumb;
}

@end

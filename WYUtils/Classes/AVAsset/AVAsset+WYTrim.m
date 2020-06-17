//
//  AVAsset+WYTrim.m
//  Masonry
//
//  Created by wyan on 2020/6/17.
//

#import "AVAsset+WYTrim.h"

@implementation AVAsset (WYTrim)

+ (void)wy_adjustAudio:(NSURL *)audioFileInput toLength:(CGFloat)length output:(NSURL *)audioFileOutput completion:(void (^)(bool))completion {
    [[NSFileManager defaultManager] removeItemAtURL:audioFileOutput error:NULL];
    AVURLAsset *audioAsset = [AVURLAsset assetWithURL:audioFileInput];
    CMTime durationTime = audioAsset.duration;
    CGFloat duration = CMTimeGetSeconds(durationTime);
    if(duration > length) {
        [AVAsset wy_trimAudio:audioFileInput output:audioFileOutput start:0 end:length completion:completion];
        return;
    } else if (duration == length) {
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtURL:audioFileInput toURL:audioFileOutput error:&error];
        if(completion) {
            completion(error == nil);
        }
        return;
    } else if (duration > 0) {
        AVMutableComposition *composition = [AVMutableComposition composition];
        AVMutableCompositionTrack *audioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
        
        int index = 0;
        while (index * duration < length) {
            AVURLAsset *audioAsset1 = [AVURLAsset assetWithURL:audioFileInput];
            AVAssetTrack *audioAssetTrack1 = [[audioAsset1 tracksWithMediaType:AVMediaTypeAudio] firstObject];
            [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset1.duration) ofTrack:audioAssetTrack1 atTime:CMTimeMake(duration * index, audioAsset1.duration.timescale) error:nil];
            index ++;
        }
        
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetAppleM4A];
        session.outputURL = audioFileOutput;
        session.outputFileType = AVFileTypeAppleM4A;
        CMTimeRange exportTimeRange = CMTimeRangeFromTimeToTime(kCMTimeZero, CMTimeMake(ceil(length * 100), 100));
        session.timeRange = exportTimeRange;
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            if (session.status == AVAssetExportSessionStatusCompleted) {
                if(completion) {
                    completion(YES);
                }
            } else {
                if(completion) {
                    completion(NO);
                }
            }
        }];
    } else {
        if(completion) {
            completion(NO);
        }
    }
}

+ (void)wy_trimAudio:(NSURL *)audioFileInput output:(NSURL *)audioFileOutput start:(CGFloat)start end:(CGFloat)end completion:(void (^)(bool))completion {
    float vocalStartMarker = MAX(start, 0);
    float vocalEndMarker = MAX(end, 0);

    if (!audioFileInput || !audioFileOutput || vocalStartMarker >= vocalEndMarker) {
        if(completion) {
            completion(NO);
        }
        return ;
    }

    [[NSFileManager defaultManager] removeItemAtURL:audioFileOutput error:NULL];
    AVAsset *asset = [AVAsset assetWithURL:audioFileInput];
    CMTime durationTime = asset.duration;
    CGFloat duration = CMTimeGetSeconds(durationTime);
    
    vocalEndMarker = MIN(vocalEndMarker, duration);
    
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetAppleM4A];
    if (exportSession == nil) {
        if(completion) {
            completion(NO);
        }
        return ;
    }

    CMTime startTime = CMTimeMake((int)(floor(vocalStartMarker * 100)), 100);
    CMTime stopTime = CMTimeMake((int)(ceil(vocalEndMarker * 100)), 100);
    CMTimeRange exportTimeRange = CMTimeRangeFromTimeToTime(startTime, stopTime);

    exportSession.outputURL = audioFileOutput;
    exportSession.outputFileType = AVFileTypeAppleM4A;
    exportSession.timeRange = exportTimeRange;

    [exportSession exportAsynchronouslyWithCompletionHandler:^{
         if (AVAssetExportSessionStatusCompleted == exportSession.status) {
             if(completion) {
                 completion(YES);
             }
         } else if (AVAssetExportSessionStatusFailed == exportSession.status) {
             if(completion) {
                 completion(NO);
             }
         }
     }];
}


@end

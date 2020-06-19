//
//  AVAsset+WYBlur.m
//  CHTCollectionViewWaterfallLayout
//
//  Created by wyan on 2020/6/19.
//

#import "AVAsset+WYBlur.h"
#import "WYMacroHeader.h"
#import "WYAssetManager.h"


@implementation AVAsset (WYBlur)

+ (void)wy_adjustVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput targetRatio:(CGFloat)ratio blurRadius:(CGFloat)blurRadius progress:(void (^)(CGFloat progress))progressBlock completion:(void (^)(bool))completion {
    NSString *cacheFile = [kWYTempPath stringByAppendingPathComponent:@"tmpBlurVideo.mp4"];
    NSURL *tmpUrl = [NSURL fileURLWithPath:cacheFile];
    [[WYAssetManager sharedInstance] wy_adjustVideo:videoFileInput output:tmpUrl targetRatio:ratio blurRadius:blurRadius progress:^(CGFloat progress) {
        if(progressBlock) {
            progressBlock(progress * 0.95);
        }
    } completion:^(bool success) {
        if(progressBlock) {
            progressBlock(1);
        }
        if(success) {
            [AVAsset wy_addAduioFromVideo:videoFileInput toVideo:tmpUrl output:videoFileOutput completion:completion];
        } else {
            completion(NO);
        }
    }];
}

+ (void)wy_blurVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput blurRadius:(CGFloat)blurRadius completion:(void (^)(bool))completion {
    if (!videoFileInput || blurRadius <= 0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:videoFileInput options:nil];
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetHighestQuality];
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoCompositionWithAsset:[AVAsset assetWithURL:videoFileInput] applyingCIFiltersWithHandler:^(AVAsynchronousCIImageFilteringRequest * _Nonnull request) {
        
        CIImage *ciImage = [request.sourceImage imageByClampingToExtent];
        
        CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        [filter setValue:@(blurRadius) forKey: kCIInputRadiusKey];
        
        CIImage *output = filter.outputImage;
        
        if (output) {
            [request finishWithImage:output context:nil];
        }
    }];
    
    session.outputURL = videoFileOutput;
    session.outputFileType = AVFileTypeMPEG4;
    session.shouldOptimizeForNetworkUse = YES;
    session.videoComposition = videoComposition;
    [session exportAsynchronouslyWithCompletionHandler:^{
        wy_dispatch_main_async_safe(^{
            switch ([session status]) {
                case AVAssetExportSessionStatusCompleted: {
                    if (completion) completion(YES);
                    break;
                }
                case AVAssetExportSessionStatusFailed:
                case AVAssetExportSessionStatusCancelled:{
                    if (completion) completion(NO);
                    break;
                }
                default:
                    if (completion) completion(NO);
                    break;
            }
        });
    }];
}

+ (void)wy_addAduioFromVideo:(NSURL *)audioAssetUrl toVideo:(NSURL *)videoAssetUrl output:(NSURL *)videoFileOutput completion:(void (^)(bool))completion {
    AVURLAsset *audioAsset = [AVURLAsset assetWithURL:audioAssetUrl];
    AVURLAsset *videoAsset = [AVURLAsset assetWithURL:videoAssetUrl];
    
    AVAssetTrack *importAudioTrack = [audioAsset tracksWithMediaType:AVMediaTypeAudio].firstObject;
    AVAssetTrack *importVideoTrack = [videoAsset tracksWithMediaType:AVMediaTypeVideo].firstObject;
    
    AVMutableComposition *mixComposition = [AVMutableComposition composition];
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];

    AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration) ofTrack:importVideoTrack atTime:kCMTimeZero error:nil];
    [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) ofTrack:importAudioTrack atTime:kCMTimeZero error:nil];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:videoFileOutput.path]) {
        [[NSFileManager defaultManager] removeItemAtPath:videoFileOutput.path error:nil];
    }
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
    exportSession.outputURL = videoFileOutput;
    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
    exportSession.shouldOptimizeForNetworkUse = YES;
        
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        wy_dispatch_main_async_safe(^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusCompleted: {
                    if (completion) completion(YES);
                    break;
                }
                case AVAssetExportSessionStatusFailed:
                case AVAssetExportSessionStatusCancelled:{
                    if (completion) completion(NO);
                    break;
                }
                default:
                    if (completion) completion(NO);
                    break;
            }
        });
    }];
}


@end

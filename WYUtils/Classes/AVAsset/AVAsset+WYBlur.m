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

+ (void)wy_adjustVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput targetRatio:(CGFloat)ratio blurRadius:(CGFloat)blurRadius completion:(void (^)(bool))completion {
    [[WYAssetManager sharedInstance] wy_adjustVideo:videoFileInput output:videoFileOutput targetRatio:ratio blurRadius:blurRadius completion:completion];
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


@end

//
//  WYAssetManager.m
//  CHTCollectionViewWaterfallLayout
//
//  Created by wyan on 2020/6/19.
//

#import "WYAssetManager.h"
#import <AVFoundation/AVFoundation.h>
#import "AVAssetTrack+WYSize.h"
#import "UIImage+WYUtils.h"

@interface WYAssetManager ()

@property (nonatomic, strong) AVAssetReader *assetReader;
@property (nonatomic, strong) AVAssetReaderTrackOutput *videoTrackOutput;
@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *videoWriterInput;
@property (nonatomic, strong) AVAssetWriterInputPixelBufferAdaptor *avAdaptor;

@property (nonatomic, assign) CGFloat         emptyTime;
@property (nonatomic, assign) CGFloat         lastTime;

@end

@implementation WYAssetManager

WYDEF_SINGLETON(WYAssetManager)

- (void)wy_renderVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput targetRatio:(CGFloat)ratio  progress:(CGImageRef _Nullable(^)(CGFloat progress, CGFloat currentTime, CGFloat totalTime, CGImageRef currImageRef, CGSize renderSize))progressBlock completion:(void (^)(bool success))completion {
    if (!videoFileInput || ratio <= 0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    
    self.emptyTime = 0;
    self.lastTime = 0;
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:videoFileInput options:nil];
    CGFloat videoDuration = CMTimeGetSeconds(asset.duration);
    AVAssetTrack *videoTrack = [asset tracksWithMediaType:AVMediaTypeVideo].firstObject;
    CGSize videoSize = [videoTrack wy_size];
    CGFloat videoRatio = videoSize.width/videoSize.height;
    CGSize renderSize = videoSize;
    if(videoRatio < ratio) {
        renderSize = CGSizeMake(videoSize.height*ratio, videoSize.height);
    } else {
        renderSize = CGSizeMake(videoSize.width, videoSize.width/ratio);
    }
    [[NSFileManager defaultManager] removeItemAtURL:videoFileOutput error:nil];
    
    [self setUpAssetReader:asset];
    [self setUpAssetWritter:videoFileOutput renderSize:renderSize];
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create("com.tapharmonic.WriterQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(dispatchQueue, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0));
    
    __weak typeof(self)weakSelf = self;
    //read sampleData From AVAssetReaderOutput, and then render, finally append data to avAdaptor
    [_videoWriterInput requestMediaDataWhenReadyOnQueue:dispatchQueue usingBlock:^{
        __strong typeof(weakSelf)self = weakSelf;
        BOOL videoComplete = NO;
        while (self->_videoWriterInput.readyForMoreMediaData == FALSE) {
          NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
          [[NSRunLoop currentRunLoop] runUntilDate:maxDate];
        }
        while ([self->_videoWriterInput isReadyForMoreMediaData] && !videoComplete){
            // read sampleData
            CMSampleBufferRef nextSampleBuffer = [self->_videoTrackOutput copyNextSampleBuffer];
            CMTime presentationTime = CMSampleBufferGetPresentationTimeStamp(nextSampleBuffer);
            CGFloat currTime = CMTimeGetSeconds(presentationTime);
            if (nextSampleBuffer && currTime <= videoDuration) {
                @autoreleasepool {
                    CGImageRef tmpImageRef = [self imageFromSampleBuffer:nextSampleBuffer];
                    CFRelease(nextSampleBuffer);
                    nextSampleBuffer = NULL;
                    CGImageRef createImageRef = progressBlock(currTime/videoDuration, currTime, videoDuration, tmpImageRef, renderSize);
                    if(createImageRef != NULL) {
                        CMTime currentTime = CMTimeMake((currTime - self.emptyTime) * presentationTime.timescale, presentationTime.timescale);
                        BOOL result = [self appendPixelBufferAdaptor:self->_avAdaptor withImage:createImageRef atTime:currentTime size:CGSizeMake(renderSize.width, renderSize.height)];
                        CGImageRelease(createImageRef);
                        videoComplete = !result;
                    } else {
                        self.emptyTime += currTime - self.lastTime;
                    }
                    self.lastTime = currTime;
                }
                while (self->_videoWriterInput.readyForMoreMediaData == FALSE) {
                    NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
                    [[NSRunLoop currentRunLoop] runUntilDate:maxDate];
                }
            } else {
                videoComplete = YES;
            }
        }
        [self->_videoWriterInput markAsFinished];
        [self->_assetWriter finishWritingWithCompletionHandler:^{
            __strong typeof(weakSelf)self = weakSelf;
            AVAssetWriterStatus status = self->_assetWriter.status;
            if (status == AVAssetWriterStatusCompleted) {
                if(completion) {
                    completion(YES);
                }
            } else {
                if(completion) {
                    completion(NO);
                }
            }
            self->_assetWriter = nil;
        }];
    }];
}

- (void)wy_adjustVideo:(NSURL *)videoFileInput output:(NSURL *)videoFileOutput targetRatio:(CGFloat)ratio blurRadius:(CGFloat)blurRadius progress:(void (^)(CGFloat progress))progressBlock completion:(void (^)(bool))completion {
    if (!videoFileInput || blurRadius <= 0 || ratio <= 0) {
        if (completion) {
            completion(NO);
        }
        return;
    }
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:videoFileInput options:nil];
    CGFloat videoDuration = CMTimeGetSeconds(asset.duration);
    AVAssetTrack *videoTrack = [asset tracksWithMediaType:AVMediaTypeVideo].firstObject;
    CGSize videoSize = [videoTrack wy_size];
    CGFloat videoRatio = videoSize.width/videoSize.height;
    CGSize renderSize = videoSize;
    if(videoRatio < ratio) {
        renderSize = CGSizeMake(videoSize.height*ratio, videoSize.height);
    } else {
        renderSize = CGSizeMake(videoSize.width, videoSize.width/ratio);
    }
    if(fabs(videoSize.width/videoSize.height - ratio) < 0.02) {
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtURL:videoFileInput toURL:videoFileOutput error:&error];
        if (completion) {
            completion(error == nil);
        }
        return;
    } else {
        [[NSFileManager defaultManager] removeItemAtURL:videoFileOutput error:nil];
        
        [self setUpAssetReader:asset];
        [self setUpAssetWritter:videoFileOutput renderSize:renderSize];
        
        dispatch_queue_t dispatchQueue = dispatch_queue_create("com.tapharmonic.WriterQueue", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(dispatchQueue, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0));
        
        __weak typeof(self)weakSelf = self;
        //read sampleData From AVAssetReaderOutput, and then render, finally append data to avAdaptor
        [_videoWriterInput requestMediaDataWhenReadyOnQueue:dispatchQueue usingBlock:^{
            __strong typeof(weakSelf)self = weakSelf;
            BOOL videoComplete = NO;
            while (self->_videoWriterInput.readyForMoreMediaData == FALSE) {
              NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
              [[NSRunLoop currentRunLoop] runUntilDate:maxDate];
            }
            while ([self->_videoWriterInput isReadyForMoreMediaData] && !videoComplete){
                // read sampleData
                CMSampleBufferRef nextSampleBuffer = [self->_videoTrackOutput copyNextSampleBuffer];
                CMTime presentationTime = CMSampleBufferGetPresentationTimeStamp(nextSampleBuffer);
                CGFloat currTime = CMTimeGetSeconds(presentationTime);
                if (nextSampleBuffer && currTime <= videoDuration) {
                    @autoreleasepool {
                        CGImageRef tmpImageRef = [self imageFromSampleBuffer:nextSampleBuffer];
                        CFRelease(nextSampleBuffer);
                        nextSampleBuffer = NULL;
                        CGImageRef createImageRef = [self renderImageRef:tmpImageRef renderSize:renderSize blurRadius:blurRadius];
                        BOOL result = [self appendPixelBufferAdaptor:self->_avAdaptor withImage:createImageRef atTime:presentationTime size:CGSizeMake(renderSize.width, renderSize.height)];
                        CGImageRelease(createImageRef);
                        videoComplete = !result;
                        wy_dispatch_main_async_safe(^{
                            if(progressBlock) {
                                progressBlock(currTime/videoDuration);
                            }
                        });
                    }
                    while (self->_videoWriterInput.readyForMoreMediaData == FALSE) {
                        NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
                        [[NSRunLoop currentRunLoop] runUntilDate:maxDate];
                    }
                } else {
                    videoComplete = YES;
                }
            }
            [self->_videoWriterInput markAsFinished];
            [self->_assetWriter finishWritingWithCompletionHandler:^{
                __strong typeof(weakSelf)self = weakSelf;
                AVAssetWriterStatus status = self->_assetWriter.status;
                if (status == AVAssetWriterStatusCompleted) {
                    if(completion) {
                        completion(YES);
                    }
                } else {
                    if(completion) {
                        completion(NO);
                    }
                }
                self->_assetWriter = nil;
            }];
        }];
    }
}

- (void)setUpAssetReader:(AVAsset *)asset {
    _assetReader = [[AVAssetReader alloc] initWithAsset:asset error:nil];
    
    NSDictionary *readerOutputSettings = @{
        (id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA),
        (id)kCVPixelBufferIOSurfacePropertiesKey : [NSDictionary dictionary]
    };
    _videoTrackOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:[asset tracksWithMediaType:AVMediaTypeVideo].firstObject outputSettings:readerOutputSettings];
    if ([_assetReader canAddOutput:_videoTrackOutput]) {
        [_assetReader addOutput:_videoTrackOutput];
    }
    
    [_assetReader startReading];
}

- (void)setUpAssetWritter:(NSURL *)videoFileOutput renderSize:(CGSize)renderSize {
    _assetWriter = [[AVAssetWriter alloc] initWithURL:videoFileOutput fileType:AVFileTypeQuickTimeMovie error:nil];
    
    NSDictionary *writerOutputSettings = @{AVVideoCodecKey: AVVideoCodecH264,
                                           AVVideoWidthKey: @((int)renderSize.width),
                                           AVVideoHeightKey: @((int)renderSize.height),
                                           AVVideoCompressionPropertiesKey: [NSDictionary dictionaryWithObjectsAndKeys:
                                           [NSNumber numberWithInt:4000*1024], AVVideoAverageBitRateKey,
                                           [NSNumber numberWithInt:4000*1024], AVVideoAverageBitRateKey,
                                           AVVideoH264EntropyModeCABAC, AVVideoH264EntropyModeKey,
                                           [NSNumber numberWithInt:30],AVVideoMaxKeyFrameIntervalKey,
                                           nil]
    };
    _videoWriterInput = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeVideo outputSettings:writerOutputSettings];
    if([_assetWriter canAddInput:_videoWriterInput]) {
        [_assetWriter addInput:_videoWriterInput];
    }
    
    NSDictionary *sourceBufferAttributes = @{
        (__bridge NSString *)kCVPixelBufferPixelFormatTypeKey:[NSNumber numberWithInt:kCVPixelFormatType_32ARGB],
        (__bridge NSString *)kCVPixelBufferWidthKey: [NSNumber numberWithFloat:renderSize.width],
        (__bridge NSString *)kCVPixelBufferHeightKey: [NSNumber numberWithFloat:renderSize.height],
    };
    _avAdaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:_videoWriterInput sourcePixelBufferAttributes:sourceBufferAttributes];
    [_assetWriter startWriting];
    [_assetWriter startSessionAtSourceTime:kCMTimeZero];
}

- (CGImageRef)renderImageRef:(CGImageRef)tmpImageRef renderSize:(CGSize)renderSize blurRadius:(CGFloat)blurRadius {
    //create render context
    CGContextRef context = CGBitmapContextCreate(NULL, renderSize.width, renderSize.height, CGImageGetBitsPerComponent(tmpImageRef), 0, CGImageGetColorSpace(tmpImageRef), CGImageGetBitmapInfo(tmpImageRef));
    // blur image as background image
    UIImage *image = [UIImage imageWithCGImage:tmpImageRef scale:1 orientation:UIImageOrientationUp];
    UIImage *blurImage = [UIImage wy_blurredImageWithImage:image withBlur:blurRadius/100.0];
    if(blurImage) {
        CGImageRef blurImageRef = blurImage.CGImage;
        CGContextDrawImage(context, CGRectMake(0, 0, renderSize.width, renderSize.height), blurImageRef);
    }
    //render image in center
    CGContextDrawImage(context, CGRectMake((renderSize.width - CGImageGetWidth(tmpImageRef))/2, (renderSize.height - CGImageGetHeight(tmpImageRef))/2, CGImageGetWidth(tmpImageRef), CGImageGetHeight(tmpImageRef)), tmpImageRef);
    
    CGImageRelease(tmpImageRef);
    CGImageRef createImageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    return createImageRef;
}

- (CGImageRef) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer // Create a CGImageRef from sample buffer data
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);        // Lock the image buffer

    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);   // Get information of the image
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    CGContextRelease(newContext);

    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    /* CVBufferRelease(imageBuffer); */  // do not call this!

    return newImage;
}

- (BOOL)appendPixelBufferAdaptor:(AVAssetWriterInputPixelBufferAdaptor *)adaptor
                       withImage:(CGImageRef)image
                          atTime:(CMTime)time
                            size:(CGSize)size
{
    if (adaptor.pixelBufferPool != NULL) {
        CVPixelBufferRef pixelBuffer = NULL;
        CVReturn result = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, adaptor.pixelBufferPool, &pixelBuffer);
        if (result != 0) {
            return false;
        }
        [self fillPixelBuffer:pixelBuffer withImage:image size:size];
        
        BOOL success = [adaptor appendPixelBuffer:pixelBuffer withPresentationTime:time];
        CVPixelBufferRelease(pixelBuffer);
        return success;
    }
    return false;
}

- (void)fillPixelBuffer:(CVPixelBufferRef)pixelBuffer withImage:(CGImageRef)image size:(CGSize)size
{
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    void *pixelData = CVPixelBufferGetBaseAddress(pixelBuffer);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    /// set the context size
    CGSize contextSize = size;
    
    // generate a context where the image will be drawn
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 contextSize.width,
                                                 contextSize.height,
                                                 8,
                                                 CVPixelBufferGetBytesPerRow(pixelBuffer),
                                                 rgbColorSpace, kCGImageAlphaNoneSkipFirst);
    
    CGContextClearRect(context, CGRectMake(0, 0, contextSize.width, contextSize.height));
    CGContextFillRect(context, CGRectMake(0, 0, contextSize.width, contextSize.height));
    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0, 0, contextSize.width, contextSize.height), image);
    
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
}

@end

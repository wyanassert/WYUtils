//
//  WYDisplayImageView.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/3/18.
//

#import "WYDisplayImageView.h"
#import "WYMacroHeader.h"

#define kWYInitialZoom 3

@interface WYDisplayImageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, retain) UIScrollView *contentView;

@property (nonatomic, strong) UIImage      *image;
@property (nonatomic, assign) CGSize       predictSize;

@end

@implementation WYDisplayImageView

- (instancetype)initWithImage:(UIImage *)image andSize:(CGSize)size {
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        _predictSize = size;
        _image = image;
        [self configView];
        [self setImageViewData:image];
    }
    return self;
}

- (void)loadImage:(UIImage *)image withSize:(CGSize)size {
    _predictSize = size;
    _image = image;
    [self setImageViewData:image];
}

- (void)configView {
    self.backgroundColor = [UIColor grayColor];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    float minimumScale = self.frame.size.width / self.imageView.frame.size.width;
    [self.contentView setMinimumZoomScale:minimumScale];
    [self.contentView setZoomScale:minimumScale];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
}

#pragma mark - View cycle && Override
- (void)dealloc {
    _contentView = nil;
    _imageView = nil;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.contentView.frame = CGRectInset(self.bounds, 0, 0);
    self.imageView.frame = CGRectMake(0, 0, self.predictSize.width  * kWYInitialZoom, self.predictSize.height * kWYInitialZoom);
    float minimumScale = self.frame.size.width / self.imageView.frame.size.width;
    [self.contentView setMinimumZoomScale:minimumScale];
    [self.contentView setZoomScale:minimumScale];
}

- (void)setNotReloadFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
    self.imageView.frame = CGRectMake(0, 0, self.predictSize.width * kWYInitialZoom, self.predictSize.height * kWYInitialZoom);
    float minimumScale = self.frame.size.width / self.imageView.frame.size.width;
    [self.contentView setMinimumZoomScale:minimumScale];
    [self.contentView setZoomScale:minimumScale];
}

- (void)setImageViewData:(UIImage *)imageData {
    self.imageView.image= imageData;
    if (imageData == nil) {
        return;
    }
    CGRect rect  = CGRectZero;
    CGFloat scale = 1.0f;
    CGFloat w = 0.0f;
    CGFloat h = 0.0f;
    
    if(imageData.size.width && imageData.size.height) {
        if(self.contentView.frame.size.width > self.contentView.frame.size.height) {
            w = self.contentView.frame.size.width;
            h = w*imageData.size.height/imageData.size.width;
            if(h < self.contentView.frame.size.height) {
                h = self.contentView.frame.size.height;
                w = h*imageData.size.width/imageData.size.height;
            }
        } else {
            h = self.contentView.frame.size.height;
            w = h*imageData.size.width/imageData.size.height;
            if(w < self.contentView.frame.size.width) {
                w = self.contentView.frame.size.width;
                h = w*imageData.size.height/imageData.size.width;
            }
        }
        rect.size = CGSizeMake(w, h);
    } else {
        rect.size = self.predictSize;
    }
    CGFloat scale_w = w / imageData.size.width;
    CGFloat scale_h = h / imageData.size.height;
    if (w > self.frame.size.width || h > self.frame.size.height) {
        scale_w = w / self.frame.size.width;
        scale_h = h / self.frame.size.height;
        if (scale_w > scale_h) {
            scale = 1/scale_w;
        } else {
            scale = 1/scale_h;
        }
    }
    if (w <= self.frame.size.width || h <= self.frame.size.height) {
        scale_w = w / self.frame.size.width;
        scale_h = h / self.frame.size.height;
        if (scale_w > scale_h) {
            scale = scale_h;
        } else {
            scale = scale_w;
        }
    }
    
    @synchronized(self) {
        self.imageView.frame = rect;
        [self.contentView setZoomScale:0.4 animated:YES];
        [self setNeedsLayout];
    }
}

- (void)setImageViewData:(UIImage *)imageData rect:(CGRect)rect {
    self.frame = rect;
    [self setImageViewData:imageData];
}


#pragma mark - Action
- (void)handleSingleTap {
    if(self.clickImageBlock) {
        self.clickImageBlock(self, self.image);
    }
}

#pragma mark - Zoom methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture {
    float newScale = self.contentView.zoomScale * 1.2;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:self.imageView]];
    [self.contentView zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    if (scale == 0) {
        scale = 1;
    }
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [scrollView setZoomScale:scale animated:NO];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touch = [[touches anyObject] locationInView:self.superview];
    self.imageView.center = touch;
}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.frame = CGRectMake(0, 0, self.predictSize.width * kWYInitialZoom, self.predictSize.height * kWYInitialZoom);
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTapGesture setNumberOfTapsRequired:2];
        [_imageView addGestureRecognizer:doubleTapGesture];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        [_imageView addGestureRecognizer:tapGesture];
    }
    return _imageView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
        _contentView.delegate = self;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
    }
    return _contentView;
}

@end


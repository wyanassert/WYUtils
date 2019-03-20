//
//  WYDisplayImageView.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/3/18.
//

#import "WYDisplayImageView.h"
#import "WYMacroHeader.h"

@interface WYDisplayImageView ()

@property (nonatomic, strong) UIImageView         *imageView;

@property (nonatomic, strong) UIImage         *image;
@property (nonatomic, assign) CGSize         contentSize;

@end

@implementation WYDisplayImageView

- (instancetype)initWithImage:(UIImage *)image andSize:(CGSize)size {
    self = [super init];
    if (self) {
        _contentSize = size;
        _image = image;
        
        [self configSubViews];
    }
    return self;
}
- (void)loadImage:(UIImage *)image withSize:(CGSize)size {
    _contentSize = size;
    _image = image;
    self.imageView.image = image;
    [self configSubViews];
}

- (void)configSubViews {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat scale = MIN(self.image.size.width / self.contentSize.width, self.image.size.height / self.contentSize.height);
    if(scale <= 0) {
        scale = 1;
    }
    if(self.imageView.superview) {
        [self.imageView removeFromSuperview];
    }
    CGFloat imageWidth = self.image.size.width / scale;
    CGFloat imageHeight = self.image.size.height / scale;
    self.imageView.frame = CGRectMake((self.contentSize.width - imageWidth)/2, (self.contentSize.height - imageHeight)/2, imageWidth, imageHeight);
    [self addSubview:self.imageView];
}

#pragma mark - Action
- (void)userDidClickAction {
    if(self.clickImageBlock) {
        self.clickImageBlock(self, self.image);
    }
}

- (void)userDidPanImage:(UIPanGestureRecognizer *)pan {
    UIGestureRecognizerState state = [pan state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan translationInView:pan.view];
        CGFloat originX = 0;
        CGFloat originY = 0;
        
        originX = pan.view.frame.origin.x + translation.x;
        originY = pan.view.frame.origin.y + translation.y;
        
        originX = MAX(MIN(originX, 0), (WYWIDTH(self) - WYWIDTH(self.imageView)));
        originY = MAX(MIN(originY, 0), (WYHEIGHT(self) - WYHEIGHT(self.imageView)));
        
        pan.view.frame = CGRectMake(originX, originY, WYWIDTH(pan.view), WYHEIGHT(pan.view));
        [pan setTranslation:CGPointZero inView:pan.view];
    }
}


#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = self.image;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        _imageView.layer.allowsEdgeAntialiasing = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userDidPanImage:)];
        [_imageView addGestureRecognizer:pan];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidClickAction)];
        [_imageView addGestureRecognizer:tapGesture];
    }
    return _imageView;
}

@end


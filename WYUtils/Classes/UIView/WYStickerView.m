//
//  WYStickerView.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/3/18.
//

#import "WYStickerView.h"
#import "WYMacroHeader.h"
#import "UIView+WYGestureRecognizer.h"

@interface WYStickerView ()

@property (nonatomic, copy  ) WYCancelBlock      wyCancelBlock;
@property (nonatomic, copy  ) WYSizeChangedBlock wyChangeBlock;
@property (nonatomic, assign) CGFloat            wyMinWidth;

@end

@implementation WYStickerView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _wyMinWidth = WYMIN(60);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(wy_stickerDidPanAction:)];
    [self addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(wy_userDidPinchRoateAction:)];
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(wy_userDidPinchRoateAction:)];
    [self addGestureRecognizer:pinch];
    [self addGestureRecognizer:rotate];
}

- (void)wy_addImageEditActionWithCancelView:(UIView *)cancelView cancelBlock:(WYCancelBlock)cancelBlock {
    _wyCancelBlock = cancelBlock;
    cancelView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wy_cancelAction)];
    [cancelView addGestureRecognizer:tapGesture];
}

- (void)wy_addImageEditActionWithChangeView:(UIView *)changeView sizeChangeBlock:(WYSizeChangedBlock)changeBlock minWidth:(CGFloat)minWidth {
    _wyChangeBlock = changeBlock;
    _wyMinWidth = minWidth;
    
    changeView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pangesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(wy_stickerPanZoomAction:)];
    [changeView addGestureRecognizer:pangesture];
}


#pragma mark - Action
- (void)wy_cancelAction {
    if(self.wyCancelBlock) {
        self.wyCancelBlock(self);
    }
}

- (void)wy_stickerDidPanAction:(UIPanGestureRecognizer *)pan {
    UIGestureRecognizerState state = [pan state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
        CGAffineTransform transform = pan.view.transform;
        pan.view.transform = CGAffineTransformIdentity;
        CGPoint translation = [pan translationInView:pan.view];
        pan.view.center = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y + translation.y);
        pan.view.transform = transform;
        [pan setTranslation:CGPointZero inView:pan.view];
    }
}

- (void)wy_userDidPinchRoateAction:(UIGestureRecognizer *)gesture {
    if([gesture respondsToSelector:@selector(rotation)]) {
        [self setTransform:CGAffineTransformRotate(self.transform, [(UIRotationGestureRecognizer *)gesture rotation])];
        [(UIRotationGestureRecognizer *)gesture setRotation:0];
    } else if ([gesture respondsToSelector:@selector(scale)]) {
        CGFloat scale = [(UIPinchGestureRecognizer *)gesture scale];
        CGAffineTransform transform = self.transform;
        self.transform = CGAffineTransformIdentity;
        CGSize resultSize = CGSizeMake(WYWIDTH(self) * scale, WYHEIGHT(self) * scale);
        if (resultSize.width >= self.wyMinWidth && resultSize.height >= self.wyMinWidth) {
            
            CGPoint lastCenter = self.center;
            self.frame = CGRectMake(lastCenter.x - resultSize.width / 2, lastCenter.y - resultSize.height / 2, resultSize.width, resultSize.height);
            
            if(self.wyChangeBlock) {
                self.wyChangeBlock(self, resultSize);
            }
        }
        self.transform = transform;
        [(UIPinchGestureRecognizer *)gesture setScale:1.0];
    }
}

- (void)wy_stickerPanZoomAction:(UIPanGestureRecognizer *)pan {
    UIGestureRecognizerState state = [pan state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan locationInView:self.superview];
        
        CGAffineTransform transform = self.transform;
        self.transform = CGAffineTransformIdentity;
        CGFloat whScale = WYWIDTH(self)/WYHEIGHT(self);
        self.transform = transform;
        
        CGPoint endPoint = translation;
        CGFloat changeLine = sqrt(pow(endPoint.x - (WYLEFT(self) + WYRIGHT(self))/2, 2) + pow(endPoint.y - (WYTOP(self) + WYBOTTOM(self))/2, 2));
        CGFloat realLine = changeLine + sqrt(pow(WYWIDTH(pan.view), 2) + pow(WYHEIGHT(pan.view), 2)) / 2;
        
        CGSize resultSize = CGSizeMake(realLine * whScale * 2 / sqrt(1+pow(whScale, 2)), realLine * 2 / sqrt(1+pow(whScale, 2)));
        
        BOOL isWise = (endPoint.x - (WYLEFT(self) + WYRIGHT(self))/2) - whScale * (endPoint.y - (WYTOP(self) + WYBOTTOM(self))/2) >= 0;
        CGFloat l0 = changeLine;
        CGFloat l1 = l0;
        CGPoint originCenter = CGPointMake((WYLEFT(self) + WYRIGHT(self))/2 + changeLine * whScale / sqrt(1+pow(whScale, 2)), (WYTOP(self) + WYBOTTOM(self))/2 + changeLine / sqrt(1+pow(whScale, 2)));
        CGFloat l2 = sqrt(pow(originCenter.x - endPoint.x, 2) + pow(originCenter.y - endPoint.y, 2));
        CGFloat cosAngle = (l0*l0 + l1*l1 - l2*l2)/(2*l0*l1);
        CGFloat angle = acos(cosAngle);
        
        if (resultSize.width >= self.wyMinWidth && resultSize.height >= self.wyMinWidth) {
            CGAffineTransform transform = self.transform;
            self.transform = CGAffineTransformIdentity;
            
            CGPoint lastCenter = self.center;
            self.frame = CGRectMake(lastCenter.x - resultSize.width / 2, lastCenter.y - resultSize.height / 2, resultSize.width, resultSize.height);
            
            if(self.wyChangeBlock) {
                self.wyChangeBlock(self, resultSize);
            }
            
            self.transform = transform;
            
            [pan setTranslation:CGPointZero inView:pan.view];
        }
        [self setTransform:CGAffineTransformMakeRotation(isWise?-angle:angle)];
    }
}

@end


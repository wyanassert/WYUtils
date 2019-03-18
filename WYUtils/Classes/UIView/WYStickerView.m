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
    
    [self wy_addPanAction];
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
    UIPanGestureRecognizer *pangesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(wy_panZoomAction:)];
    [changeView addGestureRecognizer:pangesture];
}


#pragma mark - Action
- (void)wy_cancelAction {
    if(self.wyCancelBlock) {
        self.wyCancelBlock(self);
    }
}

- (void)wy_panZoomAction:(UIPanGestureRecognizer *)pan {
    UIGestureRecognizerState state = [pan state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan locationInView:self.superview];
        
        CGPoint endPoint = translation;
        CGFloat changeLine = sqrt(pow(endPoint.x - (WYLEFT(self) + WYRIGHT(self))/2, 2) + pow(endPoint.y - (WYTOP(self) + WYBOTTOM(self))/2, 2));
        CGSize resultSize = CGSizeMake(changeLine * 2 / sqrt(2), changeLine * 2 / sqrt(2));
        
        BOOL isWise = (endPoint.x - (WYLEFT(self) + WYRIGHT(self))/2) - (endPoint.y - (WYTOP(self) + WYBOTTOM(self))/2) >= 0;
        NSLog(@"%d", isWise);
        CGFloat l0 = changeLine;
        CGFloat l1 = l0;
        CGPoint originCenter = CGPointMake((WYLEFT(self) + WYRIGHT(self))/2 + changeLine / sqrt(2), (WYTOP(self) + WYBOTTOM(self))/2 + changeLine / sqrt(2));
        CGFloat l2 = sqrt(pow(originCenter.x - endPoint.x, 2) + pow(originCenter.y - endPoint.y, 2));
        CGFloat cosAngle = (l0*l0 + l1*l1 - l2*l2)/(2*l0*l1);
        CGFloat angle = acos(cosAngle);
        
        if (resultSize.width >= self.wyMinWidth) {
            
            if(self.wyChangeBlock) {
                self.wyChangeBlock(self, resultSize);
            }
            
            [pan setTranslation:CGPointZero inView:pan.view];
        }
        [self setTransform:CGAffineTransformMakeRotation(isWise?-angle:angle)];
    }
}

@end

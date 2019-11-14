//
//  WYStickerView.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/3/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@class WYStickerView;

typedef void(^WYSizeChangedBlock)(WYStickerView * _Nonnull stickerView, CGSize resultSize);
typedef void(^WYCancelBlock)(WYStickerView * _Nonnull stickerView);

NS_ASSUME_NONNULL_BEGIN

@interface WYStickerView : UIView

- (void)wy_addImageEditActionWithCancelView:(UIView *)cancelView cancelBlock:(WYCancelBlock)cancelBlock;
- (void)wy_addImageEditActionWithChangeView:(UIView *)changeView sizeChangeBlock:(WYSizeChangedBlock)changeBlock minWidth:(CGFloat)minWidth;
- (void)loadState:(BOOL)state;

@end

NS_ASSUME_NONNULL_END

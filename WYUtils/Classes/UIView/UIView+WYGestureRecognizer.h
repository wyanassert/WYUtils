//
//  UIView+WYGestureRecognizer.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TapActionBlock)(UITapGestureRecognizer *gestureRecoginzer);
typedef void (^LongPressActionBlock)(UILongPressGestureRecognizer *gestureRecoginzer);

@interface UIView (WYGestureRecognizer)

- (void)wy_addPanAction;
- (void)wy_addPinchAction;
- (void)wy_addRotateAction;
- (void)wy_addTapActionWithBlock:(TapActionBlock)block;
- (void)wy_addLongPressActionWithBlock:(LongPressActionBlock)block;
@end

NS_ASSUME_NONNULL_END

//
//  UIView+WYGestureRecognizer.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2018/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WYGestureRecognizer)

- (void)wy_addPanAction;
- (void)wy_addPinchAction;
- (void)wy_addRotateAction;

@end

NS_ASSUME_NONNULL_END

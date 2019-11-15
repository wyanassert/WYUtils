//
//  UIView+WYSubView.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WYSubView)

- (UIView *)wy_findSubViewWithClass:(Class)clazz;
- (NSArray *)wy_findAllSubViewsWithClass:(Class)clazz;
- (UIViewController *)wy_findViewController;
@end

NS_ASSUME_NONNULL_END

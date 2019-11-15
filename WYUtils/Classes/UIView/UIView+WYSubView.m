//
//  UIView+WYSubView.m
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/11/15.
//

#import "UIView+WYSubView.h"

@implementation UIView (WYSubView)

- (UIView *)wy_findSubViewWithClass:(Class)clazz {
    for (UIView * subView in self.subviews) {
        if ([subView isKindOfClass:clazz]) {
            return subView;
        }
    }
    return nil;
}

- (NSArray *)wy_findAllSubViewsWithClass:(Class)clazz {
    NSMutableArray *array = [NSMutableArray array];
    for (UIView * subView in self.subviews) {
        if ([subView isKindOfClass:clazz]) {
            [array addObject:subView];
        }
    }
    return array;
}

- (UIViewController *)wy_findViewController; {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    while (responder);
    return nil;
}

@end

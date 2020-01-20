//
//  WYCustomButton.h
//  Masonry
//
//  Created by wyan on 2020/1/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WYButtonEdgeInsetsStyle) {
    WYButtonEdgeInsetsStyleTop,
    WYButtonEdgeInsetsStyleLeft,
    WYButtonEdgeInsetsStyleBottom,
    WYButtonEdgeInsetsStyleRight,
};

@interface WYCustomButton : UIButton

- (instancetype)initWithEdgeInsetsStyle:(WYButtonEdgeInsetsStyle)style;

@property (nonatomic, assign) CGFloat         interval;

@end

NS_ASSUME_NONNULL_END

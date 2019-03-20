//
//  WYDisplayImageView.h
//  Pods-WYUtils_Example
//
//  Created by wyan on 2019/3/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYDisplayImageView : UIView

- (instancetype)initWithImage:(UIImage *)image andSize:(CGSize)size;
- (void)loadImage:(UIImage *)image withSize:(CGSize)size;
@property (nonatomic, copy) void(^clickImageBlock)(WYDisplayImageView *displayView, UIImage *image);

@end

NS_ASSUME_NONNULL_END


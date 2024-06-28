//
//  WYHalfScreenView.h
//  WYUtils_Example
//
//  Created by wyan on 2024/6/28.
//  Copyright © 2024 wyanassert. All rights reserved.
//

#import <WYUtils/WYUtils.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYHalfScreenView : WYBaseView

/// 展示
- (void)show;
/// 隐藏
- (void)hide;

/// 最小高度, 跟歌曲 AS 一致
+ (CGFloat)actionSheetViewMinHeight;
/// 最大高度, 跟播放列表一致
+ (CGFloat)actionSheetViewMaxHeight;

@end

NS_ASSUME_NONNULL_END

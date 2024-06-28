//
//  UIViewHalfScreen.h
//  WYUtils
//
//  Created by wyan on 2024/6/17.
//  
//  UIView 半屏/全屏弹窗 嵌套 UITableView 效果, 并且支持手势操控(类似专辑页效果, 目前已经用到加到歌单浮窗, 参考 QMAddSongToFolderActionSheet)

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WYHalfScreenStatus)
{
    /// 隐藏
    WYHalfScreenStatus_Hide = 0,
    /// 半屏, 默认状态
    WYHalfScreenStatus_HalfScreen,
    /// 接近满屏
    WYHalfScreenStatus_FullScreen,
    /// 正在动画
    WYHalfScreenStatus_Animating,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WYHalfScreen)

@property (nonatomic, strong) UIScrollView *hs_scrollView;

/** 页面布局相关 */
@property (nonatomic, assign) CGFloat hs_viewHeight; // 整个页面高度, 默认是屏幕高
@property (nonatomic, assign) CGFloat hs_minHeight; // 半屏屏幕高度, 默认是屏幕高的一半
@property (nonatomic, assign) CGFloat hs_maxHeight; // 全屏屏幕高度, 默认是屏幕高 减去 顶部安全高度

/** 收起手势相关, 请不要使用这些值 */
/// 当前状态
@property (nonatomic, assign) WYHalfScreenStatus hs_actionStyle;
/// 滑动时记录contentOffsetY，为了判断上滑下滑
@property (nonatomic, assign) CGFloat hs_contentOffsetY;
/// 滑动初始的偏移，为了判断是否触发轻扫收起
@property (nonatomic, assign) CGFloat hs_contentOffsetYForBeginDrag;
/// 是否跟指，为了处理手指未放开时上下滑动
@property (nonatomic, assign) BOOL hs_isFollowFinger;
@property (nonatomic, copy  ) void (^hs_hideBlock)(void);


/// 初始化方法
/// @param dragView 响应拖动的区域, 一般在列表 View 上面(scrollView 覆盖不到, 但是也想支持手势, 可以用这个来支持)
/// @param dragDelegate 拖动手势, dragView 会响应一个拖动手势, 可以实现下 gestureRecognizerShouldBegin, 并调用 hs_gestureRecognizerShouldBegin
/// @param scrollView 列表 View, 此分类主要通过 scrollView 的 scrollViewDidScroll 回调驱动整个 AS
/// @param hideCompletion 关闭回调
- (void)hs_commonInitialWithDragView:(UIView *)dragView
                        dragDelegate:(id<UIGestureRecognizerDelegate>)dragDelegate
                          scrollView:(UIScrollView *)scrollView
                      hideCompletion:(void (^)(void))hideCompletion;

/// 手势回调,
- (BOOL)hs_gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
/// scrollView 的回调, 麻烦再业务中调用下
- (void)hs_scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)hs_scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)hs_scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)hs_scrollViewDidEndDragging:(UIScrollView *)scrollView
                     willDecelerate:(BOOL)decelerate;
- (void)hs_scrollViewWillEndDragging:(UIScrollView *)scrollView
                        withVelocity:(CGPoint)velocity
                 targetContentOffset:(inout CGPoint *)targetContentOffset;

/// 打开浮层动画
- (void)hs_show:(void (^)(void))animation completion:(void (^)(void))completion;
/// 收起 AS 浮层动画,
- (void)hs_hide:(void (^)(void))animation completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END

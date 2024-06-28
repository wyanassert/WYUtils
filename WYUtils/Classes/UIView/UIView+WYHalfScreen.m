//
//  UIViewHalfScreen.m
//  WYUtils
//
//  Created by wyan on 2024/6/17.
//  
//

#import "UIView+WYHalfScreen.h"
#import <objc/runtime.h>
#import "UIView+WYPosition.h"
#import "WYAssert.h"
#import "WYMacroHeader.h"

@implementation UIView (WYHalfScreen)

- (void)hs_commonInitialWithDragView:(UIView *)dragView
                        dragDelegate:(id<UIGestureRecognizerDelegate>)dragDelegate
                          scrollView:(UIScrollView *)scrollView
                      hideCompletion:(nonnull void (^)(void))hideCompletion
{
    WYASSERT(dragView && scrollView);
    self.hs_scrollView = scrollView;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hs_didPan:)];
    panGesture.delegate = dragDelegate;
    [dragView addGestureRecognizer:panGesture];
    
    self.hs_hideBlock = hideCompletion;
}

- (BOOL)hs_gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    WYASSERT(self.hs_scrollView);
    BOOL shouldBegin = NO;
    switch (self.hs_actionStyle)
    {
        case QMAddSongToFolderStatus_Animating:
        case QMAddSongToFolderStatus_Hide:
            shouldBegin = NO;
            break;
        case QMAddSongToFolderStatus_HalfScreen:
        case QMAddSongToFolderStatus_FullScreen:
            shouldBegin = YES;
            break;
        default:
            break;
    }
    return shouldBegin;
}

- (void)hs_scrollViewDidScroll:(UIScrollView *)scrollView
{
    WYASSERT(self.hs_scrollView);
    BOOL shouldLocateBgView = self.hs_actionStyle == QMAddSongToFolderStatus_FullScreen ||
    (self.hs_actionStyle == QMAddSongToFolderStatus_HalfScreen && (self.hs_scrollView.contentOffset.y <= 0 || self.hs_contentOffsetY <= 0 || scrollView.contentOffset.y >= self.hs_contentOffsetY + 1));
    if (shouldLocateBgView)
    {
        if (scrollView.contentOffset.y < self.hs_contentOffsetY) // 正在向下滑
        {
            // 向下滑，tableview已经置顶则响应as滑动
            if (self.hs_contentOffsetY <= self.hs_contentOffsetYForBeginDrag && self.hs_isFollowFinger && self.hs_scrollView.contentOffset.y < 0)
            {
                self.y -= self.hs_scrollView.contentOffset.y;
                [self.hs_scrollView setContentOffset:CGPointMake(self.hs_scrollView.contentOffset.x, 0) animated:NO];
            }
        }
        else if (scrollView.contentOffset.y >= self.hs_contentOffsetY + 1)// 否则正在向上滑, 大于等于1个点再处理, 不用太灵敏, 容易误判
        {
            if (self.hs_isFollowFinger || self.hs_actionStyle == QMAddSongToFolderStatus_HalfScreen)
            {
                // 向上滑，还在跟指状态下时优先改变as高度，直至到达最高点，再响应内部tableview的滚动
                CGFloat actionViewY = self.y - (scrollView.contentOffset.y - self.hs_contentOffsetY);
                self.y = MAX(actionViewY, self.hs_viewHeight - self.hs_maxHeight);
                // 往上滑的时候, tableView 底部可能会漏出来, 把底部填充下
                self.height = MAX(self.height, self.hs_viewHeight - self.y);
                if (self.y > (self.hs_viewHeight - self.hs_maxHeight))
                {
                    if (self.hs_actionStyle == QMAddSongToFolderStatus_HalfScreen)
                    {
                        [self.hs_scrollView setContentOffset:CGPointMake(self.hs_scrollView.contentOffset.x, MAX(self.hs_contentOffsetY, 0)) animated:NO];
                    }
                    else
                    {
                        [self.hs_scrollView setContentOffset:CGPointMake(self.hs_scrollView.contentOffset.x, 0) animated:NO];
                    }
                }
            }
            else
            {
                if (self.y != (self.hs_viewHeight - self.hs_maxHeight))
                {
                    self.y = self.hs_viewHeight - self.hs_maxHeight;
                    [self.hs_scrollView setContentOffset:CGPointMake(self.hs_scrollView.contentOffset.x, 0)];
                }
            }
        }
    }
    
    self.hs_contentOffsetY = scrollView.contentOffset.y;
}

- (void)hs_scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    WYASSERT(self.hs_scrollView);
    if (self.hs_actionStyle == QMAddSongToFolderStatus_Animating)
    {
        return; // 正在拖曳, 不响应
    }
    self.hs_isFollowFinger = YES;
    self.hs_contentOffsetY = scrollView.contentOffset.y;
    self.hs_contentOffsetYForBeginDrag = scrollView.contentOffset.y;
}

- (void)hs_scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    WYASSERT(self.hs_scrollView);
    if (self.hs_actionStyle == QMAddSongToFolderStatus_Animating)
    {
        return; // 正在拖转, 不响应
    }
    self.hs_isFollowFinger = NO;
    [self hs_stoppedScrollingForExposure];
}

- (void)hs_scrollViewDidEndDragging:(UIScrollView *)scrollView
                    willDecelerate:(BOOL)decelerate
{
    WYASSERT(self.hs_scrollView);
    if (self.hs_actionStyle == QMAddSongToFolderStatus_Animating)
    {
        return; // 正在拖转, 不响应
    }
    self.hs_isFollowFinger = NO;
    if (!decelerate)
    {
        [self hs_stoppedScrollingForExposure];
    }
}

- (void)hs_scrollViewWillEndDragging:(UIScrollView *)scrollView
                       withVelocity:(CGPoint)velocity
                targetContentOffset:(inout CGPoint *)targetContentOffset
{
    WYASSERT(self.hs_scrollView);
    if (self.hs_actionStyle == QMAddSongToFolderStatus_Animating)
    {
        return; // 正在拖转, 不响应
    }
    if (self.hs_contentOffsetYForBeginDrag == 0 )
    {
        if (velocity.y < -1.5)// 快速下滑
        {
            // 轻扫关闭
            self.hs_isFollowFinger = NO;
            if (self.hs_actionStyle == QMAddSongToFolderStatus_HalfScreen)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.hs_actionStyle = QMAddSongToFolderStatus_Animating;
                    [self hs_hide];
                });
            }
            else if (self.hs_actionStyle == QMAddSongToFolderStatus_FullScreen)
            {
                self.hs_actionStyle = QMAddSongToFolderStatus_Animating;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self hs_changeToHalfScreen];
                });
            }
            else
            {
                
            }
            
            return;
        }
        else if (velocity.y > 1.5) // 快速上划
        {
            if (self.hs_actionStyle == QMAddSongToFolderStatus_HalfScreen)
            {
                *targetContentOffset = CGPointMake((*targetContentOffset).x, scrollView.contentOffset.y); // 这个场景 scrollView 还是不要动了
                self.hs_isFollowFinger = NO;
                self.hs_actionStyle = QMAddSongToFolderStatus_Animating;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self hs_changeToFullScreen];
                });
                return;
            }
        }
    }
    
    
    // tableView 往上滑一段后, 轻扫屏幕往下, tableView 会慢吞吞的往下走, 甚至还会回弹一下子(系统动画)
    // 导致 scrollViewDidiScroll 一直在回调, 后续再次拖曳会闪动, 在这里加快下动画
    if (scrollView.contentOffset.y > 0 && velocity.y <= 0 && (*targetContentOffset).y <= 0)
    {
        // 必需下一次 runloop 再处理, 不然动画会出问题
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            } completion:^(BOOL finished) {
            }];
        });
    }
}

- (void)hs_hide:(void (^)(void))animation completion:(void (^)(void))completion
{
    WY_WEAK_SELF(self);
    self.hs_actionStyle = QMAddSongToFolderStatus_Animating;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        WY_STRONG_SELF(self);
        [self setY:WY_SCREEN_HEIGHT];
        if (animation) animation();
    } completion:^(BOOL finished) {
        WY_STRONG_SELF(self);
        self.hs_actionStyle = QMAddSongToFolderStatus_Hide;
        if (completion) completion();
    }];
}

- (void)hs_show:(void (^)(void))animation completion:(void (^)(void))completion
{
    WYASSERT(self.hs_scrollView);
    CGFloat bounceHeight = 5.f;
    WY_WEAK_SELF(self);
    self.hs_actionStyle = QMAddSongToFolderStatus_Animating;
    [self setY:WY_SCREEN_HEIGHT];
    [UIView animateWithDuration:0.16
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        WY_STRONG_SELF(self);
        CGFloat showY = self.hs_viewHeight - self.hs_minHeight - bounceHeight;
        [self setY:showY];
        self.height = self.hs_minHeight;
        if (animation) animation();
    } completion:^(BOOL finished) {
        WY_STRONG_SELF(self);
        [UIView animateWithDuration:0.24
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            WY_STRONG_SELF(self);
            CGFloat showY = self.hs_viewHeight - self.hs_minHeight;
            [self setY:showY];
            self.height = self.hs_minHeight;
        } completion:^(BOOL finished) {
            self.hs_actionStyle = QMAddSongToFolderStatus_HalfScreen;
            if (completion) completion();
        }];
    }];
}

#pragma mark - Private

- (void)hs_hide
{
    if (self.hs_hideBlock) self.hs_hideBlock();
}

- (void)hs_animation:(void (^)(void))animation completion:(void (^)(void))completion
{
    self.hs_scrollView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:animation completion:^(BOOL finished) {
        if (completion) completion();
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.hs_scrollView.userInteractionEnabled = YES; // 防止连续手势
        });
    }];
}

- (void)hs_changeToHalfScreen
{
    CGFloat maxY = self.hs_viewHeight - self.hs_minHeight;
    self.hs_actionStyle = QMAddSongToFolderStatus_Animating;
    WY_WEAK_SELF(self);
    [self hs_animation:^{
        WY_STRONG_SELF(self);
        self.y = maxY;
    } completion:^{
        WY_STRONG_SELF(self);
        self.hs_actionStyle = QMAddSongToFolderStatus_HalfScreen;
        self.y = maxY;
        // 结束再缩小 TableView 的高度
        self.height = self.hs_viewHeight - self.y;
    }];
}

- (void)hs_changeToFullScreen
{
    CGFloat minY = self.hs_viewHeight - self.hs_maxHeight;
    self.hs_actionStyle = QMAddSongToFolderStatus_Animating;
    WY_WEAK_SELF(self);
    [self hs_animation:^{
        WY_STRONG_SELF(self);
        self.y = minY;
        self.height = self.hs_viewHeight - self.y;
    } completion:^{
        WY_STRONG_SELF(self);
        self.hs_actionStyle = QMAddSongToFolderStatus_FullScreen;
    }];
}

- (void)hs_stoppedScrollingForExposure
{
    [self hs_checkASPosiWhenScrollStop:0];
}

- (void)hs_checkASPosiWhenScrollStop:(CGFloat)velocityY
{
    CGFloat minY = self.hs_viewHeight - self.hs_maxHeight;
    CGFloat maxY = self.hs_viewHeight - self.hs_minHeight;
    CGFloat cancelY = maxY + self.hs_minHeight / 4;
    if (velocityY > 100) // 快速下滑
    {
        if (self.y > maxY) // 在半屏以下
        {
            [self hs_hide];
        }
        else
        {
            [self hs_changeToHalfScreen];
        }
    }
    else if (velocityY < -100) // 快速上划
    {
        if (self.y > maxY) // 在半屏以下
        {
            [self hs_changeToHalfScreen];
        }
        else
        {
            [self hs_changeToFullScreen];
        }
    }
    else
    {
        if (self.y > cancelY)
        {
            [self hs_hide];
        }
        else if (self.y > (minY + maxY) / 2.0)
        {
            [self hs_changeToHalfScreen];
        }
        else
        {
            [self hs_changeToFullScreen];
        }
    }
}

#pragma mark - Action

- (void)hs_didPan:(UIPanGestureRecognizer *)gesture
{
    CGPoint touchPoint = [gesture translationInView:self];
    CGPoint velocity = [gesture velocityInView:self];
    [gesture setTranslation:CGPointZero inView:self];
    CGFloat y = self.y + touchPoint.y;
    y = MIN(self.hs_viewHeight, MAX((self.hs_viewHeight - self.hs_maxHeight), y));
    self.y = y;
    self.height = MAX(self.hs_viewHeight - self.y, self.hs_minHeight);
    UIGestureRecognizerState state = [gesture state];
    switch (state)
    {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            {
                self.hs_isFollowFinger = NO;
                [self hs_checkASPosiWhenScrollStop:velocity.y];
            }
            break;
            
        default:
            self.hs_actionStyle = QMAddSongToFolderStatus_Animating;
            break;
    }
}


#pragma mark - Getter & Setter

- (UIScrollView *)hs_scrollView
{
    return objc_getAssociatedObject(self, @selector(hs_scrollView));
}

- (void)setHs_scrollView:(UIScrollView *)hs_scrollView
{
    objc_setAssociatedObject(self, @selector(hs_scrollView), hs_scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)hs_viewHeight
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(hs_viewHeight));
    return number ? [number floatValue] : WY_SCREEN_HEIGHT;
}

- (void)setHs_viewHeight:(CGFloat)hs_viewHeight
{
    objc_setAssociatedObject(self, @selector(hs_viewHeight), @(hs_viewHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)hs_minHeight
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(hs_minHeight));
    return number ? [number floatValue] : WY_SCREEN_HEIGHT / 2;
}

- (void)setHs_minHeight:(CGFloat)hs_minHeight
{
    objc_setAssociatedObject(self, @selector(hs_minHeight), @(hs_minHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)hs_maxHeight
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(hs_maxHeight));
    return number ? [number floatValue] : (WY_SCREEN_HEIGHT - WYDeviceNaviHeight);
}

- (void)setHs_maxHeight:(CGFloat)hs_maxHeight
{
    objc_setAssociatedObject(self, @selector(hs_maxHeight), @(hs_maxHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (QMAddSongToFolderStatus)hs_actionStyle
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(hs_actionStyle));
    return [number unsignedIntegerValue];
}

- (void)setHs_actionStyle:(QMAddSongToFolderStatus)hs_actionStyle
{
    objc_setAssociatedObject(self, @selector(hs_actionStyle), @(hs_actionStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)hs_contentOffsetY
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(hs_contentOffsetY));
    return [number floatValue];
}

- (void)setHs_contentOffsetY:(CGFloat)hs_contentOffsetY
{
    objc_setAssociatedObject(self, @selector(hs_contentOffsetY), @(hs_contentOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)hs_contentOffsetYForBeginDrag
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(hs_contentOffsetYForBeginDrag));
    return [number floatValue];
}

- (void)setHs_contentOffsetYForBeginDrag:(CGFloat)hs_contentOffsetYForBeginDrag
{
    objc_setAssociatedObject(self, @selector(hs_contentOffsetYForBeginDrag), @(hs_contentOffsetYForBeginDrag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hs_isFollowFinger
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(hs_isFollowFinger));
    return [number boolValue];
}

- (void)setHs_isFollowFinger:(BOOL)hs_isFollowFinger
{
    objc_setAssociatedObject(self, @selector(hs_isFollowFinger), @(hs_isFollowFinger), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))hs_hideBlock
{
    return objc_getAssociatedObject(self, @selector(hs_hideBlock));
}

- (void)setHs_hideBlock:(void (^)(void))hs_hideBlock
{
    objc_setAssociatedObject(self, @selector(hs_hideBlock), hs_hideBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

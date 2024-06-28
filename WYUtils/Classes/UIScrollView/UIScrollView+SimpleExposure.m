//
//  UIScrollView+SimpleExposure.m
//  WYUtils
//
//  Created by wyan on 2024/6/28.
//  Copyright © 2024 wyanassert. All rights reserved.
//

#import "UIScrollView+SimpleExposure.h"
#import <objc/runtime.h>
#import "WYAssert.h"
#import "WYSafeCast.h"

@implementation UIScrollView (SimpleExposure)

- (void)simple_markScrollViewDidScroll
{
    ASSERT_MAIN_THREAD;
    NSMutableArray<NSString *> *mutableArray = [NSMutableArray array];
    NSMutableDictionary<NSString *, UIView<WYScrollViewItemSimpleExposureProtocol> *> *storeSubviewDict = [NSMutableDictionary dictionary];
    for (UIView *view in [self simple_allSubViews].copy)
    {
        if ([view conformsToProtocol:@protocol(WYScrollViewItemSimpleExposureProtocol)])
        {
            if ([view respondsToSelector:@selector(simple_exposureIdentifier)])
            {
                UIView<WYScrollViewItemSimpleExposureProtocol> *simpleView = (UIView<WYScrollViewItemSimpleExposureProtocol> *)view;
                NSString *identifier = WYSAFE_CAST([simpleView simple_exposureIdentifier], NSString);
                if (identifier.length > 0 &&
                    simpleView &&
                    CGRectIntersectsRect(self.bounds, simpleView.frame))
                {
                    [mutableArray addObject:identifier];
                    [storeSubviewDict setObject:simpleView forKey:identifier];
                }
            }
        }
    }
    for (NSString *oldStr in [self configLogExposureList].copy)
    {
        if (![mutableArray containsObject:oldStr])
        {
            // 之前曝光过 但是现在不在屏幕上了, 移除掉下次再出现就可以曝光
            [[self configLogExposureList] removeObject:oldStr];
        }
    }
    for (NSString *str in mutableArray.copy)
    {
        if (![[self configLogExposureList] containsObject:str])
        {
            UIView<WYScrollViewItemSimpleExposureProtocol> *simpleView = storeSubviewDict[str];
            if (simpleView)
            {
                // 之前没曝光过, 但是现在在屏幕上, 曝光
                [[self configLogExposureList] addObject:str];
                [self exposureForSubview:simpleView identifier:str];
            }
        }
    }
}

#pragma mark - QMScrollViewSimpleExposureProtocol

- (void)simple_exposureWhenNeed
{
    ASSERT_MAIN_THREAD;
    for (UIView *view in [self simple_allSubViews].copy)
    {
        if ([view conformsToProtocol:@protocol(WYScrollViewItemSimpleExposureProtocol)])
        {
            if ([view respondsToSelector:@selector(simple_exposureIdentifier)])
            {
                UIView<WYScrollViewItemSimpleExposureProtocol> *simpleView = (UIView<WYScrollViewItemSimpleExposureProtocol> *)view;
                NSString *identifier = WYSAFE_CAST([simpleView simple_exposureIdentifier], NSString);
                if (identifier.length > 0)
                {
                    if (![[self configLogExposureList] containsObject:identifier])
                    {
                        [[self configLogExposureList] addObject:identifier];
                        [self exposureForSubview:simpleView identifier:identifier];
                    }
                }
            }
        }
    }
}

- (void)simple_markInvisibleForExposure
{
    ASSERT_MAIN_THREAD;
    [[self configLogExposureList] removeAllObjects];
}

#pragma mark - Private
// 先用 visibleCells 吧,
// 第一次出现曝光有自动布局, frame 计算容易出问题
- (NSArray<UIView *> *)simple_allSubViews
{
    if ([self isKindOfClass:[UITableView class]])
    {
        UITableView *tableView = (UITableView *)self;
        return [tableView visibleCells];
    }
    else if ([self isKindOfClass:[UITableView class]])
    {
        UICollectionView *collectionView = (UICollectionView *)self;
        return [collectionView visibleCells];
    }
    else
    {
        return self.subviews;
    }
}

- (NSMutableArray<NSString *> *)configLogExposureList
{
    if (self.logExposureList == nil)
    {
        self.logExposureList = [NSMutableArray array];
    }
    return self.logExposureList;
}

- (void)exposureForSubview:(UIView<WYScrollViewItemSimpleExposureProtocol> *)subView
                identifier:(NSString *)identifier
{
    if ([subView respondsToSelector:@selector(simple_exposureStatInfo:)])
    {
        [subView simple_exposureStatInfo:identifier];
    }
}

#pragma mark - Getter && Setter

- (NSMutableArray<NSString *> *)logExposureList
{
    return objc_getAssociatedObject(self, @selector(logExposureList));
}

- (void)setLogExposureList:(NSMutableArray<NSString *> *)logExposureList
{
    objc_setAssociatedObject(self, @selector(logExposureList), logExposureList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

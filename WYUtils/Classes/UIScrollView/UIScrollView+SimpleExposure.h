//
//  UIScrollView+SimpleExposure.h
//  WYUtils
//
//  Created by wyan on 2024/6/28.
//  Copyright © 2024 wyanassert. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WYScrollViewSimpleExposureProtocol <NSObject>

// 在需要曝光时候调用
- (void)simple_exposureWhenNeed;
// 标记 ScrollView 不可见了
- (void)simple_markInvisibleForExposure;

@end

@protocol WYScrollViewItemSimpleExposureProtocol <NSObject>

// 返回曝光 ID
- (NSString *)simple_exposureIdentifier;
// 曝光回调
- (void)simple_exposureStatInfo:(NSString *)identifier;

@end

@interface UIScrollView (SimpleExposure) <WYScrollViewSimpleExposureProtocol>

@property (nonatomic, strong) NSMutableArray<NSString *> *logExposureList;

// scrollView 停止滑动时候调用
- (void)simple_markScrollViewDidScroll;

@end

NS_ASSUME_NONNULL_END

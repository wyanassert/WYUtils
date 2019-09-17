//
//  WYExchangeWidgetView.h
//  ShakeCollage
//
//  Created by wyan on 2019/9/17.
//  Copyright © 2019 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYExchangeWidgetView : UIView

- (void)addWidgetsForExchange:(NSArray<UIView *>*)widgetList;
- (void)didExchangeView1:(UIView *)view1 andView2:(UIView *)view2;
- (void)didEndLongPress;

@end

NS_ASSUME_NONNULL_END

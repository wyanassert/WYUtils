//
//  WYViewController.h
//  WanYan
//
//  Created by 李袁野 on 2018/7/23.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYNavigationItemType.h"
#import "WYMacroHeader.h"

@interface WYViewController : UIViewController

@property (nonatomic)                   BOOL                                    base_shouldAutorotate;  //  Default is NO
@property (nonatomic)                   UIInterfaceOrientationMask              base_supportedInterfaceOrientations;    //  Default is UIInterfaceOrientationMaskPortrait
@property (nonatomic)                   UIInterfaceOrientation                  base_preferredInterfaceOrientationForPresentation;  //  Default is UIInterfaceOrientationPortrait

@property (nonatomic)                   BOOL                                    base_statusBarHidden;   //  Default is NO
@property (nonatomic)                   UIStatusBarStyle                        base_statusBarStyle;    //  Default is UIStatusBarStyleDefault

@property (nonatomic)                   BOOL                                    base_navigationBarTranslucent;  //  Default is NO
@property (nonatomic, strong)           UIColor                                 *base_navigationBarColor;   //  Default is whiteColor
@property (nonatomic, strong)           UIColor                                 *base_navigationBarTintColor;   //  Default is blueColor

@property (nonatomic, strong)           NSString                                *base_title;    //  Default is nil
@property (nonatomic, strong)           NSDictionary <NSAttributedStringKey,id> *base_titleTextAttributes;  //  Default is systemFontOfSize:16.f blackColor
@property (nonatomic, strong)           NSAttributedString                      *base_attributedTitle;  //  Default is nil

@property (nonatomic)                   BOOL                                    base_showBackTitle; //  Default is NO
@property (nonatomic, strong)           UIImage                                 *base_backImage;    //  Default is nil

@property (nonatomic, strong)           NSArray <WYNavigationItemType *>            *base_leftItems;    //  Default is nil
@property (nonatomic, strong)           NSArray <WYNavigationItemType *>            *base_rightItems;   //  Default is nil

@property (nonatomic)                   BOOL                                    base_automaticallyAdjustsScrollViewInsets;  //  Default is NO

//  Override to set property above
- (void)base_didInitialize;

//  Override to create custom navigation item
- (UIBarButtonItem *)base_navigationItemForItem:(WYNavigationItemType *)item;

//  Override to receive navigation item action
- (void)base_navigationItemAction:(UIBarButtonItem *)navigationItem item:(WYNavigationItemType *)item;

//  Call this method to get exist navigation item
- (UIBarButtonItem *)base_getNavigationItemForItem:(WYNavigationItemType *)item isRight:(BOOL)isRight;

@property (nonatomic, strong, readonly) UIView                                  *base_navigationBar;
@property (nonatomic, strong, readonly) UILabel                                 *base_titleLabel;


//loading
- (void)base_startLoadingAnimation;
- (void)base_stopLoadingAnimation;

@end

//
//  WYViewController.m
//  WanYan
//
//  Created by 李袁野 on 2018/7/23.
//  Copyright © 2018年 makeupopular.com. All rights reserved.
//

#import "WYViewController.h"
#import <objc/runtime.h>

static char WY_NAVIGATIONITEM;

@interface WYViewController ()

@property (nonatomic, strong)   UIView  *base_navigationBar;
@property (nonatomic, strong)   UILabel *base_titleLabel;

@property (nonatomic, strong) UIActivityIndicatorView *base_loadingView;

@end

@implementation WYViewController

#pragma mark - Life Cycle

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _base_shouldAutorotate = NO;
        _base_supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait;
        _base_preferredInterfaceOrientationForPresentation = UIInterfaceOrientationPortrait;
        _base_statusBarHidden = NO;
        _base_statusBarStyle = UIStatusBarStyleDefault;
        _base_navigationBarTranslucent = NO;
        _base_navigationBarColor = [UIColor whiteColor];
        _base_navigationBarTintColor = [UIColor blueColor];
        _base_title = nil;
        _base_titleTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:17.f], NSForegroundColorAttributeName : [UIColor blackColor]};
        _base_attributedTitle = nil;
        _base_showBackTitle = NO;
        _base_backImage = nil;
        _base_leftItems = nil;
        _base_rightItems = nil;
        _base_automaticallyAdjustsScrollViewInsets = NO;
        [self base_didInitialize];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self base_configViews];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSNumber *isVCBasedStatusBarAppearance = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"UIViewControllerBasedStatusBarAppearance"];
    if (isVCBasedStatusBarAppearance && ![isVCBasedStatusBarAppearance boolValue]) {
        [UIApplication sharedApplication].statusBarStyle = self.base_statusBarStyle;
        [UIApplication sharedApplication].statusBarHidden = self.base_statusBarHidden;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) {
        return;
    }
    navigationBar.tintColor = self.base_navigationBarTintColor;
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.base_navigationBar];
}

- (void)dealloc {
    
    if (self.navigationItem.leftBarButtonItem) {
        objc_setAssociatedObject(self.navigationItem.leftBarButtonItem, &WY_NAVIGATIONITEM, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (self.navigationItem.rightBarButtonItem) {
        objc_setAssociatedObject(self.navigationItem.rightBarButtonItem, &WY_NAVIGATIONITEM, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (self.navigationItem.leftBarButtonItems.count > 0) {
        
        for (UIBarButtonItem *barItem in self.navigationItem.leftBarButtonItems) {
            objc_setAssociatedObject(barItem, &WY_NAVIGATIONITEM, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    if (self.navigationItem.rightBarButtonItems.count > 0) {
        
        for (UIBarButtonItem *barItem in self.navigationItem.rightBarButtonItems) {
            objc_setAssociatedObject(barItem, &WY_NAVIGATIONITEM, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

#pragma mark - Override

- (BOOL)shouldAutorotate {
    return self.base_shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.base_supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.base_preferredInterfaceOrientationForPresentation;
}

- (BOOL)prefersStatusBarHidden {
    return self.base_statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.base_statusBarStyle;
}

#pragma mark - Config Views

- (void)base_configViews {
    
    [self base_configNavigationBar];
    [self base_configNavigationItem];
    [self base_refreshScrollView];
}

- (void)base_configNavigationBar {
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) {
        return;
    }
    navigationBar.translucent = YES;
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationBar.shadowImage = [UIImage new];
    navigationBar.tintColor = self.base_navigationBarTintColor;
    self.edgesForExtendedLayout = self.base_navigationBarTranslucent ? UIRectEdgeAll : (UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight);
    if (!self.base_navigationBar.superview) {
        
        [self.view addSubview:self.base_navigationBar];
        CGFloat navigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + navigationBar.frame.size.height;
        self.base_navigationBar.frame = CGRectMake(WYLEFT(self.view), self.base_navigationBarTranslucent?0:-navigationBarHeight, WYWIDTH(self.view), navigationBarHeight);
    }
}

- (void)base_configNavigationItem {
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) {
        return;
    }
    [self base_refreshTitleText];
    self.navigationItem.titleView = self.base_titleLabel;
    if (self.base_backImage) {
        
        navigationBar.backIndicatorImage = self.base_backImage;
        navigationBar.backIndicatorTransitionMaskImage = self.base_backImage;
    }
    [self base_refreshItems:self.base_leftItems isRight:NO];
    [self base_refreshItems:self.base_rightItems isRight:YES];
}

#pragma mark - Public Methods

- (void)base_didInitialize {
}

- (UIBarButtonItem *)base_navigationItemForItem:(WYNavigationItemType *)item {
    return nil;
}

- (void)base_navigationItemAction:(UIBarButtonItem *)navigationItem item:(WYNavigationItemType *)item {
}

- (UIBarButtonItem *)base_getNavigationItemForItem:(WYNavigationItemType *)item isRight:(BOOL)isRight {
    
    if (0 == item.length) {
        return nil;
    }
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) {
        return nil;
    }
    UIBarButtonItem *resultItem = nil;
    if (isRight) {
        
        if (self.navigationItem.rightBarButtonItems.count > 0) {
            
            for (UIBarButtonItem *barItem in self.navigationItem.rightBarButtonItems) {
                
                WYNavigationItemType *existItem = objc_getAssociatedObject(barItem, &WY_NAVIGATIONITEM);
                if (existItem.length > 0 && [item isEqualToString:existItem]) {
                    
                    resultItem = barItem;
                    break;
                }
            }
        } else if (self.navigationItem.rightBarButtonItem) {
            
            WYNavigationItemType *existItem = objc_getAssociatedObject(self.navigationItem.rightBarButtonItem, &WY_NAVIGATIONITEM);
            if (existItem.length > 0 && [item isEqualToString:existItem]) {
                resultItem = self.navigationItem.rightBarButtonItem;
            }
        }
    } else {
        
        if (self.navigationItem.leftBarButtonItems.count > 0) {
            
            for (UIBarButtonItem *barItem in self.navigationItem.leftBarButtonItems) {
                
                WYNavigationItemType *existItem = objc_getAssociatedObject(barItem, &WY_NAVIGATIONITEM);
                if (existItem.length > 0 && [item isEqualToString:existItem]) {
                    
                    resultItem = barItem;
                    break;
                }
            }
        } else if (self.navigationItem.leftBarButtonItem) {
            
            WYNavigationItemType *existItem = objc_getAssociatedObject(self.navigationItem.leftBarButtonItem, &WY_NAVIGATIONITEM);
            if (existItem.length > 0 && [item isEqualToString:existItem]) {
                resultItem = self.navigationItem.leftBarButtonItem;
            }
        }
    }
    return resultItem;
}

- (void)base_startLoadingAnimation {
    if (_base_loadingView) {
        [self.base_loadingView startAnimating];
    }
}

- (void)base_stopLoadingAnimation {
    if (_base_loadingView) {
        [self.base_loadingView stopAnimating];
    }
}

#pragma mark - Action Methods

- (void)base_barButtonItemAction:(UIBarButtonItem *)barItem {
    
    if (!barItem) {
        return;
    }
    WYNavigationItemType *item = objc_getAssociatedObject(barItem, &WY_NAVIGATIONITEM);
    [self base_navigationItemAction:barItem item:item];
}

#pragma mark - Private Methods

- (void)base_refreshTitleText {
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) {
        return;
    }
    if (self.base_attributedTitle.length > 0) {
        
        if (self.base_showBackTitle) {
            self.navigationItem.title = self.base_attributedTitle.string;
        } else {
            self.navigationItem.title = @" ";
        }
        self.base_titleLabel.attributedText = self.base_attributedTitle;
    } else if (self.base_title.length > 0) {
        
        if (self.base_showBackTitle) {
            self.navigationItem.title = self.base_title;
        } else {
            self.navigationItem.title = @" ";
        }
        self.base_titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.base_title attributes:self.base_titleTextAttributes];
    } else {
        
        if (self.base_showBackTitle) {
            self.navigationItem.title = nil;
        } else {
            self.navigationItem.title = @" ";
        }
        self.base_titleLabel.attributedText = nil;
    }
    [self.base_titleLabel sizeToFit];
}

- (UIBarButtonItem *)base_barButtonItemForItem:(WYNavigationItemType *)item {
    
    if (0 == item.length) {
        return nil;
    }
    UIBarButtonItem *barItem = nil;
    if ([item isEqualToString:WYNavigationItemTypeDone]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeCancel]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeEdit]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeSave]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeAdd]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeCompose]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeReply]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeAction]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeOrganize]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeBookmarks]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeSearch]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeRefresh]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeStop]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeCamera]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeTrash]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypePlay]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypePause]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeRewind]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeFastForward]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeUndo]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeRedo]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeFlexibleSpace]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeFixedSpace]) {
        barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    } else if ([item isEqualToString:WYNavigationItemTypeLoading]) {
        barItem = [[UIBarButtonItem alloc] initWithCustomView:self.base_loadingView];
    }
    if (!barItem) {
        barItem = [self base_navigationItemForItem:item];
    }
    if (barItem) {
        
        objc_setAssociatedObject(barItem, &WY_NAVIGATIONITEM, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (![item isEqualToString:WYNavigationItemTypeFlexibleSpace]
            && ![item isEqualToString:WYNavigationItemTypeFixedSpace]) {
            
            barItem.target = self;
            barItem.action = @selector(base_barButtonItemAction:);
        }
    }
    return barItem;
}

- (void)base_refreshItems:(NSArray <WYNavigationItemType *> *)items isRight:(BOOL)isRight {
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) {
        return;
    }
    NSMutableArray <UIBarButtonItem *> *barItems = [NSMutableArray array];
    for (WYNavigationItemType *item in items) {
        
        UIBarButtonItem *barItem = [self base_barButtonItemForItem:item];
        if (barItem) {
            [barItems addObject:barItem];
        }
    }
    if (isRight) {
        
        if (barItems.count > 1) {
            self.navigationItem.rightBarButtonItems = barItems;
        } else if (barItems.count > 0) {
            self.navigationItem.rightBarButtonItem = barItems.firstObject;
        } else {
            
            self.navigationItem.rightBarButtonItems = nil;
            self.navigationItem.rightBarButtonItem = nil;
        }
    } else {
        
        if (barItems.count > 1) {
            self.navigationItem.leftBarButtonItems = barItems;
        } else if (barItems.count > 0) {
            self.navigationItem.leftBarButtonItem = barItems.firstObject;
        } else {
            
            self.navigationItem.leftBarButtonItems = nil;
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
}

- (void)base_refreshScrollView {
    
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearanceWhenContainedInInstancesOfClasses:@[[WYViewController class]]].contentInsetAdjustmentBehavior = self.base_automaticallyAdjustsScrollViewInsets ? UIScrollViewContentInsetAdjustmentAutomatic : UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = self.base_automaticallyAdjustsScrollViewInsets;
    }
}

#pragma mark - Setters

- (void)setBase_statusBarHidden:(BOOL)base_statusBarHidden {
    
    _base_statusBarHidden = base_statusBarHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setBase_statusBarStyle:(UIStatusBarStyle)base_statusBarStyle {
    
    _base_statusBarStyle = base_statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setBase_navigationBarTranslucent:(BOOL)base_navigationBarTranslucent {
    
    _base_navigationBarTranslucent = base_navigationBarTranslucent;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) {
        return;
    }
    self.edgesForExtendedLayout = self.base_navigationBarTranslucent ? UIRectEdgeAll : (UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight);
    CGFloat navigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + navigationBar.frame.size.height;
    self.base_navigationBar.frame = CGRectMake(WYLEFT(self.view), self.base_navigationBarTranslucent?0:-navigationBarHeight, WYWIDTH(self.view), navigationBarHeight);
}

- (void)setBase_navigationBarColor:(UIColor *)base_navigationBarColor {
    
    _base_navigationBarColor = base_navigationBarColor;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) {
        return;
    }
    self.base_navigationBar.backgroundColor = base_navigationBarColor;
}

- (void)setBase_navigationBarTintColor:(UIColor *)base_navigationBarTintColor {
    
    _base_navigationBarTintColor = base_navigationBarTintColor;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) {
        return;
    }
    navigationBar.tintColor = base_navigationBarTintColor;
}

- (void)setBase_title:(NSString *)base_title {
    
    _base_title = base_title;
    [self base_refreshTitleText];
}

- (void)setBase_titleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)base_titleTextAttributes {
    
    _base_titleTextAttributes = base_titleTextAttributes;
    [self base_refreshTitleText];
}

- (void)setBase_attributedTitle:(NSAttributedString *)base_attributedTitle {
    
    _base_attributedTitle = base_attributedTitle;
    [self base_refreshTitleText];
}

- (void)setBase_showBackTitle:(BOOL)base_showBackTitle {
    
    _base_showBackTitle = base_showBackTitle;
    [self base_refreshTitleText];
}

- (void)setBase_backImage:(UIImage *)base_backImage {
    
    _base_backImage = base_backImage;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) {
        return;
    }
    navigationBar.backIndicatorImage = base_backImage;
    navigationBar.backIndicatorTransitionMaskImage = base_backImage;
}

- (void)setBase_leftItems:(NSArray<WYNavigationItemType *> *)base_leftItems {
    
    _base_leftItems = base_leftItems;
    [self base_refreshItems:base_leftItems isRight:NO];
}

- (void)setBase_rightItems:(NSArray<WYNavigationItemType *> *)base_rightItems {
    
    _base_rightItems = base_rightItems;
    [self base_refreshItems:base_rightItems isRight:YES];
}

- (void)setBase_automaticallyAdjustsScrollViewInsets:(BOOL)base_automaticallyAdjustsScrollViewInsets {
    
    _base_automaticallyAdjustsScrollViewInsets = base_automaticallyAdjustsScrollViewInsets;
    [self base_refreshScrollView];
}

#pragma mark - Getters

- (UIView *)base_navigationBar {
    
    if (!_base_navigationBar) {
        
        _base_navigationBar = [UIView new];
        _base_navigationBar.backgroundColor = self.base_navigationBarColor;
    }
    return _base_navigationBar;
}

- (UILabel *)base_titleLabel {
    
    if (!_base_titleLabel) {
        
        _base_titleLabel = [UILabel new];
        _base_titleLabel.numberOfLines = 0;
    }
    return _base_titleLabel;
}

- (UIActivityIndicatorView *)base_loadingView {
    if (!_base_loadingView) {
        _base_loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _base_loadingView.color = self.base_navigationBarTintColor;
    }
    return _base_loadingView;
}

@end

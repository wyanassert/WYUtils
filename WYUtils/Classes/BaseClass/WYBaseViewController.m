//
//  WYBaseViewController.m
//  GUBaseLib
//
//  Created by K999999999 on 2018/1/15.
//  Copyright © 2018年 K999999999. All rights reserved.
//

#import "WYBaseViewController.h"

@interface WYBaseViewController ()


@end

@implementation WYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Override

//  Override to set property above
- (void)base_didInitialize {
    self.base_navigationBarColor = [UIColor clearColor];
    self.base_navigationBarTranslucent = YES;
}

//  Override to create custom navigation item
- (UIBarButtonItem *)base_navigationItemForItem:(WYNavigationItemType *)item {
    
    return nil;
}

//  Override to receive navigation item action
- (void)base_navigationItemAction:(UIBarButtonItem *)navigationItem item:(WYNavigationItemType *)item {
    
}


@end

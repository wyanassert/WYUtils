//
//  SafeNavigationController.m
//  GUBaseLib
//
//  Created by K999999999 on 2018/1/15.
//  Copyright © 2018年 K999999999. All rights reserved.
//

#import "WYSafeNavigationController.h"

@interface WYSafeNavigationController ()

@end

@implementation WYSafeNavigationController

#pragma mark - Override

- (BOOL)shouldAutorotate {
    
    if (self.topViewController) {
        return self.topViewController.shouldAutorotate;
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    if (self.topViewController) {
        return self.topViewController.supportedInterfaceOrientations;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    if (self.topViewController) {
        return self.topViewController.preferredInterfaceOrientationForPresentation;
    }
    return UIInterfaceOrientationPortrait;
}

- (BOOL)prefersStatusBarHidden {
    
    if (self.topViewController) {
        return self.topViewController.prefersStatusBarHidden;
    }
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (self.topViewController) {
        return self.topViewController.preferredStatusBarStyle;
    }
    return UIStatusBarStyleDefault;
}

@end

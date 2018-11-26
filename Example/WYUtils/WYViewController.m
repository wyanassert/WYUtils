//
//  WYViewController.m
//  WYUtils
//
//  Created by wyanassert on 11/26/2018.
//  Copyright (c) 2018 wyanassert. All rights reserved.
//

#import "WYViewController.h"
#import "WYUtils.h"
#import "UIView+WYGestureRecognizer.h"

@interface WYViewController ()

@end

@implementation WYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *lb = [UILabel new];
    lb.frame = CGRectMake(50, 50, 100, 100);
    lb.text = @"Test For Pinch Pan and Rotate";
    lb.textColor = [UIColor blueColor];
    lb.font = [UIFont systemFontOfSize:12];
    lb.backgroundColor = [UIColor greenColor];
    [self.view addSubview:lb];
    lb.userInteractionEnabled = YES;
    [lb wy_addPanAction];
    [lb wy_addPinchAction];
    [lb wy_addRotateAction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

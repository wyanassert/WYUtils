//
//  WYDataViewController.m
//  WYUtils_Example
//
//  Created by wyan on 2019/11/27.
//  Copyright © 2019 wyanassert. All rights reserved.
//

#import "WYDataViewController.h"

@interface WYDataViewController ()

@end

@implementation WYDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        redView.backgroundColor = UIColor.redColor;
        
        [self.view addSubview:redView];
    }
    
    {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        redView.backgroundColor = [UIColor.blueColor colorWithAlphaComponent:0.2];
        
        redView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
        [self.view addSubview:redView];
    }
    
    {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        redView.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:0.1];
        
        redView.layer.anchorPoint = CGPointMake(0.5, 0.3);
//        redView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
        [self.view addSubview:redView];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

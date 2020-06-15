//
//  WYViewController.m
//  WYUtils
//
//  Created by wyanassert on 11/26/2018.
//  Copyright (c) 2018 wyanassert. All rights reserved.
//

#import "WYRootViewController.h"
#import "WYExamplePubHeader.h"
#import "WYHomeCollectionViewCell.h"
#import "WYColorViewController.h"
#import "WYDataViewController.h"
#import "WYDateViewController.h"
#import "WYDeviceViewController.h"
#import "WYFontViewController.h"
#import "WYImageViewController.h"
#import "WYLabelViewController.h"
#import "WYNavigationBarViewController.h"
#import "WYObejectViewController.h"
#import "WYOperationViewController.h"
#import "WYStringViewController.h"
#import "WYViewViewController.h"
#import "WYExampleViewController.h"

@interface WYRootViewController () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView         *collectionView;

@end

@implementation WYRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = @[
        @"WYDataViewController",
        @"WYDateViewController",
        @"WYObejectViewController",
        @"WYOperationViewController",
        @"WYStringViewController",
        @"WYColorViewController",
        @"WYDeviceViewController",
        @"WYFontViewController",
        @"WYImageViewController",
        @"WYLabelViewController",
        @"WYNavigationBarViewController",
        @"WYViewViewController",
    ][indexPath.row];
    
    NSString *descText = @[
        @"Data",
        @"Date",
        @"Object",
        @"Operation",
        @"String",
        @"Color",
        @"Device",
        @"Font",
        @"Image",
        @"Label",
        @"NavigationBar",
        @"View",
    ][indexPath.row];
    Class class = NSClassFromString(className);
    WYExampleViewController *vc = [[class alloc] init];
    vc.base_title = descText;
    vc.homeType = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return WYHomeTypeCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WYHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WYHomeCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell loadData:indexPath.row];
    return cell;
}


#pragma mark - Getter
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = WYMINSIZE(150, 150);
        flowLayout.minimumLineSpacing = WYMIN(20);
        flowLayout.minimumInteritemSpacing = WYMIN(20);
        flowLayout.sectionInset = UIEdgeInsetsMake(WYMIN(20), WYMIN(22), WYMIN(17), WYMIN(22));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
     
        [_collectionView registerClass:[WYHomeCollectionViewCell class] forCellWithReuseIdentifier:[WYHomeCollectionViewCell reuseIdentifier]];
    }
    return _collectionView;
}

@end

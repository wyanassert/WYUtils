//
//  WYScrollViewController.m
//  WYUtils_Example
//
//  Created by wyan on 2024/6/28.
//  Copyright © 2024 wyanassert. All rights reserved.
//

#import "WYScrollViewController.h"
#import "WYScrollCollectionViewCell.h"
#import "WYScrollExposureViewController.h"

@interface WYScrollViewController ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView         *collectionView;

@end

@implementation WYScrollViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configView];
}

- (void)configView 
{
    [self.view addSubview:self.collectionView];
    [self.collectionView setFrame:self.view.bounds];

}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case WYScrollTypeExposure: {
            WYScrollExposureViewController *vc = [[WYScrollExposureViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;;
        default:
            break;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return WYScrollTypeCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WYScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WYScrollCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell loadState:indexPath.row];
    return cell;
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(WY_SCREEN_WIDTH, WXX(40));
        flowLayout.minimumLineSpacing = WXX(10);
        flowLayout.minimumInteritemSpacing = WXX(10);
        flowLayout.sectionInset = UIEdgeInsetsMake(WYDeviceNaviHeight, 0, WYDeviceBottomHeight + WXY(10), 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
     
        [_collectionView registerClass:[WYScrollCollectionViewCell class] forCellWithReuseIdentifier:[WYScrollCollectionViewCell reuseIdentifier]];
    }
    return _collectionView;
}

@end

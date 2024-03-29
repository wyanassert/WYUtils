//
//  WYFontViewController.m
//  WYUtils_Example
//
//  Created by wyan on 2019/11/27.
//  Copyright © 2019 wyanassert. All rights reserved.
//

#import "WYFontViewController.h"
#import "WYFontCollectionViewCell.h"
#import "WYALLFontViewController.h"

@interface WYFontViewController ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView         *collectionView;

@end

@implementation WYFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configView];
}
- (void)configView {
    [self.view addSubview:self.collectionView];
    [self.collectionView setFrame:self.view.bounds];

}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case WYFontTypeAllFont: {
            WYALLFontViewController *vc = [[WYALLFontViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return WYFontTypeCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WYFontCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WYFontCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
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
     
        [_collectionView registerClass:[WYFontCollectionViewCell class] forCellWithReuseIdentifier:[WYFontCollectionViewCell reuseIdentifier]];
    }
    return _collectionView;
}

@end

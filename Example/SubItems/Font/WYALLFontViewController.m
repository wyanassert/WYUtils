//
//  WYALLFontViewController.m
//  WYUtils_Example
//
//  Created by wyan on 2023/7/19.
//  Copyright © 2023 wyanassert. All rights reserved.
//

#import "WYALLFontViewController.h"
#import "WYFontCollectionViewCell.h"

@interface WYALLFontViewController ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView         *collectionView;

@property (nonatomic, strong) NSArray<NSString *> *fonts;

@end

@implementation WYALLFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fonts = [UIFont wy_allFonts];
    [self configView];
}
- (void)configView {
    [self.view addSubview:self.collectionView];
    [self.collectionView setFrame:self.view.bounds];

}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.fonts[indexPath.row];
}

#pragma mark - UICollectionViewDelegateFlowLayout


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fonts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WYFontCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WYFontCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    NSString *fontName = self.fonts[indexPath.row];
    [cell loadText:[@"字体: " stringByAppendingString:fontName] fontName:fontName];
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

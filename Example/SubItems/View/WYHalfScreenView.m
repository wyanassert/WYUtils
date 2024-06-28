//
//  WYHalfScreenView.m
//  WYUtils_Example
//
//  Created by wyan on 2024/6/28.
//  Copyright © 2024 wyanassert. All rights reserved.
//

#import "WYHalfScreenView.h"
#import <Masonry.h>

@interface WYHalfScreenView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *topPanView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *testList;

@end

@implementation WYHalfScreenView

- (instancetype)init
{
    self = [super init];
    if (self) 
    {
        [self configSubViews];
    }
    return self;
}

#pragma mark - public
- (void)show
{
    // 不能直接在 VC 上弹出, 二级页边缘手势处理不了, 跟歌曲AS一样直接在 UIWindow 上弹出吧
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    WY_WEAK_SELF(self);
    [self hs_show:^{
        WY_STRONG_SELF(self);
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    } completion:^{
        
    }];
}

- (void)hide
{
    WY_WEAK_SELF(self);
    [self hs_hide:^{
        WY_STRONG_SELF(self);
        [self setBackgroundColor:[UIColor clearColor]];
    } completion:^{
        WY_STRONG_SELF(self);
        [self removeFromSuperview];
    }];
}

// 最小高度, 跟歌曲 AS 一致
+ (CGFloat)actionSheetViewMinHeight
{
    return WY_SCREEN_HEIGHT * 0.6;
}

// 最大高度, 跟播放列表一致
+ (CGFloat)actionSheetViewMaxHeight
{
    return WY_SCREEN_HEIGHT * 0.9;
}

#pragma mark - Private

- (void)configSubViews
{
    [super configSubViews];
    [self addTarget:self action:@selector(hide)];
    
    [self addSubview:self.topPanView];
    [self.topPanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(68);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.topPanView.mas_bottom);
    }];
    
    [self configGesture];
}

- (void)configGesture
{
    WY_WEAK_SELF(self);
    [self hs_commonInitialWithDragView:self.topPanView
                          dragDelegate:self
                            scrollView:self.tableView
                        hideCompletion:^{
        WY_STRONG_SELF(self);
        [self hide];
    }];
    self.hs_viewHeight = WY_SCREEN_HEIGHT;
    self.hs_minHeight = [self.class actionSheetViewMinHeight];
    self.hs_maxHeight = [self.class actionSheetViewMaxHeight];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.testList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[WYBaseTableViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.textLabel.text = [self.testList objectAtSafeIndex:indexPath.row ofClassType:NSString.class];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        [self hs_scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        [self hs_scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        [self hs_scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.tableView)
    {
        [self hs_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView == self.tableView)
    {
        [self hs_scrollViewWillEndDragging:scrollView
                              withVelocity:velocity
                       targetContentOffset:targetContentOffset];
    }
}

#pragma mark - Getter

- (UIView *)topPanView
{
    if (!_topPanView)
    {
        _topPanView = [[UIView alloc] init];
        _topPanView.backgroundColor = UIColor.greenColor;
    }
    return _topPanView;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[WYBaseTableViewCell class] forCellReuseIdentifier:[WYBaseTableViewCell reuseIdentifier]];
    }
    return _tableView;
}

- (NSArray<NSString *> *)testList
{
    if (!_testList)
    {
        NSMutableArray<NSString *> *mutableArray = [NSMutableArray array];
        int n = 100;
        while (n--)
        {
            [mutableArray addObject:[NSString stringWithFormat:@"testLog-%d", n]];
        }
        _testList = mutableArray.copy;
    }
    return _testList;
}

@end

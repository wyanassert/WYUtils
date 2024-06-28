//
//  WYScrollExposureViewController.m
//  WYUtils_Example
//
//  Created by wyan on 2024/6/28.
//  Copyright © 2024 wyanassert. All rights reserved.
//

#import "WYScrollExposureViewController.h"

@interface WYScrollExposureCell : WYBaseTableViewCell <WYScrollViewItemSimpleExposureProtocol>

@property (nonatomic, strong) NSString *data;

@end

@implementation WYScrollExposureCell

#pragma mark - WYScrollViewItemSimpleExposureProtocol
- (NSString *)simple_exposureIdentifier
{
    return WY_AVOID_NIL_STRING(self.data);
}

- (void)simple_exposureStatInfo:(NSString *)identifier;
{
    NSLog(@"Exposure %@", identifier);
}

@end

@interface WYScrollExposureViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<NSString *> *testList;

@end

@implementation WYScrollExposureViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubview];
    [self exposureWhenNeed];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self exposureWhenNeed];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self markInvisibleForExposure];
}

#pragma mark - Private

- (void)configSubview
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.testList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYScrollExposureCell *cell = [tableView dequeueReusableCellWithIdentifier:[WYScrollExposureCell reuseIdentifier] forIndexPath:indexPath];
    cell.textLabel.text = [self.testList objectAtSafeIndex:indexPath.row ofClassType:NSString.class];
    cell.data = [self.testList objectAtSafeIndex:indexPath.row ofClassType:NSString.class];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 40;
    switch (indexPath.row % 4) 
    {
        case 0:
            height = 40;
            break;
        case 1:
            height = 60;
            break;
        case 2:
            height = 80;
            break;
        case 3:
            height = 100;
            break;
        default:
            height = 40;
            break;
    }
    return height;
}

// 看需要可以打开, 或者做下限频, 比如一秒调用一次
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self stoppedScrollingForExposure];
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self stoppedScrollingForExposure];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self stoppedScrollingForExposure];
    }
}

- (void)stoppedScrollingForExposure
{
    [self.tableView simple_markScrollViewDidScroll];
}

#pragma mark - Exposure

- (void)exposureWhenNeed
{
    [self.tableView simple_exposureWhenNeed];
}

- (void)markInvisibleForExposure
{
    [self.tableView simple_markInvisibleForExposure];
}

#pragma mark - Getter

- (UITableView *)tableView 
{
    if (!_tableView) 
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(WYDeviceNaviHeight, 0, WYDeviceBottomHeight, 0);
        
        [_tableView registerClass:[WYScrollExposureCell class] forCellReuseIdentifier:[WYScrollExposureCell reuseIdentifier]];
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

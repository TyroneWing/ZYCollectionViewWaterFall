//
//  WaterFallViewController.m
//  ZYCollectionViewWaterFall
//
//  Created by yi on 16/3/9.
//  Copyright © 2016年 yi. All rights reserved.
//

#import "WaterFallViewController.h"
#import "ZYWaterFallCollectionViewFlowLayout.h"
#import "WaterFallCollectionViewCell.h"

static CGFloat const kMargin = 20.f;
static NSUInteger const kColumn = 3;
static NSUInteger const kSpace = 10;
static NSString * const reuseIdentifier = @"WaterFallCollectionViewCell";

@interface WaterFallViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZYWaterFallCollectionViewFlowLayout *layout;

@end

@implementation WaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataList = [NSMutableArray array];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - (kColumn+1)*kSpace)/kColumn;
//    CGFloat width = ([UIScreen mainScreen].bounds.size.width - (kColumn-1)*kMargin)/kColumn;
    
    for (NSUInteger idx = 0; idx <= 50; idx ++) {
        CGFloat height = 100 + (arc4random() % 100);
        NSValue *value = [NSValue valueWithCGSize:CGSizeMake(width, height)];
        [_dataList addObject:value];
    }
    
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                       reuseIdentifier forIndexPath:indexPath];
    
    cell.label.text = [NSString stringWithFormat:@"%zi", indexPath.row];
    cell.label.frame = cell.bounds;
//    NSLog(@"%ld %@",(long)indexPath.row,cell);
    return  cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = [[_dataList objectAtIndex:indexPath.row] CGSizeValue];
    
    return  size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat width = ([UIScreen mainScreen].bounds.size.width - (kColumn-1)*kMargin)/kColumn;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - (kColumn+1)*kSpace)/kColumn;
    for (NSUInteger idx = 0; idx < 10; idx ++) {
        CGFloat height = 100 + (arc4random() % 100);
        NSValue *value = [NSValue valueWithCGSize:CGSizeMake(width, height)];
        [_dataList addObject:value];
    }
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                             collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

- (ZYWaterFallCollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[ZYWaterFallCollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = kMargin;
        _layout.minimumLineSpacing = kMargin;
        _layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    }
    return _layout;
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

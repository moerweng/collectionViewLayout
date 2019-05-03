//
//  WHorizPagingViewController.m
//  CollectionViewLayout
//
//  Created by Jin on 2019/5/3.
//  Copyright © 2019年 Jin. All rights reserved.
//

#import "WHorizPagingViewController.h"
#import "ACollectionViewCell.h"
#import "WHorizPagingCollectionLayout.h"

static NSString *ACollectionViewCellReuse = @"ACollectionViewCell";

@interface WHorizPagingViewController ()
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WHorizPagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(ACollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:ACollectionViewCellReuse];
    
    WHorizPagingCollectionLayout *hlayout = [WHorizPagingCollectionLayout new];
    hlayout.row = 2;
    hlayout.column = 4;
    hlayout.itemSpacing = 5;
    hlayout.lineSpacing = 5;
    hlayout.margeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.collectionView.collectionViewLayout = hlayout;
    
    self.dataSource = [NSMutableArray array];
    
    int item = arc4random()%30+10;
    for (int i=0; i<item; i++) {
        [_dataSource addObject:@(i)];
    }
    
    [self.collectionView reloadData];
}

//MARK: CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ACollectionViewCellReuse forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"第 %ld 个", indexPath.row];
    return cell;
}


@end

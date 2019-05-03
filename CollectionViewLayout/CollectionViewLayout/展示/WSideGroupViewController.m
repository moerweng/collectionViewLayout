//
//  WSideGroupViewController.m
//  CollectionViewLayout
//
//  Created by Jin on 2019/5/3.
//  Copyright © 2019年 Jin. All rights reserved.
//

#import "WSideGroupViewController.h"
#import "ACollectionReusableView.h"
#import "ACollectionViewCell.h"
#import "WSideGroupCollectionLayout.h"

static NSString *ACollectionReusableViewReuse = @"ACollectionReusableView";
static NSString *ACollectionViewCellReuse = @"ACollectionViewCell";

@interface WSideGroupViewController ()
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <NSArray *> *dataSource;
@end

@implementation WSideGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(ACollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:ACollectionViewCellReuse];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(ACollectionReusableView.class) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ACollectionReusableViewReuse];
    
    WSideGroupCollectionLayout *layout = [[WSideGroupCollectionLayout alloc] init];
    layout.column = 3;
    layout.itemRadio = 1.1;
    layout.sectionWidth = 60;
    layout.itemSpacing = 5;
    layout.lineSpacing = 5;
    layout.sectionItemSpacing = 5;
    
    self.collectionView.collectionViewLayout = layout;
    
    self.dataSource = [NSMutableArray array];
    
    for (int i=0; i<10; i++) {
        NSMutableArray *items = [NSMutableArray array];
        int item = arc4random()%10+5;
        for (int j=0; j<item; j++) {
            [items addObject:@(j)];
        }
        [_dataSource addObject:items];
    }
    
    [self.collectionView reloadData];
}

//MARK: CollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ACollectionViewCellReuse forIndexPath:indexPath];
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ACollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ACollectionReusableViewReuse forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
        cell.label.text = [NSString stringWithFormat:@"第 %ld 组， 共 %ld 个", indexPath.section, [self.dataSource[indexPath.section] count]];
        return cell;
    }
    
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end

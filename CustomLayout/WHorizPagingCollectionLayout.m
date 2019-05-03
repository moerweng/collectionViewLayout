//
//  WHorizPagingCollectionLayout.m
//  WheelProj
//
//  Created by Jin on 2019/5/3.
//  Copyright © 2019年 Jin. All rights reserved.
//

#import "WHorizPagingCollectionLayout.h"

@interface WHorizPagingCollectionLayout ()
{
    CGFloat _itemW;
    CGFloat _itemH;
}
@property (nonatomic, strong) NSMutableDictionary <NSIndexPath *, UICollectionViewLayoutAttributes *> *itemsLayoutAttributes;
@end

@implementation WHorizPagingCollectionLayout

- (instancetype)init
{
    if (self = [super init])
    {
        self.itemsLayoutAttributes = [NSMutableDictionary dictionary];
        
        self.row = 4;
        self.column = 4;
        self.itemSpacing = 5;
        self.lineSpacing = 5;
        self.margeInsets = UIEdgeInsetsMake(10, 5, 10, 5);
    }
    return self;
}

- (void)prepareLayout
{
    [self.itemsLayoutAttributes removeAllObjects];
    
    // 计算出item宽高
    CGFloat contentW = self.collectionView.bounds.size.width;
    CGFloat contentH = self.collectionView.bounds.size.height;
    CGFloat spacingW = contentW - _margeInsets.left - _margeInsets.right - _itemSpacing * (_column - 1);
    _itemW = spacingW / (CGFloat)_column;
    CGFloat spacingH = contentH - _margeInsets.top - _margeInsets.bottom - _lineSpacing * (_row - 1);
    _itemH = spacingH / (CGFloat)_row;
    
    // item个数
    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat startX = 0;
    CGFloat startY = 0;
    for (int item = 0; item < itemCount ; item ++)
    {
        // 计算当前item的frame
        CGFloat rowSpacing = (item % self.column) * _itemSpacing;
        CGFloat totalItemWidth = (item % self.column) * _itemW;
        CGFloat itemX = startX + _margeInsets.left + rowSpacing + totalItemWidth;
        
        CGFloat lineSpacing = item % (_column * _row) / self.column * _lineSpacing;
        CGFloat totalItemHeight = item % (_column*_row) / self.column * _itemH;
        CGFloat itemY = startY + _margeInsets.top + lineSpacing + totalItemHeight;
        
        CGRect itemFrame = CGRectMake(itemX, itemY, _itemW, _itemH);
        
        // 添加item的布局属性
        NSIndexPath *itemIndexPath = [NSIndexPath indexPathForItem:item inSection:0];
        UICollectionViewLayoutAttributes *itemAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
        itemAttr.frame = itemFrame;
        [self.itemsLayoutAttributes setObject:itemAttr forKey:itemIndexPath];
        
        // 分页下一页 重置xy
        if ((item + 1) % (_column * _row) == 0) {
            startX += self.collectionView.bounds.size.width;
            startY = 0;
        }
        
        //        NSLog(@"index: %d,  %@", item, NSStringFromCGRect(itemFrame));
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttrs = [NSMutableArray array];
    [allAttrs addObjectsFromArray:self.itemsLayoutAttributes.allValues];
    return allAttrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGSize)collectionViewContentSize
{
    // item个数
    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSUInteger pageCount = (itemCount + (_column * _row - 1)) / (_column * _row);
    return CGSizeMake(self.collectionView.bounds.size.width * pageCount, 0);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [self.itemsLayoutAttributes objectForKey:indexPath];
    return attrs;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSLog(@"偏移: %.2f - %.2f - %@", self.collectionView.contentOffset.x, proposedContentOffset.x, NSStringFromCGPoint(velocity));
    
    CGFloat offset = ABS(proposedContentOffset.x);
    CGFloat contentW = self.collectionView.bounds.size.width;
    NSUInteger page = (offset + contentW/2.0f) / contentW;
    CGFloat targetOffset = page * self.collectionView.bounds.size.width;
    return CGPointMake(targetOffset, 0);
}




@end

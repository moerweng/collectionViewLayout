//
//  WSideGroupCollectionLayout.m
//  WheelProj
//
//  Created by Jin on 2019/5/3.
//  Copyright © 2019年 Jin. All rights reserved.
//

#import "WSideGroupCollectionLayout.h"

@interface WSideGroupCollectionLayout ()
{
    CGFloat _itemW;
    CGFloat _itemH;
    
    CGFloat _sectionStartY;
    CGFloat _itemStartY;
}
@property (nonatomic, strong) NSMutableDictionary <NSIndexPath *, UICollectionViewLayoutAttributes *> *sectionsLayoutAttributes;
@property (nonatomic, strong) NSMutableDictionary <NSIndexPath *, UICollectionViewLayoutAttributes *> *itemsLayoutAttributes;
@end

@implementation WSideGroupCollectionLayout


- (instancetype)init
{
    if (self = [super init]) {
        self.sectionsLayoutAttributes = [NSMutableDictionary dictionary];
        self.itemsLayoutAttributes = [NSMutableDictionary dictionary];
        
        self.column = 4;
        self.itemRadio = 1;
        self.sectionWidth = 80;
        self.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.sectionItemSpacing = 10;
        self.itemSpacing = 5;
        self.lineSpacing = 5;
        
        _sectionStartY = 0;
        _itemStartY = 0;
    }
    return self;
}

- (void)prepareLayout
{
    [self.sectionsLayoutAttributes removeAllObjects];
    [self.itemsLayoutAttributes removeAllObjects];
    
    _sectionStartY = 0;
    _itemStartY = 0;
    
    // 计算出item宽高
    CGFloat contentW = self.collectionView.bounds.size.width;
    CGFloat spacing = contentW - self.sectionWidth - _sectionInsets.left - _sectionInsets.right - _sectionItemSpacing - _itemSpacing * (_column - 1);
    _itemW = spacing / (CGFloat)self.column;
    _itemH = _itemW * self.itemRadio;
    
    // 组个数
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    
    for (int section = 0; section < sectionCount; section ++)
    {
        // 组内item个数
        NSUInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        // 计算当前组的frame
        CGFloat sectionX = _sectionInsets.left;
        CGFloat sectionY = _sectionStartY + _sectionInsets.top;
        NSUInteger rowCount = (itemCount + _column - 1) / _column;
        CGFloat sectionH = rowCount * _itemH + (rowCount - 1) * _lineSpacing;
        CGRect  sectionFrame = CGRectMake(sectionX, sectionY, _sectionWidth, sectionH);
        
        // 添加组的布局属性
        NSIndexPath *sectionIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        UICollectionViewLayoutAttributes *sectionAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:sectionIndexPath];
        sectionAttr.frame = sectionFrame;
        [self.sectionsLayoutAttributes setObject:sectionAttr forKey:sectionIndexPath];
        
        _itemStartY = _sectionStartY + _sectionInsets.top;//分组内item的起始Y等于分组的起始Y
        _sectionStartY = (_sectionStartY + _sectionInsets.top + sectionH + _sectionInsets.bottom);//下一个分组的起始Y
        
        for (int item = 0; item < itemCount ; item ++)
        {
            // 计算当前item的frame
            CGFloat itemX = _sectionWidth + _sectionInsets.left + _sectionItemSpacing + ((item % self.column) * _itemSpacing) + (item % self.column) * _itemW;
            CGFloat itemY = _itemStartY + (item / self.column * _lineSpacing);
            CGRect itemFrame = CGRectMake(itemX, itemY, _itemW, _itemH);
            
            // 换行Y值增加一个高度
            if ((item + 1) % self.column == 0)
            {
                _itemStartY += _itemH;
            }
            
            // 添加item的布局属性
            NSIndexPath *itemIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *itemAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
            itemAttr.frame = itemFrame;
            [self.itemsLayoutAttributes setObject:itemAttr forKey:itemIndexPath];
            
            //            NSLog(@"index: %d - %d,  %@", section, item, NSStringFromCGRect(itemFrame));
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttrs = [NSMutableArray array];
    [allAttrs addObjectsFromArray:self.sectionsLayoutAttributes.allValues];
    [allAttrs addObjectsFromArray:self.itemsLayoutAttributes.allValues];
    return allAttrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.bounds.size.width, MAX(_sectionStartY, self.collectionView.bounds.size.width));
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [self.itemsLayoutAttributes objectForKey:indexPath];
    return attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionViewLayoutAttributes *attrs = [self.sectionsLayoutAttributes objectForKey:indexPath];
        return attrs;
    }
    return nil;
}


@end

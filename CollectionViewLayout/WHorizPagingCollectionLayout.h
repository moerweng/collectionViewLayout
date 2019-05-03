//
//  WHorizPagingCollectionLayout.h
//  WheelProj
//
//  Created by Jin on 2019/5/3.
//  Copyright © 2019年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHorizPagingCollectionLayout : UICollectionViewLayout
/** 行数 */
@property (nonatomic, assign) NSUInteger row;
/** 列数 */
@property (nonatomic, assign) NSUInteger column;
/** item间隔 */
@property (nonatomic, assign) CGFloat itemSpacing;
/** item行间隔 */
@property (nonatomic, assign) CGFloat lineSpacing;
/** item与collectionView边缘间距 */
@property (nonatomic, assign) UIEdgeInsets margeInsets;
@end

NS_ASSUME_NONNULL_END

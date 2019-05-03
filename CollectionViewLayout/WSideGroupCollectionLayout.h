//
//  WSideGroupCollectionLayout.h
//  WheelProj
//
//  Created by Jin on 2019/5/3.
//  Copyright © 2019年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSideGroupCollectionLayout : UICollectionViewLayout
/** 列数 */
@property (nonatomic, assign) NSUInteger column;
/** 高宽比 */
@property (nonatomic, assign) CGFloat itemRadio;
/** 左侧组头宽度 */
@property (nonatomic, assign) CGFloat sectionWidth;
/** 组间距 */
@property (nonatomic, assign) UIEdgeInsets sectionInsets;
/** 左侧组头与item间隔 */
@property (nonatomic, assign) CGFloat sectionItemSpacing;
/** item间隔 */
@property (nonatomic, assign) CGFloat itemSpacing;
/** item行间隔 */
@property (nonatomic, assign) CGFloat lineSpacing;
@end

NS_ASSUME_NONNULL_END

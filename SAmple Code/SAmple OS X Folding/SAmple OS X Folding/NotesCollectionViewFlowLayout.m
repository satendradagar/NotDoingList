//
//  NotesCollectionViewFlowLayout.m
//  SAmple OS X Folding
//
//  Created by Satendra Dagar on 22/01/16.
//  Copyright © 2016 Satendra Dagar. All rights reserved.
//

#import "NotesCollectionViewFlowLayout.h"
#import "SACollectionViewItem.h"

@implementation NotesCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
//    
//    CGFloat halfItemWidth = 0.5 * itemSize.width;
//    CGFloat halfItemHeight = 0.5 * itemSize.height;
//    CGFloat radiusInset = sqrt(halfItemWidth * halfItemWidth + halfItemHeight * halfItemHeight);
//    circleCenter = NSMakePoint(NSMidX(box), NSMidY(box));
//    circleRadius = MIN(box.size.width, box.size.height) * 0.5 - radiusInset;
}

// A layout derived from this base class always displays all items, within the visible rectangle.  So we can implement -layoutAttributesForElementsInRect: quite simply, by enumerating all item index paths and obtaining the -layoutAttributesForItemAtIndexPath: for each.  Our subclasses then just have to implement -layoutAttributesForItemAtIndexPath:.
- (NSArray *)layoutAttributesForElementsInRect:(NSRect)rect {
    NSInteger itemCount = [[self collectionView] numberOfItemsInSection:0];
    NSMutableArray *layoutAttributesArray = [NSMutableArray arrayWithCapacity:itemCount];
    for (NSInteger index = 0; index < itemCount; index++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        NSCollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (layoutAttributes) {
            [layoutAttributesArray addObject:layoutAttributes];
        }
        
    }
    return layoutAttributesArray;
}

- (NSCollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = [[self collectionView] numberOfItemsInSection:0];
    if (count == 0) {
        return nil;
    }
    
    NSUInteger itemIndex = [indexPath item];
    CGFloat angleInRadians = ((CGFloat)itemIndex / (CGFloat)count) * (2.0 * M_PI);
    NSPoint subviewCenter = NSMakePoint(0, 0);

    if (itemIndex) {
        
        NSCollectionViewItem *item = [self.collectionView itemAtIndex:itemIndex-1];
        CGFloat heightSum = 0;
        for (int i = 0; i < itemIndex; i++) {
            CollectionItemModel *itemModel = [self.list objectAtIndex:i];
            if (itemModel.state) { // for one only
                
                heightSum += itemModel.cellHeight;

            }
        }
        subviewCenter = item.view.frame.origin;
        subviewCenter.y = heightSum;
    }
    CollectionItemModel *itemModel = [self.list objectAtIndex:itemIndex];
    if (0==itemModel.state) {
        subviewCenter.y -= 10.5;//stack over the view
    }
//    subviewCenter.x = circleCenter.x + circleRadius * cos(angleInRadians);
//    subviewCenter.y = circleCenter.y + circleRadius * sin(angleInRadians);
    NSRect itemFrame = NSMakeRect(subviewCenter.x , subviewCenter.y , self.collectionView.frame.size.width, itemModel.cellHeight);
    
    NSCollectionViewLayoutAttributes *attributes = [[[self class] layoutAttributesClass] layoutAttributesForItemWithIndexPath:indexPath];
    [attributes setFrame:NSRectToCGRect(itemFrame)];
    [attributes setZIndex:itemIndex];
    return attributes;
}

@end

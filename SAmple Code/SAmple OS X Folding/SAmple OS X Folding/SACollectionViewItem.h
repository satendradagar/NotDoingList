//
//  SACollectionViewItem.h
//  SAmple OS X Folding
//
//  Created by Satendra Dagar on 21/01/16.
//  Copyright © 2016 Satendra Dagar. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SSFoldingView.h"
#import "AppDelegate.h"

@interface SACollectionViewItem : NSCollectionViewItem

@property (nonatomic, weak) IBOutlet SSFoldingView *foldingLayer;
-(void) confighureViewWithModel:(CollectionItemModel *) modelObject;

-(void) unfoldViewItem;

@end

//
//  AppDelegate.m
//  SAmple OS X Folding
//
//  Created by Satendra Dagar on 17/01/16.
//  Copyright © 2016 Satendra Dagar. All rights reserved.
//

#import "AppDelegate.h"
#import "SSFoldingView.h"
#import "SACollectionViewItem.h"
#import "NotesCollectionViewFlowLayout.h"

@interface AppDelegate ()<NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout>

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet SSFoldingView *foldingView;

@property (nonatomic, retain) NSMutableArray *list;

- (IBAction)didDraggedPan:(id)sender;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _list = [NSMutableArray new];
    [_list addObject:[CollectionItemModel itemInstance:@"Item one"]];
    [_list addObject:[CollectionItemModel itemInstance:@"Item two"]];
    [_list addObject:[CollectionItemModel itemInstance:@"Item three"]];
    [_list addObject:[CollectionItemModel itemInstance:@"Item four"]];
    [_list addObject:[CollectionItemModel itemInstance:@"Item five"]];
    [_list addObject:[CollectionItemModel itemInstance:@"Item six"]];
    [_list addObject:[CollectionItemModel itemInstance:@"Item seven"]];
    [_list addObject:[CollectionItemModel itemInstance:@"Item eight"]];
    [_list addObject:[CollectionItemModel itemInstance:@"Item nine"]];
//    [self.collectionView registerNib:[[NSNib alloc] initWithNibNamed:@"SACollectionViewItem" bundle:nil] forItemWithIdentifier:@"SACollectionViewItem"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView reloadData];
    [self.foldingView setEndPointPosition: NSMakePoint(240.359375, 385.62109375)];

//    [self performSelector:@selector(setNewPoint) withObject:nil afterDelay:2];

    // Insert code here to initialize your application
    NotesCollectionViewFlowLayout *circularLayout = [[NotesCollectionViewFlowLayout alloc] init];
    circularLayout.list = self.list;
    if (NSAnimationContext.currentContext.duration > 0.0) {
        NSAnimationContext.currentContext.duration = 0.5;
        self.collectionView.animator.collectionViewLayout = circularLayout;
    } else {
        self.collectionView.animator.collectionViewLayout = circularLayout;
    }
//    self.collectionView.collectionViewLayout = circularLayout;
}

-(void)applicationDidBecomeActive:(NSNotification *)notification
{
//    [self.foldingView flipAnimationOutwards];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)didDraggedPan:(NSPanGestureRecognizer *)gesture {
    
    NSPoint loc = [gesture locationInView:self.window.contentView];
    
    [self.foldingView setEndPointPosition:loc];
}

/*
 NSCollectionViewItem *item = [collectionView makeItemWithIdentifier:@"Slide" forIndexPath:indexPath];
 AAPLImageFile *imageFile = [self imageFileAtIndexPath:indexPath];

 */


#pragma mark NSCollectionViewDataSource Methods

// Each of these methods checks whether "groupByTag" is on, and modifies its behavior accordingly.

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _list.count;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
    // Message back to the collectionView, asking it to make a @"Slide" item associated with the given item indexPath.  The collectionView will first check whether an NSNib or item Class has been registered with that name (via -registerNib:forItemWithIdentifier: or -registerClass:forItemWithIdentifier:).  Failing that, the collectionView will search for a .nib file named "Slide".  Since our .nib file is named "Slide.nib", no registration is necessary.
    SACollectionViewItem *item = [collectionView makeItemWithIdentifier:@"SACollectionViewItem" forIndexPath:indexPath];
    CollectionItemModel *itemModel = [_list objectAtIndex:indexPath.item];
    item.textField.stringValue = itemModel.message;

//    if (itemModel.state) {
    
        [item confighureViewWithModel:itemModel];
        
//    }
    
//    item.textField.stringValue = @"";

    return item;
}

- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionItemModel *itemModel = [_list objectAtIndex:indexPath.item];
    return  NSMakeSize(self.collectionView.bounds.size.width, itemModel.cellHeight);

}

- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths;
{
    CollectionItemModel *itemModel = [_list objectAtIndex:[indexPaths.allObjects firstObject].item];
    itemModel.cellHeight = 80;
    itemModel.state = 1;
    
    SACollectionViewItem *item = (SACollectionViewItem *)[collectionView itemAtIndex:[indexPaths.allObjects firstObject].item];
//    NSRect frame = item.view.frame;
//    frame.size.height = 80;
    [item unfoldViewItem];
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:1.0];
//    [item.view.animator setFrame:frame];

    [self.collectionView.animator deleteItemsAtIndexPaths:indexPaths];
    [self.collectionView.animator insertItemsAtIndexPaths:indexPaths];

    [NSAnimationContext endGrouping];
    [item performSelector:@selector(confighureViewWithModel:) withObject:itemModel afterDelay:1.0];
    [self.collectionView.collectionViewLayout invalidateLayout];
//    [item confighureViewWithModel:itemModel];

//    [NSAnimationContext beginGrouping];
//    [[NSAnimationContext currentContext] setDuration:2.0];
//    if (itemModel.state) {
    
//    [NSAnimationContext endGrouping];

//    }

//    [self.collectionView.animator.collectionViewLayout invalidateLayout];

//    } else {
//    }

    
}

-(IBAction)changeFlowLayout:(id)sender{
    
    NotesCollectionViewFlowLayout *circularLayout = [[NotesCollectionViewFlowLayout alloc] init];
    circularLayout.list = self.list;
//    if (NSAnimationContext.currentContext.duration > 0.0) {
        NSAnimationContext.currentContext.duration = 1.0;
        self.collectionView.animator.collectionViewLayout = circularLayout;
//    } else {
//        self.collectionView.animator.collectionViewLayout = circularLayout;
//    }

}

-(IBAction)insertNewItemInCollection:(id)sender{

    CollectionItemModel *modelItem = [CollectionItemModel itemInstance:@""];
    modelItem.state = 0;
    modelItem.cellHeight = 21;
    [_list insertObject:modelItem atIndex:3];
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:1.0];
    [self.collectionView.animator insertItemsAtIndexPaths:[NSSet setWithObject:[NSIndexPath indexPathForItem:3 inSection:0]]];
    [NSAnimationContext endGrouping];

}



@end

@implementation CollectionItemModel

+(instancetype )itemInstance:(NSString *)msg
{
    CollectionItemModel *modelItem = [CollectionItemModel new];
    modelItem.state = 1;
    modelItem.cellHeight = 80;
    modelItem.message = msg;
    return modelItem;
}


@end
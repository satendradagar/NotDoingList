//
//  SACollectionViewItem.m
//  SAmple OS X Folding
//
//  Created by Satendra Dagar on 21/01/16.
//  Copyright © 2016 Satendra Dagar. All rights reserved.
//

#import "SACollectionViewItem.h"
#import "SSFoldingView.h"

@interface SACollectionViewItem ()

@end

@implementation SACollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.borderWidth = 1.0;
//    [(SSFoldingView *)self.view setEndPointPosition: NSMakePoint(240.359375, 385.62109375)];
    
//    [self performSelector:@selector(setNewPoint) withObject:nil afterDelay:2];

    // Do view setup here.
}

-(void) confighureViewWithModel:(CollectionItemModel *) modelObject
{
    if (modelObject.state) {
        [self unfoldViewItem];
    }
    else{
        NSPoint origin = self.foldingLayer.frame.origin;
        origin.y +=60;
//        NSLog(@"origin:%@",NSStringFromPoint(self.foldingLayer.frame.origin));
        
        [(SSFoldingView *)self.foldingLayer setEndPointPosition: origin];

    }
}

-(void)viewDidAppear{
    [super viewDidAppear];

//    [self performSelector:@selector(setNewPoint) withObject:nil afterDelay:2];
    NSPoint origin = self.foldingLayer.frame.origin;
    origin.y +=60;
    NSLog(@"origin:%@",NSStringFromPoint(self.foldingLayer.frame.origin));
    
    [(SSFoldingView *)self.foldingLayer setEndPointPosition: origin];
        self.foldingLayer.layer.borderColor = [NSColor yellowColor].CGColor;

}

-(void) unfoldViewItem{
    
//    [(SSFoldingView *)self.view horizontalFoldWithDegreeAngle:90 andForce:NO];
    NSPoint origin = self.foldingLayer.frame.origin;
    origin.y +=0;
    NSLog(@"origin:%@",NSStringFromPoint(self.foldingLayer.frame.origin));
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:1.0];
    [(SSFoldingView *)self.foldingLayer.animator setEndPointPosition: origin];
    [NSAnimationContext endGrouping];

//    self.view.layer.borderColor = [NSColor clearColor].CGColor;

    
}
//
//- (id) animationForKey:(NSString *) key
//{
//    return nil;
//}

@end

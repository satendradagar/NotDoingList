//
//  SSFoldingView.h
//  SAmple OS X Folding
//
//  Created by Satendra Dagar on 17/01/16.
//  Copyright © 2016 Satendra Dagar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SSFoldingView : NSView
{
    CALayer                *_main3DLayer;
    
    CGSize                  _initialSizeView;
    CGSize                  _currentSize;
    NSInteger               _numberOfFolds;
    
    NSArray                *_layerFolds;
    NSArray                *_shadowLayerFolds;
    IBOutlet NSImageView *imgView;
}

-(void) addFoldingAnimation;

- (void)flipAnimationOutwards;

-(void) setEndPointPosition:(CGPoint)point;

@end

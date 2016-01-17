//
//  SSFoldingView.m
//  SAmple OS X Folding
//
//  Created by Satendra Dagar on 17/01/16.
//  Copyright © 2016 Satendra Dagar. All rights reserved.
//

#import "SSFoldingView.h"
#import <QuartzCore/CoreAnimation.h>

@implementation SSFoldingView
{
    CALayer *subLayer;
    CGColorRef color;
}
- (void)drawRect:(NSRect)dirtyRect {
    
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)awakeFromNib
{
    //Create a sublayer
    [self setWantsLayer:YES];
    _initialSizeView=self.frame.size;
    _currentSize=_initialSizeView;
    _numberOfFolds = 2;

//    subLayer = [CALayer layer];
//    subLayer.frame = CGRectMake(10, 10, 150, 100);
//    subLayer.position = CGPointMake(100, 100);
//    color = CGColorCreateGenericRGB(0.3, 0.3, 0.3, 1);
//    subLayer.borderColor = color;
//    subLayer.anchorPoint=CGPointMake(0.5, 0.0);
//
//    CGColorRelease(color);
//    subLayer.borderWidth = 2.0;
//    color = CGColorCreateGenericRGB(1, 1, 1, 1);
//    subLayer.backgroundColor = color;
//    CGColorRelease(color);
//    [self.layer addSublayer:subLayer];
//    self.layer.backgroundColor = [NSColor yellowColor].CGColor;

    [self initialize];
    [self horizontalFoldWithHeight:70 andForce:YES];
    imgView.image = nil;
//    [self configurePerspectiveAnimation];
}
-(void) addFoldingAnimation
{
//    //Create a 3D perspective transform
//    CATransform3D t = CATransform3DIdentity;
//    t.m34 = 1.0 / -900.0;
//    
//    //Rotate and reposition the camera
//    t = CATransform3DTranslate(t, 0, 40, -210);
//    t = CATransform3DRotate(t, 0.3, 1.0, -1.0, 0);
//
//    //Transform matrix to be used for camera animation
//    t = CATransform3DMakeRotation(1, 0, 1, 0);
//    
//    //Animate the camera panning left and right continuously
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.fromValue = [NSValue valueWithCATransform3D: CATransform3DIdentity];
//    animation.toValue = [NSValue valueWithCATransform3D: t];
//    animation.duration = 5;
////    animation.removedOnCompletion = NO;
//    animation.autoreverses = YES;
//    animation.repeatCount = 1e100f;
//    animation.fillMode = kCAFillModeForwards;
//    [subLayer addAnimation:animation forKey:@"transform"];
//    
//
    
    
//    return;
    //Create the transform matrix for the animation
    
    //Move forward 1000 units along z-axis
     CATransform3D t = CATransform3DMakeTranslation( 0, 0, 1000);
    
    //Rotate Pi radians about the axis (0.7, 0.3, 0.0)
    t = CATransform3DRotate(t, M_PI, 0.7, 0.3, 0.0);
    
    //Scale the X and Y dimmensions by a factor of 3
    t = CATransform3DScale(t, 3, 3, 1);
//
    //Transform Animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.fromValue = [NSValue valueWithCATransform3D: CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: t];
    animation.duration = 1.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    [subLayer addAnimation:animation forKey:@"transform"];
    
    //Opacity Animation
    animation = [CABasicAnimation animation];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.duration = 1.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    [subLayer addAnimation:animation forKey:@"opacity"];
}

- (void)flipAnimationOutwards{
    // Set correct image
//    if (self.faceUp){
//        [self setImage:self.faceImage];
//    }else{
//        [self setImage:[NSImage imageNamed:@"Card_Background"]];
//    }
//    
    // Animate shadow
    NSShadow *dropShadow = [[NSShadow alloc] init];
    [dropShadow setShadowOffset:NSMakeSize(0, 1)];
    [dropShadow setShadowBlurRadius:0];
    [dropShadow setShadowColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.0]];
    [[self animator] setShadow:dropShadow];
    
    // Create CAAnimation
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat: M_PI/2];
    rotationAnimation.toValue = [NSNumber numberWithFloat: 0];
    rotationAnimation.duration = 3.1;
    rotationAnimation.repeatCount = 2.0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode = kCAFillModeForwards;
//    rotationAnimation.removedOnCompletion = YES;
    [rotationAnimation setValue:@"flipAnimationOutwards" forKey:@"flip"];
    rotationAnimation.delegate = self;
    
    // Get the layer
    CALayer* lr = [self layer];
    
    // Add perspective
    CATransform3D mt = CATransform3DIdentity;
    mt.m34 = 1.0/1000; // note the lack of a minus sign
//    subLayer.transform = mt;
    subLayer.zPosition = 999;

    mt = CATransform3DRotate(mt, M_PI / 3, 1, 0, 0);
    subLayer.transform = mt;
    // Set z position so the layer will be on top
    
//    // Keep cards tilted when flipping
//    if(self.tiltCard)
//        self.frameCenterRotation = self.frameCenterRotation;
//    
    // Commit animation
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/1000;
//
//    // Apply the transform to a parent layer.
//    self.layer.sublayerTransform = perspective;
//    [lr addAnimation:rotationAnimation forKey:@"flip"];
}

- (void)configurePerspectiveAnimation
{
    // Get the layer
    CALayer* lr = _main3DLayer;
    
    // Add perspective
    CATransform3D mt = CATransform3DIdentity;
    mt.m34 = 1.0/1000; // note the lack of a minus sign
    //    subLayer.transform = mt;
    lr.zPosition = 1999;

    mt = CATransform3DRotate(mt, M_PI / 3, 1, 0, 0);
    lr.transform = mt;

}
-(void) initialize{
    if (!_main3DLayer){
        NSImage *viewSnapShot = [self snapshot];
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0/700.0;
        _main3DLayer = [CALayer layer] ;
        _main3DLayer.frame = self.bounds;
        _main3DLayer.backgroundColor = [NSColor colorWithWhite:0.2 alpha:0.0].CGColor;
        _main3DLayer.sublayerTransform = transform;
        [_main3DLayer setHidden:YES];
        [self.layer addSublayer:_main3DLayer];
        
        
        CGFloat partHeight=self.bounds.size.height/_numberOfFolds;
        CGFloat partWidth=self.bounds.size.width/_numberOfFolds;
        
        
        NSMutableArray *tmpLayer=[NSMutableArray array];
        NSMutableArray *tmpShadow=[NSMutableArray array];
        for (int i=0;i<_numberOfFolds;i++){
            CGRect frame=CGRectZero;
            

                frame=CGRectMake(0, i*partHeight, self.bounds.size.width, partHeight);
            
            CGImageRef imageCrop = [self nsImageToCGImageRef:viewSnapShot];
            CALayer *imageCroppedLayer = [CALayer layer];
            imageCroppedLayer.frame=frame;
            
            if (1){
                imageCroppedLayer.anchorPoint=CGPointMake(0.5, (i%2==0)?0.0:1.0);
                imageCroppedLayer.position=CGPointMake(imageCroppedLayer.position.x,(i%2==0)?(imageCroppedLayer.position.y-imageCroppedLayer.bounds.size.height/2):imageCroppedLayer.position.y+imageCroppedLayer.bounds.size.height/2);
            }
            imageCroppedLayer.contents=(__bridge id)imageCrop;
            [tmpLayer addObject:imageCroppedLayer];
            
            
            CAGradientLayer *shadowLayer = [CAGradientLayer layer];
            shadowLayer.frame = imageCroppedLayer.bounds;
            shadowLayer.opacity = 0;
            shadowLayer.colors = [NSArray arrayWithObjects:(id)[NSColor blackColor].CGColor, (id)[NSColor clearColor].CGColor, nil];
            
            
            if (i%2) {
                shadowLayer.startPoint = CGPointMake(0.5, 0);
                shadowLayer.endPoint = CGPointMake(0.5, 0.5);
            }
            else {
                shadowLayer.startPoint = CGPointMake(0.5, 0.5);
                shadowLayer.endPoint = CGPointMake(0.5, 0.0);
            }
            shadowLayer.shouldRasterize=YES;
            [imageCroppedLayer addSublayer:shadowLayer];
            
            [tmpShadow addObject:shadowLayer];
            
            
            [_main3DLayer addSublayer:imageCroppedLayer];
        }
        
        _layerFolds=tmpLayer ;
        _shadowLayerFolds=tmpShadow ;
    }
}

-(void) horizontalFoldWithHeight:(CGFloat)height andForce:(BOOL)force{
    [self initialize];
    
    if (height+10>=_initialSizeView.height)height=_initialSizeView.height;
    
    
    if (_currentSize.height!=height || force){
        _currentSize.height=height;
        if (_currentSize.height<=_initialSizeView.height){
            
                for (int i=0;i<[_layerFolds count];i++){
                    [self setPropertyToLayer:[_layerFolds objectAtIndex:i] withShadow:[_shadowLayerFolds objectAtIndex:i]
                                  withHeight:height
                                       ofIdx:i];
            }
        }
    }
    
}


-(void) setPropertyToLayer:(CALayer*)layer withShadow:(CALayer*)shadow withHeight:(CGFloat)height ofIdx:(NSInteger)idx{
    float heightPartCurr=height/_numberOfFolds;
    float heightPartInitial=_initialSizeView.height/_numberOfFolds;
    float percentOfHeight=(height/_initialSizeView.height);
    shadow.opacity=1.0-percentOfHeight;
    
    CGPoint posCurr=layer.position;
    
    

    if (idx<([_layerFolds count]-1)){
        posCurr.y=heightPartCurr*idx+(_initialSizeView.height-_currentSize.height);
        if (layer.anchorPoint.y==1.0)posCurr.y+=heightPartCurr;
    }
    
    layer.position=posCurr;
    
    float angle2=acos(heightPartCurr/heightPartInitial);
    if (idx%2==0)angle2=angle2*-1;
    CATransform3D transform=CATransform3DIdentity;
    transform=CATransform3DRotate(transform, angle2, 1.0, 0.0, 0);
    layer.transform=transform;
    [_main3DLayer setHidden:NO];
    [self.layer setNeedsDisplay];
}

-(void) horizontalFoldWithHeight:(CGFloat)height{
    [self horizontalFoldWithHeight:height andForce:NO];
}

-(void) setEndPointPosition:(CGPoint)point{
    BOOL opened=NO;
    BOOL closed=NO;
    
    
    if (1){
        float height=0;
        
        if (/* DISABLES CODE */ (0))
            height=point.y-self.frame.origin.y;
        if (1)
            height=self.bounds.size.height-(point.y-self.frame.origin.y);
        
        
        if (height+10>=_initialSizeView.height){
            height=_initialSizeView.height;
            opened=YES;
        }
        
        if (height-10<=0){
            height=10;
            closed=YES;
        }
        [self horizontalFoldWithHeight:height];
    }
    
}



-(NSImage *)snapshot
{
    return [[NSImage alloc] initWithData:[self dataWithPDFInsideRect:[self bounds]]];

}

- (CGImageRef)nsImageToCGImageRef:(NSImage*)image;
{
    NSData * imageData = [image TIFFRepresentation];
    CGImageRef imageRef;
    if(!imageData) return nil;
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
    imageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    return imageRef;
}

@end

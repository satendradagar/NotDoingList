//
//  AppDelegate.m
//  SAmple OS X Folding
//
//  Created by Satendra Dagar on 17/01/16.
//  Copyright © 2016 Satendra Dagar. All rights reserved.
//

#import "AppDelegate.h"
#import "SSFoldingView.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (weak) IBOutlet SSFoldingView *foldingView;

- (IBAction)didDraggedPan:(id)sender;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

-(void)applicationDidBecomeActive:(NSNotification *)notification
{
//    [self.foldingView flipAnimationOutwards];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)didDraggedPan:(NSPanGestureRecognizer *)gesture {
    
    NSPoint loc = [gesture locationInView:self.foldingView];
    [self.foldingView setEndPointPosition:loc];
}
@end

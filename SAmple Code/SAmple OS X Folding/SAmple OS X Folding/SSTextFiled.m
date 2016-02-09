//
//  SSTextFiled.m
//  SAmple OS X Folding
//
//  Created by Satendra Dagar on 25/01/16.
//  Copyright © 2016 Satendra Dagar. All rights reserved.
//

#import "SSTextFiled.h"

@implementation SSTextFiled

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.delegate = self;
//    [self becomeFirstResponder];
//    self.selectable = NO;
//    self.editable = YES;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


- (BOOL)textShouldBeginEditing:(NSText *)textObject
{
    NSLog(@"%s",_cmd);
    return YES;
}
- (BOOL)control:(NSControl *)control textView:(NSTextField *)fieldEditor doCommandBySelector:(SEL)commandSelector {
    NSLog(@"%s",_cmd);
    BOOL retval = NO;
    if (commandSelector == @selector(insertNewline:)) {
        retval = NO;
//        [self.window resignFirstResponder];
        [[self window] makeFirstResponder:nil];
    }
    return retval;
}

- (void)textDidChange:(NSNotification *)notification;
{
    NSLog(@"%s",_cmd);
 
}

-(BOOL)textShouldEndEditing:(NSText *)textObject {
    NSLog(@"%s",_cmd);

    return YES;
    NSEvent * event = [[NSApplication sharedApplication] currentEvent];
    if ([event type] == NSKeyDown && [event keyCode] == 36)
    {
//        [[self window] makeFirstResponder:nil];

//        [textObject insertNewlineIgnoringFieldEditor:nil];
        return YES;
    }
    else
    {
        return [super textShouldEndEditing:textObject];
    }
    
}

@end

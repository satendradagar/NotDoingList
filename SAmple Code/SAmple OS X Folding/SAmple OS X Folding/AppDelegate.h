//
//  AppDelegate.h
//  SAmple OS X Folding
//
//  Created by Satendra Dagar on 17/01/16.
//  Copyright © 2016 Satendra Dagar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, weak) IBOutlet NSCollectionView *collectionView;

@end

@interface CollectionItemModel : NSObject

@property (nonatomic, strong) NSString *message;

@property (nonatomic, assign) NSUInteger state;

@property (nonatomic, assign) CGFloat cellHeight;

+(instancetype )itemInstance:(NSString *)msg;

@end
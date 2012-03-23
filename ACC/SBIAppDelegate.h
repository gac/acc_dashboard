//
//  SBIAppDelegate.h
//  ACC
//
//  Created by Juan Galicia Castillo on 3/22/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBIViewController;
@class RootViewController;
@class DetailViewController;

@interface SBIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) SBIViewController *viewController;

@property (nonatomic, retain)  UISplitViewController *splitViewController;
@property (nonatomic, retain)  RootViewController *rootViewController;
@property (nonatomic, retain)  DetailViewController *detailViewController;

@property (nonatomic, assign) UIBarButtonItem *rootPopoverButtonItem;


@end

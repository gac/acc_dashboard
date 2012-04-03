//
//  SBIAppDelegate.h
//  ACC
//
//  Created by Juan Galicia Castillo on 3/22/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBILoginViewController;
@class RootViewController;
@class DetailViewController;

@interface SBIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) SBILoginViewController *viewController;

@property (strong, nonatomic)  UISplitViewController *splitViewController;
@property (strong, nonatomic)  RootViewController *rootViewController;
@property (strong, nonatomic)  DetailViewController *detailViewController;

@property (strong, nonatomic) UIBarButtonItem *rootPopoverButtonItem;

@end
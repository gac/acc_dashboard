//
//  RootViewController.h
//  NavigatorSplitView
//
//  Created by Kshitiz Ghimire on 1/26/11.
//  Copyright 2011 Kshitiz Ghimire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBIAppDelegate.h"
@class DetailViewController;

@interface RootViewController : UITableViewController 

@property (nonatomic, retain)  DetailViewController *detailViewController;

@property (nonatomic, assign) SBIAppDelegate *appDelegate;

@end
